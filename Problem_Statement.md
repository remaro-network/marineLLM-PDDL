# Theoretical Aspects: MarineLLM-PDDL : Translating Marine Mission Reports into PDDL

> Formal problem statement and research question grounding for **MarineLLM-PDDL v2** (text-only scope, no simulator)

---

## 1. Definitions

### Document Corpus

Let $\mathcal{D} = \{d_1, \ldots, d_n\}$ be a corpus of $n$ Incident Response Plans (IRPs) and cruise reports. For the text-only scope of this work, each document is treated as its free-text content:

$$d_i = d_i^{\text{txt}}$$

---

### Text Extractor

A function $\varepsilon^{\text{txt}} : \mathcal{D} \to \mathcal{R}$ maps each document to a structured intermediate representation $r_i \in \mathcal{R}$ via RAG text chunking over $d_i^{\text{txt}}$.

---

### LM Translator

A multi-stage function $f : \mathcal{R} \to (\Omega, \Pi)$ translates a structured representation into a PDDL domain $\Omega_i$ and problem $\Pi_i$. The translator is realized as a Sequential Chain of four prompted stages:

1. **ScenarioQA** — answer 13 generic questions from $r_i$ (understanding stage)
2. **BuildGenericScenario** — synthesize a scenario template (abstraction stage)
3. **ExtractSpecificDetails** — infer PDDL types and predicates (formalization stage)
4. **GeneratePDDL** — emit `domain.pddl` and `problem.pddl` (generation stage)

Stages (1)–(2) probe *code understanding* — the LLM's ability to recover the semantic content of a mission description. Stages (3)–(4) probe *code generation* — its ability to render that content in the formal language of PDDL.

---

### Validator and Planner (Static Checks Only)

**Validator.** $\text{VAL} : (\Omega, \Pi) \to \{\text{ok}, \bot\}$ performs syntactic and type-level checks on the emitted PDDL.

**Planner.** $\mathcal{P} : (\Omega, \Pi) \to A^* \cup \{\bot\}$ returns an action sequence $A^*_i$ if the problem is solvable, else $\bot$. Supported planners: FastForward, LPG-td, Optic-clp. The planner is used *only* as a static check on the generated PDDL — no execution, no simulator, no robot platform is invoked.

---

## 2. Quality Metrics

For a generated pair $(\Omega_i, \Pi_i)$ derived from document $d_i$, define:

### Understanding metrics ($U_i$)

| Symbol | Name | Definition |
|---|---|---|
| $\alpha_i$ | QA Correctness | Fraction of the 13 ScenarioQA answers matching the expert gold label |
| $\eta_i$ | Entity-Extraction F1 | F1 over mission entities (vessel, instruments, tasks) recovered from $r_i$ |
| $\kappa_i$ | Semantic Completeness | Expert-judged coverage of mission elements in the scenario template, $\in [0,1]$ |

$$U_i = \tfrac{1}{3}\!\left(\alpha_i + \eta_i + \kappa_i\right)$$

### Generation metrics ($G_i$)

| Symbol | Name | Definition |
|---|---|---|
| $\phi_i$ | Parsability | $\mathbf{1}[\text{VAL}(\Omega_i, \Pi_i) = \text{ok}]$ |
| $\sigma_i$ | Solvability | $\mathbf{1}[\mathcal{P}(\Omega_i, \Pi_i) \neq \bot]$ |
| $\nu_i$ | Structural Validity | Fraction of declared types, predicates, and action schemata that are well-formed |

$$G_i = \tfrac{1}{3}\!\left(\phi_i + \sigma_i + \nu_i\right)$$

### Composite score

$$Q_i = \lambda\, U_i + (1-\lambda)\, G_i, \qquad \lambda \in [0,1]$$

The default aggregate uses $\lambda = 0.5$, weighting understanding and generation equally.

---

## 3. The Core Problem (RSG)

> **Problem RSG** *(Realistic Scenario Generation).*
> Given corpus $\mathcal{D}$ and the translator $f \circ \varepsilon^{\text{txt}}$, evaluate
>
> $$\bar{Q} = \frac{1}{n}\sum_{i=1}^n Q\!\left(f(\varepsilon^{\text{txt}}(d_i)),\ d_i\right)$$
>
> and characterize when each constraint holds:
> 1. $\phi_i = 1$ — the PDDL file parses
> 2. $\sigma_i = 1$ — the problem is solvable by a classical planner
> 3. $\nu_i \geq \nu^*$ — structural validity threshold

The full pipeline $\varepsilon^{\text{txt}} \to f \to \text{VAL} \to \mathcal{P}$ instantiates an end-to-end *code-translation* task: natural-language mission report $\Rightarrow$ formal PDDL.

---

## 4. Research Questions

---

### RQ1 — Does an LLM truly understand code semantics?

PDDL is a formal language with well-defined semantics: types, predicates, action schemata with preconditions and effects, and (in the durative fragment) temporal constraints. "Understanding" here means the LLM can recover these semantic elements from an unstructured natural-language description of a mission — not merely echo surface tokens.

Operationalize understanding via the decomposed score $U_i = \tfrac{1}{3}(\alpha_i + \eta_i + \kappa_i)$. We further decompose $U_i$ along four semantic axes expected in any PDDL domain:

| Axis | Question the LLM must answer from $d_i$ |
|---|---|
| **Types** ($U^{\text{typ}}$) | What are the object sorts in this mission (vessel, instrument, waypoint, …)? |
| **Predicates** ($U^{\text{pred}}$) | Which relations and properties hold, and how do they change? |
| **Preconditions** ($U^{\text{pre}}$) | What must be true before each action fires? |
| **Effects** ($U^{\text{eff}}$) | What becomes true (or ceases to hold) after an action fires? |

**RQ1 asks:** Is $\mathbb{E}[U] \gg 0$ across $\mathcal{D}$? Is understanding uniform across the four semantic axes, or does it concentrate on surface axes (types, predicates) while degrading on deeper axes (preconditions, effects)?

---

### RQ2 — What is the relationship between code understanding and code generation abilities in LLMs?

For the same LLM and the same document $d_i$, measure the understanding score $U_i$ and the generation score $G_i$ independently. The pipeline is designed so these scores isolate different stages: $U_i$ is computed at the output of stages (1)–(2), and $G_i$ is computed at the output of stages (3)–(4).

Define the per-document understanding–generation gap:

$$\Gamma_i = U_i - G_i$$

and the corpus-level dependence:

$$\rho_{UG} = \operatorname{corr}(U, G)$$

**RQ2 asks:** How tightly coupled are understanding and generation? Specifically:

1. **Correlation.** Is $\rho_{UG}$ close to $1$ (understanding determines generation), close to $0$ (they are independent capabilities), or negative (understanding is spent at the cost of generation quality)?
2. **Asymmetry.** What is the sign and magnitude of $\mathbb{E}[\Gamma]$? A positive gap ($U > G$) indicates documents the LLM *comprehends but cannot formalize* — a syntactic/formal bottleneck. A negative gap ($G > U$) indicates PDDL that parses and solves despite the LLM having misread the source — a faithfulness bottleneck (plausible-looking but wrong code).
3. **Ablation.** When understanding is artificially perturbed (by masking or corrupting ScenarioQA outputs before stage 3), how much does $G$ drop? This quantifies how much of generation quality is *downstream* of comprehension rather than learned boilerplate.
4. **Bottleneck identification.** Per the four semantic axes of RQ1, which axis of $U$ most strongly predicts $G$? Is a correct understanding of preconditions more load-bearing for solvability ($\sigma$) than correct understanding of types?

Together, RQ2's four probes chart whether LLM-based PDDL translation is limited by what the model *knows* about the mission or by what it can *say* in formal syntax.

---

## 5. Summary

| RQ | Variable being isolated | Axis of $Q_i$ | Pipeline stages |
|---|---|---|---|
| RQ1 | Understanding of PDDL semantics from text | $U_i$ and its four axes | ScenarioQA, BuildGenericScenario |
| RQ2 | Coupling between understanding and generation | $\rho_{UG}$, $\Gamma_i$ | End-to-end (1)–(4) |

Together, RQ1 and RQ2 test whether MarineLLM-PDDL succeeds as a *semantic translation* (understanding-driven generation) rather than as surface-level pattern completion. Prompt optimization, simulator-grounded executability, and multimodal extraction are deferred to future work.
