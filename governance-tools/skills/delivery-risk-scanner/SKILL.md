---
name: delivery-risk-scanner
description: Build a CreateFuture "Agentic Delivery Risk Scanner" — a single self-contained HTML page that scores an engagement against 21 standard delivery risk factors and plots them on an impact/probability matrix, with an exec summary of the top three risks, a quadrant playbook, a ranked register and a risk glossary. Use this skill whenever a delivery manager, engagement lead or account lead wants to assess, score, review or visualise delivery risk on a client engagement — including phrases like "risk scan", "risk matrix", "impact probability", "2x2 risk", "what could go wrong on this engagement", "risk review for the SteerCo", "pre-mobilisation risk assessment", or when they hand over a SOW, proposal, discovery notes or mobilisation pack and ask what the risks are. Also use it to update or re-score an existing scanner page. Do NOT use it for a SOW contract/liability review (that is sow-risk-analyzer) or for portfolio-wide RAG reporting across many engagements (that is delivery-assurance-pulse).
---

# Agentic Delivery Risk Scanner

Produces one self-contained `.html` page — no build step, opens in any browser, works from a shared drive — showing where an engagement's delivery risk actually sits. The output is a scan of a **single engagement**, scored by a human, laid out so a sponsor can read the top three risks in thirty seconds and a delivery lead can interrogate all 21 underneath.

## Why this exists

Most risk registers are long lists that nobody reads and nobody prioritises. This scanner forces two decisions per factor — how bad, how likely — and then makes the answer visual. The value is in the scoring conversation, not the page. So the job here is to help the user score honestly, not to fill the template as fast as possible.

## Workflow

### 1. Gather engagement context before scoring anything

Read whatever the user has given you: SOW, proposal, discovery notes, mobilisation pack, meeting transcripts, Slack threads. If a Granola, Google Drive, Slack or Atlassian connector is available and relevant, look for signals there rather than asking the user to retype what already exists.

Then ask for what you cannot infer. Keep it to a handful of questions, and ask them together rather than one at a time:

- Client and engagement name, and the stage (pre-sale, mobilisation, mid-delivery, recovery)
- The commercial model and whether the date is movable
- Anything already going wrong

If the user wants to skip the interview ("just score it from the SOW"), do that and flag the factors you had to guess at.

### 2. Read `references/risk-factors.md`

It holds the 21 factor definitions, the theme keys, and the 1–5 anchors for impact and probability. Score against those anchors rather than inventing a scale — the whole point is that two delivery managers scoring two engagements produce comparable numbers.

### 3. Score all 21 factors

Every factor gets an impact and a probability. Three failure modes to avoid:

- **Generic scoring.** If the scores would be identical for any engagement, you have described the factor rather than assessed this piece of work. Ground each score in something specific from the context, and say what that was.
- **Clustering at 3.** A matrix where everything sits mid-mid is decoration. Push scores apart; some factors genuinely belong at 1.
- **Inventing evidence.** Where the context is silent on a factor, score it from the little you have and mark it as an assumption. Never fabricate a detail about the client to justify a number.

Write a one-line action (`so`) for at least the top three by severity — what someone should actually do about it, not a restatement of the definition. These lines carry the exec summary, so they need to be specific to the engagement.

### 4. Fill the template

Copy `assets/template.html` to the working directory and edit **only** the `ENGAGEMENT DATA` block at the top of the `<script>`. It holds `ENGAGEMENT`, `EXEC_HEADLINE`, `THEMES` and `RISKS`; everything below the END marker is presentation logic and should be left alone. Nothing else in the file needs touching — the exec summary cards, severity meters, matrix markers, quadrant lists, ranked table and glossary all derive from `RISKS`.

`EXEC_HEADLINE` is the one piece of prose you write from scratch: two or three sentences saying where the exposure concentrates and what it means. Name the pattern rather than listing the top three — the cards below already do that. "Exposure is concentrated in the client's decision-making rather than the technology" is useful; "There are several high risks" is not.

### 5. Deliver

Save as `<client>-risk-scan-<YYYY-MM-DD>.html` and present the file. If an artifact publishing tool is available, offer to publish it as a link as well — easier to circulate to a SteerCo than an attachment.

Then tell the user, briefly:

- The top three and their severity
- The quadrant spread (how many in act-now / contain / watch / monitor)
- Which scores you had to assume, so they can correct them

## What the page contains

Six blocks, in order. All of them are in the template already — this is orientation, not a build list.

1. **Title** and engagement kicker (client, engagement, scored date, scorer).
2. **Exec summary** — hand-written headline, then the top three by severity as ranked cards with a five-segment severity meter and an action line.
3. **Tabs** — "Risk matrix" and "Risk glossary".
4. **Quadrant playbook** — what Act now / Contain / Watch / Monitor each ask of you, with every factor in that quadrant listed beneath, ordered by severity.
5. **The matrix** — all factors plotted, probability on X, impact on Y, coloured by theme, with theme filters, hover detail and a side panel.
6. **Ranked register** and **glossary** — every factor by severity, and every definition grouped by theme.

## Reading the result with the user

Two things are worth saying out loud when handing a scan over, because the visual invites the wrong conclusion if nobody says them:

- **The top-left quadrant is not low risk.** Compliance obligations or a volatile business case score low on severity precisely because they rarely fire — but when they do, they end engagements. Contain them in the contract, not the plan.
- **Severity flattens two different things.** A 5/1 factor can kill the work outright while a 3/4 factor merely makes it painful, and multiplication ranks the second one higher. Read the quadrants, then the scores.

## Re-scoring an existing scan

If the user has a previous scan, open it, read the `RISKS` array out of it, and change only the scores that have moved. Keeping the unchanged entries intact is what makes two scans comparable — and the movement between them ("S2 went from 3 to 5 after the date was fixed") is usually more interesting to a sponsor than either scan alone. Mention the notable shifts when you hand it back.

## Brand

The template carries CreateFuture styling already: Syne for headings, Montserrat for body, midnight and purple surfaces, lime as the single accent, and a light/dark pair that follows the reader's system setting. Leave it be unless the user asks for another brand — in which case the colour tokens all sit in `:root` at the top of the `<style>` block, in one place.

Four of the five theme colours (aqua, amber, periwinkle, coral) are extensions rather than official brand tokens — the core palette does not carry five distinguishable data colours. If your team adopts an official chart palette, replace `--c-commercial` through `--c-team` with it.
