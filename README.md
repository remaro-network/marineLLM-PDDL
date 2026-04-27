# MarineLLM-PDDL v1.1

**Translating Marine Mission Reports into PDDL with Large Language Models**


---

## Table of Contents

1. [Research Questions](#1-research-questions)
2. [System Architecture](#2-system-architecture)
3. [Methodology](#3-methodology)
4. [Evaluation Framework](#4-evaluation-framework)
5. [Repository Structure](#5-repository-structure)
6. [Datasets](#6-datasets)
7. [Installation](#7-installation)
8. [Usage](#8-usage)
9. [Results](#9-results)
10. [Acknowledgements](#10-acknowledgements)

---

### Background

Autonomous Underwater Vehicles (AUVs) and marine research vessels accumulate knowledge through missions documented in **Incident Response Plans (IRPs)** or **cruise reports**. These documents describe, in natural language, what equipment was deployed, what tasks were executed, how long each task took, and whether the task succeeded or failed. This accumulated operational knowledge is a rich but largely untapped resource for generating realistic planning scenarios.

Planning Domain Definition Language (**PDDL**) provides a formal, constraint solver-ready representation of such scenarios. A PDDL domain encodes what actions are possible; a PDDL problem encodes the concrete objects, initial state, and goal. Automated planners (FastForward, LPG-td, Optic-clp, etc.) then find executable action sequences — plans — that transition the system from the initial to the goal state.

### The Task: Natural Language → PDDL Translation

MarineLLM-PDDL treats PDDL generation as a **code-translation problem**: given the free text of a cruise report, an LLM must produce a `domain.pddl` and `problem.pddl` pair that correctly captures the mission's types, predicates, actions, preconditions, and effects.

```
IRP / cruise report text  ──►  LLM translator  ──►  domain.pddl + problem.pddl
                                                         │
                                                         ▼
                                                  classical planner
                                                         │
                                                         ▼
                                                    timed plan
```

This is a non-trivial translation: PDDL is a formal language with well-defined semantics, while mission reports are narrative prose written for human readers. Success requires the LLM to both *understand* the mission and *express* that understanding in formal syntax.

### Scope of v1.1

v1.1 is the **text-only**, **LLM-translation** slice of the MarineLLM-PDDL pipeline:

- **Input modality:** free text only (tables, figures, and PDF metadata are deferred to future work).
- **Translator:** an Interactive Single Prompt LLM stages.
- **Evaluation:** static validation  using VAL tool, Solvability using classical-planners, Correctness Analysis, and Diversity measurement.

---

## 1. Research Questions

v1.1 is organized around two questions about the LLM's role as a translator:

| # | Question | Evaluation |
|---|---|---|
| **RQ1** | Does an LLM truly understand code semantics? That is, can it recover the types, predicates, preconditions, and effects of a mission from narrative prose — not just lexical tokens? | Understanding correctness and semantic completeness |
| **RQ2** | What is the relationship between code *understanding* and code *generation* abilities in LLMs? When the model comprehends a mission, does it reliably produce valid PDDL — and vice versa? | Generation score (parsability, solvability, structural validity) |

---

## 2. System Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                        IRP / Cruise Reports                          │
│                         (text content only)                          │
└──────────────────┬───────────────────────────────────────────────────┘
                   │
          ┌────────▼────────┐
          │  Text Extractor │  RAG chunking over free text
          │    (ε^txt)      │
          └────────┬────────┘
                   │  Structured intermediate representation r_i
          ┌────────▼────────┐
          │   RAG Index     │  Text chunks embedded into a vector store
          │ (Chroma / FAISS)│
          └────────┬────────┘
                   │
          ┌────────▼────────────────────────────────────────┐
          │     LM Translator  —  Interactive Chain (f)      │
          │                                                 │
          │  [ScenarioQA]         ──►  13 generic answers   │  understanding
          │       ↓                                         │
          │  [BuildGenericScenario] ──►  scenario template  │  abstraction
          │       ↓                                         │
          │  [ExtractSpecificDetails] ──► types/predicates  │  formalization
          │       ↓                                         │
          │  [GeneratePDDL]       ──►  domain + problem     │  generation
          └────────┬────────────────────────────────────────┘
                   │
          ┌────────▼────────┐
          │   Validator     │  VAL (syntax + typing)
          └────────┬────────┘
                   │
          ┌────────▼────────┐
          │  PDDL Planner   │  FastForward / LPG-td / Optic-clp
          │  (static check) │  (checks solvability only — no execution)
          └────────┬────────┘
                   │
          ┌────────▼────────┐
          │   Evaluation    │  Understanding U  ·  Generation G  ·  Q
          │   Framework     │
          └─────────────────┘
```

Stages (1)–(2) probe *Collect LLM responses to 13 Questions*; stages (3)–(4) probe *code generation*.

---

## 3. Methodology

### 3.1 Text Pipeline

**Chunking.** Free-text content of each PDF is split into semantic chunks and embedded into a RAG vector store.

**ScenarioQA.** For each document, 13 generic questions (vessel, equipment, tasks, durations, outcomes, location, etc.) are posed against the retrieval-augmented context. The answers form the structured intermediate representation $r_i$.

**BuildGenericScenario.** The QA answers are synthesized into a scenario template; a natural-language summary of the mission's objects, actions, and timeline.

**ExtractSpecificDetails.** Types, predicates, and action schemata are extracted from the scenario template.

**GeneratePDDL.** The final stage emits `domain.pddl` and `problem.pddl`.

### 3.2 Template-Based PDDL Builder

For the curated Q&A datasets, [src/template_pddl_generation.py](src/template_pddl_generation.py) builds a PDDL domain directly from the structured answers of Q1 (vessel name → domain name) and Q5 (task list + durations + outcomes → actions). It supports two input formats:

- **Canonical inline** (`- **task**: **duration** - **outcome**`) — default parser.
- **Multi-section** (separate "Tasks", "Duration", "Success/Failure" sections) — used for NOAA-style answers.

---

## 4. Evaluation Framework

Evaluation metrics is as follows:

### Generation metrics

| Metric | Definition |
|---|---|
| **Parsability** | VAL accepts the PDDL (`{0, 1}`) |
| **Solvability** | A classical planner returns a plan (`{0, 1}`) |
| **Structural Validity** | Fraction of declared types, predicates, and action schemata that are well-formed |


---

## 5. Repository Structure

```
marineLLM-PDDL/
│
├── src/
│   ├── scenario_generation.py       RAG Q&A with LangChain + GPT-4o
│   └── template_pddl_generation.py  CSV → PDDL template builder
│                                    (canonical + NOAA multi-section parsers)
│
├── datasets/
│   ├── CuratedQAs/
│   │   ├── Geomar-Kiel/             Q1–Q13 CSV files
│   │   └── NOAA/                    Q1–Q13 CSV files
│   ├── FileNames/
│   └── readme.md
│
├── domains/                         Generated PDDL domain files
├── results/
│   ├── plans/                       Domain + problem + solution files
│   └── diversity/                   Similarity metrics
│
|
└── README.md
```

---

## 6. Datasets

| Dataset | Source | Documents | Domain |
|---|---|---|---|
| GEOMAR-Kiel | [geomar.de research vessels](https://www.geomar.de/en/centre/central-facilities/geomar-research-vessels) | 51 | AUV, ROV, research vessel |
| NOAA | [repository.library.noaa.gov](https://repository.library.noaa.gov) | 30 | Ocean survey, CTD, ADCP |

Each document has curated Q&A answers for 13 generic questions (see paper Table 1).

---

## 7. Installation

### Python dependencies

```bash
pip install -r requirements.txt
```

### Planners

Download and build at least one of:
- [FastForward](https://fai.cs.uni-saarland.de/hoffmann/ff.html)
- [LPG-td](https://lpg.unibs.it/lpg/)
- [Optic-clp](https://nms.kcl.ac.uk/planning/software/optic.html)

### Environment variables

```bash
export OPENAI_API_KEY="sk-..."
```

---

## 8. Usage

### Generate scenarios directly from PDFs via the RAG + LLM pipeline

```bash
python src/scenario_generation.py
```

### Generate PDDL from the curated Q&A CSVs (both datasets)

```bash
python src/template_pddl_generation.py
```

This writes one `.pddl` per parseable row in [domains/](domains/):
- Geomar-Kiel rows → canonical parser
- NOAA rows → multi-section parser


### Solve a generated PDDL with a planner

```bash
./lpg-td -o domains/rv_poseidon_domain.pddl \
         -f domains/rv_poseidon_problem.pddl \
         -n 1 -out results/plans/rv_poseidon
```

---

## 9. Results

### v1 baseline (text-only, interactive single-pass GPT-4o)

| Dataset | Parsable | Solvable | Correct |
|---|---|---|---|
| GEOMAR-Kiel (51 docs) | 96.1% | 80.0% | 60.0% |
| NOAA (30 docs) | 96.6% | 76.6% | 57.0% |

### Plan diversity (GEOMAR-Kiel sample, 7 scenarios)

Pairwise distances across 7 sample scenarios show Wasserstein distance best separates semantically distinct plans from near-duplicates (see `results/diversity/`).

---

## 10. Acknowledgements

**MarineLLM-PDDL** is developed at the [IT University of Copenhagen](https://itu.dk) as part of the REMARO project.

> Mahya Mohammadi Kashani, Stefan Heinrich, Andrzej Wąsowski.
> *MarineLLM-PDDL: Generation of Planning Domains for Marine Vessels Using Past Incident Response Plans.*
> European Robotics Forum (ERF) 2025. SPAR 36, pp. 307–313.
> DOI: [10.1007/978-3-031-89471-8_47](https://doi.org/10.1007/978-3-031-89471-8_47)

This project received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No. 956200 REMARO.

<a href="https://remaro.eu/">
  <img height="60" alt="REMARO Logo" src="https://remaro.eu/wp-content/uploads/2020/09/remaro1-right-1024.png">
</a>
