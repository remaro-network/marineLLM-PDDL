import os
import re
import pandas as pd
from dotenv import load_dotenv
from langchain_openai import OpenAIEmbeddings, ChatOpenAI
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_chroma import Chroma
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_community.document_loaders import PyMuPDFLoader

load_dotenv(dotenv_path=os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '.env'))

absolute_path = os.getcwd()
absolute_path = "/home/mahya/Desktop/ARC/Projects/marineLLM-PDDL"
folder_path = absolute_path + "/documents" + "/Kiel/geomar/"
print(absolute_path)

MAX_RETRIES = 2

DONT_KNOW_PHRASES = [
    "i don't know",
    "i do not know",
    "i'm not sure",
    "not sure",
    "the context does not",
    "the context doesn't",
    "no information",
    "not provided",
    "not specified",
    "unclear",
    "cannot determine",
]


def is_dont_know(answer: str) -> bool:
    a = answer.lower()
    return any(p in a for p in DONT_KNOW_PHRASES)


def has_expected_format(answer: str) -> bool:
    return re.search(r'\*[^*]+\*', answer) is not None


def evaluate(answer: str):
    if is_dont_know(answer):
        return False, "the previous answer said you do not know — re-read the context more carefully and extract any partial information available"
    if not has_expected_format(answer):
        return False, "the previous answer did not follow the required format (each bullet wrapped in asterisks, e.g. *item one*)"
    return True, ""


system_prompt = (
    "You are an assistant for question-answering tasks. "
    "Use the following pieces of retrieved context to answer the question. "
    "If you genuinely cannot find the answer in the context, say 'I don't know'. "
    "Format every bullet of your answer wrapped in asterisks like *bullet text*. "
    "Keep each bullet to a few words.\n\n"
    "{context}"
)

refine_system_prompt = (
    "You are refining a previous answer that was unsatisfactory. "
    "Use the retrieved context below to produce a better answer to the original question. "
    "Reason it was rejected: {reason}\n"
    "Previous answer: {prior_answer}\n\n"
    "Format every bullet wrapped in asterisks like *bullet text*. "
    "Keep each bullet to a few words.\n\n"
    "{context}"
)

initial_prompt = ChatPromptTemplate.from_messages(
    [("system", system_prompt), ("human", "{input}")]
)

refine_prompt = ChatPromptTemplate.from_messages(
    [("system", refine_system_prompt), ("human", "{input}")]
)

llm = ChatOpenAI(model="gpt-4o")


def format_docs(docs):
    return "\n\n".join(doc.page_content for doc in docs)


def build_chains(retriever):
    initial_chain = (
        {"context": retriever | format_docs, "input": RunnablePassthrough()}
        | initial_prompt
        | llm
        | StrOutputParser()
    )

    refine_chain = (
        {
            "context": (lambda x: x["input"]) | retriever | format_docs,
            "input": lambda x: x["input"],
            "prior_answer": lambda x: x["prior_answer"],
            "reason": lambda x: x["reason"],
        }
        | refine_prompt
        | llm
        | StrOutputParser()
    )

    return initial_chain, refine_chain


def answer_with_retries(initial_chain, refine_chain, question):
    answer = initial_chain.invoke(question)
    ok, reason = evaluate(answer)
    attempts = 1

    while not ok and attempts <= MAX_RETRIES:
        answer = refine_chain.invoke(
            {"input": question, "prior_answer": answer, "reason": reason}
        )
        ok, reason = evaluate(answer)
        attempts += 1

    return answer, attempts, ok


def process_pdf_files(folder_path, question, csv_filename):
    df = pd.DataFrame(columns=['filename', 'question', 'result', 'feedback'])

    counter = 0
    for filename in os.listdir(folder_path):
        if not filename.endswith(".pdf"):
            continue

        counter += 1
        pdf_path = os.path.join(folder_path, filename)

        print(filename)
        loader = PyMuPDFLoader(pdf_path)
        documents = loader.load()

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents(documents)
        vectorstore = Chroma.from_documents(documents=splits, embedding=OpenAIEmbeddings())
        retriever = vectorstore.as_retriever()

        initial_chain, refine_chain = build_chains(retriever)
        answer, attempts, ok = answer_with_retries(initial_chain, refine_chain, question)

        df.loc[counter, 'filename'] = filename
        df.loc[counter, 'question'] = question
        df.loc[counter, 'result'] = answer
        df.loc[counter, 'feedback'] = attempts if ok else 0

        for item in re.findall(r'\*([^*]+)\*', answer):
            if len(item) > 3:
                print(item)

        df.to_csv(csv_filename, index=False)

        vectorstore.delete_collection()

    return df


questions = {
    "Q1": "What is vehicle vessel name?",
    "Q2": "What is vehicle or vessel type?",
    "Q3": "What is the main purpose of the cruise report?",
    "Q4": "What is the duration of the mission?",
    "Q5": "What are the existing tasks in this mission, the duration of each "
          "task, and whether the task was successful or a failure?",
    "Q6": "What are all the tasks in this mission?",
    "Q7": "What components/devices/sensors were used in this mission and for "
          "how long?",
    "Q8": "What is the application of the mission?",
    "Q9": "What is the mission location?",
    "Q10": "What is the visibility of the environment, and how can we measure "
           "it?",
    "Q11": "What is the signal acoustic condition/ multibeam?",
    "Q12": "What is the temperature of water on the surface?",
    "Q13": "What is the temperature of water at different depths?",
}

ordered_keys = ["Q5"] + [k for k in questions if k != "Q5"]

for q_label in ordered_keys:
    csv_filename = absolute_path + "/datasets" + "/CuratedQAs/Geomar-Kiel/" + 'scenario_extraction{}.csv'.format(q_label)
    # csv_filename = absolute_path + "/datasets" + "/CuratedQAs/NOAA/" + 'scenario_extraction{}.csv'.format(q_label)

    df = process_pdf_files(folder_path, questions[q_label], csv_filename)
    df.to_csv(csv_filename, index=False)
