# MarineLLM-PDDL v1.1

**Translating Marine Mission Reports into PDDL with Large Language Models**


---

## Table of Contents

1. [Problem Statement](#1-problem-statement)
2. [Research Questions](#2-research-questions)
3. [System Architecture](#3-system-architecture)
4. [Methodology](#4-methodology)
5. [Evaluation Framework](#5-evaluation-framework)
6. [Repository Structure](#6-repository-structure)
7. [Datasets](#7-datasets)
8. [Installation](#8-installation)
9. [Usage](#9-usage)
10. [Results](#10-results)
11. [Acknowledgements](#11-acknowledgements)

---

## 1. Problem Statement

### Background

Autonomous Underwater Vehicles (AUVs) and marine research vessels accumulate knowledge through missions documented in **Incident Response Plans (IRPs)** and **cruise reports**. These documents describe, in natural language, what equipment was deployed, what tasks were executed, how long each task took, and whether the task succeeded or failed. This accumulated operational knowledge is a rich but largely untapped resource for generating realistic planning scenarios.

Planning Domain Definition Language (**PDDL**) provides a formal, solver-ready representation of such scenarios. A PDDL domain encodes what actions are possible; a PDDL problem encodes the concrete objects, initial state, and goal. Automated planners (FastForward, LPG-td, Optic-clp) then find executable action sequences — plans — that transition the system from the initial to the goal state.

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
- **Translator:** a Sequential Chain of prompted LLM stages — no prompt optimization loop yet.
- **Evaluation:** static validation (VAL) and classical-planner solvability.

---

## 2. Research Questions

v1.1 is organized around two questions about the LLM's role as a translator:

| # | Question | Evaluation |
|---|---|---|
| **RQ1** | Does an LLM truly understand code semantics? That is, can it recover the types, predicates, preconditions, and effects of a mission from narrative prose — not just surface tokens? | Understanding score $U_i$ (QA correctness, entity-extraction F1, semantic completeness), decomposed along the four PDDL semantic axes |
| **RQ2** | What is the relationship between code *understanding* and code *generation* abilities in LLMs? When the model comprehends a mission, does it reliably produce valid PDDL — and vice versa? | Generation score $G_i$ (parsability, solvability, structural validity), plus the correlation $\rho_{UG}$ and the understanding–generation gap $\Gamma_i = U_i - G_i$ |

See [Problem_Statement.md](Problem_Statement.md) for the formal definitions.

---

## 3. System Architecture

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
          │     LM Translator  —  Sequential Chain (f)      │
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

Stages (1)–(2) probe *code understanding*; stages (3)–(4) probe *code generation*.

---

## 4. Methodology

### 4.1 Text Pipeline

**Chunking.** Free-text content of each PDF is split into semantic chunks and embedded into a RAG vector store.

**ScenarioQA.** For each document, 13 generic questions (vessel, equipment, tasks, durations, outcomes, location, etc.) are posed against the retrieval-augmented context. The answers form the structured intermediate representation $r_i$.

**BuildGenericScenario.** The QA answers are synthesized into a scenario template — a natural-language summary of the mission's objects, actions, and timeline.

**ExtractSpecificDetails.** Types, predicates, and action schemata are extracted from the scenario template.

**GeneratePDDL.** The final stage emits `domain.pddl` and `problem.pddl`.

### 4.2 Template-Based PDDL Builder

For the curated Q&A datasets, [src/template_pddl_generation.py](src/template_pddl_generation.py) builds a PDDL domain directly from the structured answers of Q1 (vessel name → domain name) and Q5 (task list + durations + outcomes → actions). It supports two input formats:

- **Canonical inline** (`- **task**: **duration** - **outcome**`) — default parser.
- **Multi-section** (separate "Tasks", "Duration", "Success/Failure" sections) — used for NOAA-style answers via `parse_noaa_q5_result`.

---

## 5. Evaluation Framework

Each generated $(\Omega_i, \Pi_i)$ pair is scored along two axes.

### Understanding metrics ($U_i$)

| Metric | Definition |
|---|---|
| **QA Correctness** ($\alpha_i$) | Fraction of the 13 ScenarioQA answers matching expert gold labels |
| **Entity-Extraction F1** ($\eta_i$) | F1 over mission entities (vessel, instruments, tasks) recovered from $r_i$ |
| **Semantic Completeness** ($\kappa_i$) | Expert-judged coverage of mission elements in the scenario template, $\in [0,1]$ |

$$U_i = \tfrac{1}{3}(\alpha_i + \eta_i + \kappa_i)$$

### Generation metrics ($G_i$)

| Metric | Definition |
|---|---|
| **Parsability** ($\phi_i$) | VAL accepts the PDDL (`{0, 1}`) |
| **Solvability** ($\sigma_i$) | A classical planner returns a plan (`{0, 1}`) |
| **Structural Validity** ($\nu_i$) | Fraction of declared types, predicates, and action schemata that are well-formed |

$$G_i = \tfrac{1}{3}(\phi_i + \sigma_i + \nu_i)$$

### Composite score

$$Q_i = \lambda\, U_i + (1-\lambda)\, G_i, \qquad \lambda = 0.5\ \text{(default)}$$

See [Problem_Statement.md](Problem_Statement.md) §2–§4 for the formal treatment and RQ-specific probes (per-axis decomposition of $U$, correlation $\rho_{UG}$, understanding–generation gap $\Gamma_i$).

---

## 6. Repository Structure

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
│   │   ├── Geomar-Kiel/             Q1–Q13 CSV files (51 docs)
│   │   └── NOAA/                    Q1–Q13 CSV files (30 docs)
│   ├── FileNames/
│   └── readme.md
│
├── domains/                         Generated PDDL domain files
├── results/
│   ├── plans/                       Domain + problem + solution files
│   └── diversity/                   Similarity metrics
│
├── Problem_Statement.md           Formal problem statement and RQ grounding
└── README.md
```

---

## 7. Datasets

| Dataset | Source | Documents | Domain |
|---|---|---|---|
| GEOMAR-Kiel | [geomar.de research vessels](https://www.geomar.de/en/centre/central-facilities/geomar-research-vessels) | 51 | AUV, ROV, research vessel |
| NOAA | [repository.library.noaa.gov](https://repository.library.noaa.gov) | 30 | Ocean survey, CTD, ADCP |

Each document has curated Q&A answers for 13 generic questions (see paper Table 1).

---

## 8. Installation

### Python dependencies

```bash
pip install langchain langchain-community langchain-chroma \
            langchain-openai langchain-text-splitters openai pandas
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

## 9. Usage

### Generate PDDL from the curated Q&A CSVs (both datasets)

```bash
python src/template_pddl_generation.py
```

This writes one `.pddl` per parseable row in [domains/](domains/):
- Geomar-Kiel rows → canonical parser
- NOAA rows → multi-section parser

### Generate PDDL directly from PDFs via the RAG + LLM pipeline

```bash
python src/scenario_generation.py
```

### Solve a generated PDDL with a planner

```bash
./lpg-td -o domains/rv_poseidon_domain.pddl \
         -f domains/rv_poseidon_problem.pddl \
         -n 1 -out results/plans/rv_poseidon
```

---

## 10. Results

### v1 baseline (text-only, single-pass GPT-4o)

| Dataset | Parsable | Solvable | Correct |
|---|---|---|---|
| GEOMAR-Kiel (51 docs) | 96.1% | 80.0% | 60.0% |
| NOAA (30 docs) | 96.6% | 76.6% | 57.0% |

### Plan diversity (GEOMAR-Kiel sample, 7 scenarios)

Pairwise distances across 7 sample scenarios show Wasserstein distance best separates semantically distinct plans from near-duplicates (see `results/diversity/`).

---

## 11. Acknowledgements

**MarineLLM-PDDL** is developed at the [IT University of Copenhagen](https://itu.dk) as part of the REMARO project.

> Mahya Mohammadi Kashani, Stefan Heinrich, Andrzej Wąsowski.
> *MarineLLM-PDDL: Generation of Planning Domains for Marine Vessels Using Past Incident Response Plans.*
> European Robotics Forum (ERF) 2025. SPAR 36, pp. 307–313.
> DOI: [10.1007/978-3-031-89471-8_47](https://doi.org/10.1007/978-3-031-89471-8_47)

This project received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No. 956200 REMARO.

<a href="https://remaro.eu/">
  <img height="60" alt="REMARO Logo" src="https://remaro.eu/wp-content/uploads/2020/09/remaro1-right-1024.png">
</a>
