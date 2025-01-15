import os
import re
import random
import pandas as pd 
# from langchain.document_loaders import PyPDFLoader
from langchain_community.document_loaders import PyPDFLoader
# from langchain.chains import ConversationalRetrievalChain
# from langchain.embeddings.openai import OpenAIEmbeddings
from langchain_community.embeddings import OpenAIEmbeddings
# from langchain.vectorstores import FAISS
# from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_chroma import Chroma
from langchain_openai import ChatOpenAI
from langchain.chains import create_retrieval_chain
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.prompts import ChatPromptTemplate

# Path to the folder containing PDF files
"""
first download pdf documents and store them in folders like 'US' and 'Kiel/geomar
"""

absolute_path = os.getcwd()
# folder_path = absolute_path + "/Kiel/geomar/"
folder_path = absolute_path + "documents/US"

# OpenAI API key (set your OpenAI API key here)

os.environ["OPENAI_API_KEY"] = "FILL_THIS_OUT"

df = pd.DataFrame(columns=['filename', 'question','result', 'feedback'])

# Function to process each PDF file, load it, and ask a question
def process_pdf_files(folder_path, question, csv_filename):
    results = {}
    
    # Iterate over each PDF file in the folder
    counter = 0
    for filename in os.listdir(folder_path):
        counter +=1
        df.loc[counter, 'question'] = question
        df.loc[counter, 'filename'] = filename

        if filename.endswith(".pdf"):
            pdf_path = os.path.join(folder_path, filename)
            
            print(filename)
            # Load the PDF file using PyPDFLoader
            loader = PyPDFLoader(pdf_path)
            documents = loader.load()

            # Create embeddings and FAISS index for document retrieval
            
            text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
            splits = text_splitter.split_documents(documents)
            vectorstore = Chroma.from_documents(documents=splits, embedding=OpenAIEmbeddings())
            retriever = vectorstore.as_retriever() #search_kwargs={"k": 5}

            # Setup the conversational retrieval chain
            llm = ChatOpenAI(model="gpt-4o")


            system_prompt = (
               "You are an assistant for question-answering tasks. "
               "Use the following pieces of retrieved context to answer "
               "the question. If you don't know the answer, say that you "
               "don't know. list your answer in between two asterisks that "
               "each response in bullet list. "
               "Answer in a few words at most 1 sentences" 
               # # with calculation of hours
               # " if it is not in the context say I don't know"
               "\n\n"
               "{context}"
            )

            prompt = ChatPromptTemplate.from_messages(
               [
                  ("system", system_prompt),
                  ("human", "{input}"),
               ]
            )
            # chain = ConversationalRetrievalChain.from_llm(llm, retriever=vectorstore.as_retriever())
            question_answer_chain = create_stuff_documents_chain(llm, prompt)
            rag_chain = create_retrieval_chain(retriever, question_answer_chain)

            # Initialize an empty chat history
            chat_history = []

            rand_num = random.randint(100, 999)
            txt = "abc"
            session_id = txt + str(rand_num)
            results = rag_chain.invoke({"input": question, "chat_history": chat_history},
                                       config={"configurable": {"session_id": session_id}})
            # print(results)
            match = re.findall(r'\**([^\*]*)\**', results["answer"])

            df.loc[counter, 'result'] = results["answer"]
            df.loc[counter, 'feedback'] = 1

            for item in match:
               if len(item)>3:
                  print(item)
            
            results = {}
            df.to_csv(csv_filename, index=False) 
            # break

    return results, df

# Set the question you want to ask
question =   "What are the existing tasks in this mission, the duration of each task, and whether the task was successful or failure?"
csv_filename = "results/NOAA"+'scenario_extractionQ5.csv'

# Process all PDF files and ask the question
answers, df = process_pdf_files(folder_path, question, csv_filename)
df.to_csv(csv_filename, index=False) 
