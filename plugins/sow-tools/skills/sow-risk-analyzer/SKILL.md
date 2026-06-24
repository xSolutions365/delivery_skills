---
name: sow-risk-analyzer
description: Analyse Statements of Work (SOWs) from the supplier's perspective and produce a three-part risk report. Part 1 is a SOW summary card (contract type, value, parties, term, key attributes). Part 2 is an interactive risk radar (5×5 impact/likelihood matrix, highest risks top-right, click any blip for detail). Part 3 is a prioritised risk and recommendations table (7 columns: ID, risk title, impact, likelihood, score, why it is dangerous, recommended redline). Triggers include 'analyse SOW', 'review SOW risks', 'supplier risk report', 'SOW liability analysis', or when a user uploads a SOW document and asks for risk assessment.
---

# SOW Risk Analyzer

A structured skill for supplier-side risk analysis of Statements of Work. Produces a three-part report: a SOW summary card, an interactive risk radar, and a prioritised risk and recommendations table.

## When to Use

- **Supplier evaluation**: Analyse SOWs before signing to identify exposure
- **Delivery team preparation**: Prepare negotiation briefs and redline suggestions
- **Risk dashboard**: Visual triage of 10–15 contractual risks with weightings
- **Negotiation support**: Ranked priorities based on commercial impact and leverage
- **Compliance review**: Structured identification of scope creep, warranty, and liability risks

The skill works from SOW PDFs, text, or clause excerpts.

---

## Output: Three-Part Report

**Deliver all three parts in every analysis, in this exact order. Never skip a part.**

---

### Part 1: SOW Summary Card *(always first)*

Render as an HTML widget — a clean summary card showing the key attributes of the SOW extracted directly from the document. Use CSS variables throughout for dark-mode compatibility.

**Fields to extract and display:**

| Field | Source |
|-------|--------|
| **Project name** | Statement of Work Particulars |
| **Customer** | Parties section |
| **Supplier** | Parties section |
| **Contract type** | e.g., Time & Materials / Fixed Price / Milestone-based |
| **Contract value** | Indicative fee estimate or fixed price (state currency; flag if non-binding) |
| **Term / duration** | Commencement date + duration or end date |
| **Governing agreement** | Reference to MSA or master agreement (flag if undated or not reviewed) |
| **Scope summary** | One sentence describing what is being delivered |
| **Key deliverables** | Bullet list of named outputs (e.g., Delivery Plan, Mid-Audit Review, Phase 1 Report) |
| **Out of scope** | Any explicit exclusions noted in the SOW |
| **Notable flags** | Any missing fields, undated references, or structural gaps (e.g., "MSA execution date TBD", "SOW reference number not yet assigned") |

**Styling:**
- Outer container: `background: var(--color-background-secondary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); padding: 20px 24px; font-family: var(--font-sans)`
- Title row: supplier name + customer name in 16px/500, with a small pill showing contract type (e.g., "Time & Materials" in blue tones)
- Two-column grid for fields: left = muted label (12px, `var(--color-text-secondary)`), right = value (13px, `var(--color-text-primary)`)
- Contract value: display prominently (18px, 500 weight); if indicative/non-binding, append "(indicative, non-binding)" in muted text
- Notable flags: render as a soft amber/warning block at the bottom if any flags exist — `background: var(--color-background-warning); border-left: 3px solid var(--color-border-warning); padding: 10px 14px; font-size: 12px`
- Key deliverables and out-of-scope as compact bullet lists, 13px

---

### Part 2: Interactive Risk Radar *(always second)*

An HTML + SVG widget displaying all identified risks on a 5×5 impact/likelihood matrix. Highest risks appear in the **top-right** (Critical impact, Almost Certain likelihood). Clicking any blip reveals full detail in a card below.

**SVG canvas:**
```
viewBox="0 0 1100 750"
```

**Layout & Styling:**
- Outer frame: dotted rectangle from (160, 60) to (1080, 680)
  - `stroke: #999; stroke-dasharray: 5,5; opacity: 0.5`
  - Draw frame **last** (on top of fills) so it reads as a clean border
- Safe zone: linear gradient fill `#FFFBF5 → #FFFAF7` at opacity 0.8 — bottom-left (low risk)
- Danger zone: radial gradient `#F5D4D4` (opacity 0.6) fading to transparent — top-right (high risk)
  - Ellipse: `rx=380; ry=300; cx=950; cy=120`; clipped to frame

**Grid lines (inside frame):**
- 2 horizontal: `y=266.67`, `y=473.33`
- 3 vertical: `x=390`, `x=620`, `x=850`
- `stroke: #D4C5B9; stroke-width: 0.5; stroke-dasharray: 3,3; opacity: 0.4`

**Y-axis (Impact) — right-aligned at x=145, 12px, weight 600:**

| Label | y | fill |
|-------|---|------|
| CRITICAL | 127 | #666 |
| MAJOR | 251 | #777 |
| MODERATE | 375 | #999 |
| MINOR | 499 | #AAA |
| MINIMAL | 623 | #BBB |

**X-axis (Likelihood) — centred at y=715, 12px, weight 600:**

| Label | x | fill |
|-------|---|------|
| RARE | 252 | #BBB |
| UNLIKELY | 436 | #AAA |
| POSSIBLE | 620 | #999 |
| LIKELY | 804 | #777 |
| ALMOST CERTAIN | 988 | #666 |

**Axis titles:** `IMPACT` at (80, 82); `LIKELIHOOD` at (1060, 670) — 14px, weight 700, fill #333

**Blip placement grid:**
- Impact rows (y): Critical=140, Major=260, Moderate=380, Minor=500, Minimal=620
- Likelihood cols (x): Rare=252, Unlikely=436, Possible=620, Likely=804, Almost Certain=988
- Apply jitter of ±30–70px within each cell to avoid grid-lock
- Enforce minimum 50px centre-to-centre spacing between blips

**Blip styling by Impact:**

| Impact | Fill | Radius | Font-size | Stroke-width |
|--------|------|--------|-----------|--------------|
| Critical | #D32F2F | 24 | 28px | 2.5 |
| Major | #F57C00 | 22 | 26px | 2 |
| Moderate | #FB8C00 | 20 | 24px | 2 |
| Minor | #1976D2 | 18 | 22px | 2 |
| Minimal | #78716C | 16 | 20px | 2 |

- Letter identifier inside each blip (A, B, C…), white, bold, centered — never numbers
- Stroke: `#1a1a1a`
- CSS hover: `filter: brightness(1.12); cursor: pointer`
- Wrap each blip in `<g onclick="toggleDetail('A')" class="blip">`

**Detail card** (below SVG, toggled on blip click):
- `id="detail-card"`, initially `display: none`
- `background: #FFFBF5; border: 1px solid #E8DDD0; border-radius: 10px; padding: 20px; margin-top: 24px`
- Contents:
  - Letter badge: 44px circle, blip colour fill, 2px `#1a1a1a` border, white bold letter
  - Risk title (16px, bold) + uppercase meta line (e.g., `CRITICAL IMPACT · ALMOST CERTAIN · SCORE: 25`)
  - **AFFECTED CLAUSES** — specific clause references
  - **WHY IT IS DANGEROUS FOR THE SUPPLIER** — 2–3 sentences, commercial language
  - **RECOMMENDED FIX** — redline in blockquote: white bg, 3px left border `#1976D2`, italic Georgia serif
- Toggle: clicking the same blip again hides the card; clicking a different blip replaces it
- `scrollIntoView({ behavior: 'smooth', block: 'nearest' })`

---

### Part 3: Prioritised Risk and Recommendations Table *(always third)*

An HTML widget. A styled table listing all identified risks in **descending priority order** (highest score first; within equal scores, sort by Impact descending). Seven columns:

| Column | Content |
|--------|---------|
| **ID** | Letter badge (A, B, C…) coloured by severity |
| **Risk** | Short title (one line, bold) |
| **Impact** | Pill badge |
| **Likelihood** | Pill badge |
| **Score** | Impact × Likelihood (1–25), displayed as a number with a thin coloured bar |
| **Why it is dangerous** | 2–3 sentences, plain commercial language |
| **Recommended redline** | Specific quoted replacement language, italic serif, blue left border |

**Scoring:**
- Impact: Minimal=1, Minor=2, Moderate=3, Major=4, Critical=5
- Likelihood: Rare=1, Unlikely=2, Possible=3, Likely=4, Almost Certain=5
- Score = Impact × Likelihood (range 1–25)

**Score tier colouring** (for the score number and bar):
- 20–25: `#D32F2F` (SEVERE)
- 15–19: `#E65100` (HIGH)
- 9–14: `#F9A825` (ELEVATED)
- 1–8: `#78716C` (WATCH)

**Table styling:**
- Outer wrapper: `overflow-x: auto` for narrow screens
- Container: `background: var(--color-background-secondary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); overflow: hidden; min-width: 1000px`
- Header row: `font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; color: var(--color-text-secondary); background: var(--color-background-tertiary); padding: 10px 14px`
- Body rows: alternate `var(--color-background-primary)` / `var(--color-background-secondary)`; `border-bottom: 0.5px solid var(--color-border-tertiary)`
- Row hover: `background: var(--color-background-secondary)`
- ID badge: 28px circle, coloured fill, white bold letter, `font-size: 13px`
- Impact pill: `font-size: 11px; font-weight: 500; padding: 3px 10px; border-radius: 12px`
  - Critical: `background: #FFEBEE; color: #B71C1C`
  - Major: `background: #FFF3E0; color: #E65100`
  - Moderate: `background: #FFF8E1; color: #F57F17`
  - Minor: `background: #E3F2FD; color: #0D47A1`
  - Minimal: `background: var(--color-background-secondary); color: var(--color-text-secondary)`
- Likelihood pill: same style, same warm→cool progression
  - Almost Certain: `background: #FFEBEE; color: #B71C1C`
  - Likely: `background: #FFF3E0; color: #E65100`
  - Possible: `background: #FFF8E1; color: #F57F17`
  - Unlikely: `background: #E3F2FD; color: #0D47A1`
  - Rare: `background: var(--color-background-secondary); color: var(--color-text-secondary)`
- Score column: bold number (18px, tier colour) + thin coloured bar below (4px height, `width: calc(score/25 * 80px)`, max 80px, border-radius 2px)
- Why dangerous cell: `font-size: 13px; line-height: 1.6; color: var(--color-text-primary); max-width: 280px`
- Redline cell: `font-style: italic; font-family: var(--font-serif); font-size: 12px; line-height: 1.6; border-left: 2.5px solid #1976D2; padding-left: 10px; color: var(--color-text-primary); max-width: 300px`
- Column widths: ID 44px · Risk 160px · Impact 90px · Likelihood 110px · Score 80px · Why dangerous 280px · Redline 300px
- All backgrounds and text use CSS variables; only accent colours (pill fills, score bar, redline border) may be hardcoded

**Below the table:** A single paragraph (3–5 sentences) covering mean and median score, portfolio shape (e.g., "two load-bearing SEVERE risks dominate; remainder cluster in ELEVATED"), and recommended negotiation posture (e.g., "resolve Risks A and B first; bundle C, D, E as a change-control package").

---

## Key Instructions for Claude

### Risk identification
- Scan the SOW and all annexes for clauses that create **supplier exposure**
- Identify 10–15 specific risks; fewer is acceptable for tight, well-drafted SOWs
- Flag T&M/fixed-price mismatches, subjective acceptance criteria, open-ended rework obligations, warranty scope, liability caps, change control gaps, and MSA dependencies
- Assign letter identifiers (A, B, C…) in **descending severity order** — reuse the same letter consistently across all three parts
- Redline language must be **specific and quotable** — not vague suggestions

### MSA dependencies
- If the SOW defers to an MSA that is undated, unexecuted, or not provided for review, call this out in the Part 1 Notable Flags section and flag the relevant risks in the Part 3 table

### Redline realism
- Suggest commercially achievable redlines; avoid unrealistic demands that waste negotiation capital
- Prefer language that protects the supplier without appearing adversarial

---

## Edge Cases

- **Incomplete SOWs**: Note missing sections in Part 1 Notable Flags; assess risk based on what is present
- **T&M + outcome acceptance**: Flag aggressively — highest-frequency severe risk pattern
- **Annex chains**: Scan all schedules, exhibits, and referenced documents
- **Short SOWs (<5 clauses)**: Identify as many risks as the document supports; do not pad to reach 10

---

## Technical Requirements

- **SVG viewBox**: `0 0 1100 750` (exact — do not change)
- **Interactivity**: Plain HTML + JavaScript only; no external libraries
- **Dark mode**: All HTML widgets use CSS variables for backgrounds and text — never hardcode `#fff`, `#000`, or grey hex values as text or background colours
- **Accent colours** (pill fills, score bar, redline border `#1976D2`) may remain hardcoded
- **Performance**: Single SVG render; no animation

---

## Skill Triggers

- "Analyse SOW", "review SOW", "SOW risk", "supplier risk report"
- SOW PDF or text upload + request for risk assessment or analysis
- "Statement of Work" + "risk", "liability", "exposure", "negotiate"
- "Redline suggestions", "negotiation brief", "risk report" in a SOW context

---
