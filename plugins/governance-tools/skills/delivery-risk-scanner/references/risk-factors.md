# Risk factors and scoring anchors

The standard set of 21 factors, the definitions to use when scoring, and anchors for the 1–5 scales. Read this before scoring an engagement.

## Contents

- [How to score](#how-to-score)
- [Impact anchors](#impact-anchors-1-5)
- [Probability anchors](#probability-anchors-1-5)
- [The 21 factors](#the-21-factors)
- [Grouping judgement calls](#grouping-judgement-calls)

---

## How to score

Score each factor twice: **impact** (the damage if it lands) and **probability** (the likelihood it lands *on this engagement*, not in general). Severity is impact × probability out of 25, calculated by the template.

Three rules that keep a scan useful:

1. **Score the engagement, not the factor.** "Data migration & quality" is inherently risky, but if this engagement moves 200 rows of clean reference data, its probability is 1. Copying generic scores defeats the exercise.
2. **Impact means impact on the client's outcome**, not on the delivery team's comfort. A factor that costs the team two painful weeks but delivers on time is a 2, not a 4.
3. **Resist clustering at 3.** If everything scores 3/3 the matrix tells nobody anything. Force a spread — some factors genuinely belong at 1.

Half points (4.5) are fine and help separate markers that would otherwise overlap on the plot.

## Impact anchors (1–5)

| Score | Meaning |
|---|---|
| 1 | Absorbed inside a sprint. Nobody outside the team notices. |
| 2 | Noticeable friction. Costs days, handled within existing contingency. |
| 3 | Costs weeks or forces a scope trade. The client needs telling. |
| 4 | Threatens the date, the margin, or a committed outcome. Escalation to sponsor. |
| 5 | Threatens the engagement itself — the business case, the contract, or the relationship. |

## Probability anchors (1–5)

| Score | Meaning |
|---|---|
| 1 | Would be a genuine surprise. No current signal. |
| 2 | Plausible. Has happened on comparable engagements. |
| 3 | Even odds on this engagement. |
| 4 | Expect it. Early signals already visible. |
| 5 | Already happening, or certain to. |

If a factor scores 5 on probability it is arguably an issue rather than a risk — consider whether it belongs in the issue log instead, and say so in the exec summary.

---

## The 21 factors

### Commercial & Contractual (`commercial`)

The deal itself: what was agreed, how it is priced, whether the justification holds, and whether the client is one you should be serving.

| ID | Factor | Definition to use |
|---|---|---|
| C1 | Contractual ambiguity | Gaps between what was sold, what was signed, and what the client expects to receive. |
| C2 | Commercial model risk | Fixed price vs T&M, margin sensitivity, penalty clauses, gain-share mechanics. |
| C3 | Business case volatility | The underlying justification shifts mid-flight and renders the current scope obsolete. |
| C4 | ICP fit | Whether a new client maps to the ideal client profile and the wider strategy. |

### Technical & Solution Complexity (`technical`)

The inherent difficulty of the thing being built, plus the conditions needed to prove it works.

| ID | Factor | Definition to use |
|---|---|---|
| T1 | Technical complexity | Platforms, integrations, legacy dependencies. |
| T2 | Integration touchpoints | Number of systems, APIs or platforms that must talk to each other at go-live. |
| T3 | Data migration & quality | Volume, cleanliness and mapping complexity of data moving between systems. |
| T4 | Testing & environment constraints | Production environments that cannot be replicated, and reliance on mocked data for critical integrations. |
| T5 | NFR stringency | Extreme performance, latency, availability or accessibility targets that dictate architecture. |

### Scope, Schedule & Dependencies (`scope`)

Constraints on what must be delivered, by when, and what else has to line up first.

| ID | Factor | Definition to use |
|---|---|---|
| S1 | Requirement ambiguity | How well defined the scope and success criteria actually are. |
| S2 | Timeline compression | How tight the deadline is relative to scope — immovable or political dates. |
| S3 | Dependency chain length | How many third parties, vendors or parallel workstreams must align. |
| S4 | Compliance requirements | Regulatory, audit and data protection obligations. |

### Client & Stakeholder Environment (`client`)

The client's ability and willingness to decide, absorb, and adopt.

| ID | Factor | Definition to use |
|---|---|---|
| K1 | Client political complexity | Power dynamics, hidden agendas, sponsor strength, organisational change fatigue. |
| K2 | Stakeholder density | Number of decision-makers, competing interests, approval chains. |
| K3 | Client maturity level | Technical understanding and willingness to take ownership. |
| K4 | Organisational readiness | Capacity to absorb the project alongside everything else they are running. |
| K5 | High change impact | Degree of disruption to BAU processes, people and systems. |

### Team & Delivery Capability (`team`)

Whether you have the right people, arranged in a workable way, doing something they have done before.

| ID | Factor | Definition to use |
|---|---|---|
| D1 | Cast team | The start date dictated a team that was available rather than one that matched the need. |
| D2 | Team distribution | Geographic spread, time zones, onshore/offshore mix, language barriers. |
| D3 | Novelty / first-of-kind | Whether the team or client has done anything like this before. |

---

## Grouping judgement calls

Two placements are debatable, and it is worth knowing why they sit where they do:

- **S4 Compliance requirements** sits under Scope because regulation acts as a non-negotiable boundary on scope and pace. It could equally sit under Technical, since regulation often dictates architecture.
- **D3 Novelty / first-of-kind** sits under Team because the factor is framed around prior experience rather than the technology itself.

An alternative cut is to align the five themes to **owners** — commercial lead, tech lead, delivery lead — rather than to subject. The theme filters in the scanner support this reading: give each owner a colour and the matrix becomes an accountability view. If a team works that way, rename the `THEMES` labels in the template and keep the keys unchanged.

## Adding or removing factors

The template is driven entirely by the `RISKS` array, so adding a factor is a matter of appending an entry with a new ID and one of the five theme keys. Keep IDs to two or three characters — they are rendered inside the matrix markers and longer strings overflow the circles.

If an engagement genuinely has no exposure to a factor, score it low rather than deleting it. A factor that is present at 1/1 tells the reader it was considered; a missing factor looks like an oversight.
