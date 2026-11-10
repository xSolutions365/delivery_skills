---
name: delivery-risk-scanner
description: "Build a CreateFuture Agentic Delivery Risk Scanner as a single self-contained HTML file for one engagement (21-factor impact/probability matrix) with a concise weekly Ops update tab. Not for SOW contract review or portfolio RAG."
---

# Agentic Delivery Risk Scanner

Produces one self-contained `.html` page — no build step, opens in any browser, works from a shared drive — showing where an engagement's delivery risk actually sits. The output is a scan of a **single engagement**, scored by a human, laid out so a sponsor can read the top three risks in thirty seconds and a delivery lead can interrogate all 21 underneath. A Weekly update tab turns the same evidence into the account's short weekly report to CreateFuture Operations.

## Output: always one HTML file

The deliverable of this skill is **always a single, self-contained `.html` file** built from the Appendix B template. This rule overrides any general routing that would otherwise send a report, dashboard or tracker somewhere else.

- **Never** produce the scan as a Claude Doc, a Docs, Sheets, Dashboard or Design artifact, a Markdown file, a `.docx`, a `.pptx`, a PDF, or a reply in chat. Do not hand-build a different page either; use the template.
- **One file, nothing external** beyond the Google Fonts link already in the template. All CSS and JS stay inline.
- **Where to save it**: write the file to the session's outputs folder (for example `/mnt/user-data/outputs/`) when one exists, otherwise to the working directory, and deliver it as a file (for example with SendUserFile). If a folder from the user's computer is connected, also save it there.
- **Name it** `<client>-risk-scan-<YYYY-MM-DD>.html`, lower case, hyphenated.
- **Do not publish it as a hosted link** (Artifact or otherwise) unless the user explicitly asks. The scan usually carries internal-only material.
- If the user asks for another format as well (a slide, an email, a Doc), produce the HTML file first and the extra format second.

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

### 2. Read Appendix A (risk factors and scoring anchors)

It holds the 21 factor definitions, the theme keys, and the 1–5 anchors for impact and probability. Score against those anchors rather than inventing a scale — the whole point is that two delivery managers scoring two engagements produce comparable numbers.

### 3. Score all 21 factors

Every factor gets an impact and a probability. Three failure modes to avoid:

- **Generic scoring.** If the scores would be identical for any engagement, you have described the factor rather than assessed this piece of work. Ground each score in something specific from the context, and say what that was.
- **Clustering at 3.** A matrix where everything sits mid-mid is decoration. Push scores apart; some factors genuinely belong at 1.
- **Inventing evidence.** Where the context is silent on a factor, score it from the little you have and mark it as an assumption. Never fabricate a detail about the client to justify a number.

Write a one-line action (`so`) for at least the top three by severity — what someone should actually do about it, not a restatement of the definition. These lines carry the exec summary, so they need to be specific to the engagement.

### 4. Fill the template and write the HTML file

Take the template in Appendix B **verbatim** and write it to a new `.html` file (see "Output: always one HTML file" above). The most reliable way is to extract the template programmatically from this SKILL.md (everything between the ```` ```html ```` fence and its closing fence) and splice in your data, rather than retyping the file. Then edit **only** the `ENGAGEMENT DATA` block at the top of the `<script>`. It holds `ENGAGEMENT`, `EXEC_HEADLINE`, `THEMES`, `RISKS`, `DELIVERABLES` and `WEEKLY_UPDATE`; everything below the END marker is presentation logic and should be left alone. Nothing else in the file needs touching — the exec summary cards, severity meters, matrix markers, quadrant lists, ranked table and glossary all derive from `RISKS`, and the Weekly update tab derives from `DELIVERABLES` and `WEEKLY_UPDATE`. You may also set the `<title>` to the engagement name and change the footer text from "Illustrative data" to "Internal only".

`EXEC_HEADLINE` is the one piece of prose you write from scratch: two or three sentences saying where the exposure concentrates and what it means. Name the pattern rather than listing the top three — the cards below already do that. "Exposure is concentrated in the client's decision-making rather than the technology" is useful; "There are several high risks" is not.

### 5. Draft the weekly update

The Weekly update tab is the account's weekly report to CreateFuture Operations. It feeds the internal status file, due Friday at 2pm. Fill `DELIVERABLES` from the SOW (codes such as A1–A7 and Gov, with a `url` wherever you can find the deliverable's document), then fill `WEEKLY_UPDATE` with exactly:

- **Top 3 successes**: the three most important things that landed this period.
- **Top 3 key risks**: the three that matter most this period, each with a trend (new, worse, stable or better).
- **Top 3 issues**: risks that have actually landed, with the ask folded into the line.
- **Top growth opportunity**: the single most relevant opportunity on the account. Prefer one that is dated and in the pipeline over a speculative one.
- **Status**: suggested Overall, Delivery, People, Client and Budget values (Green, Moderate or Critical) for the status file. Err towards flagging risk rather than staying quiet.

Every item has two versions:

- **`t`, the tab line**: as short as possible, **nine words or fewer**, tagged with at least one deliverable code in `d`. Project shorthand is fine here. No paragraphs, no owners, no rationale; the matrix carries the detail.
- **`p`, the plain-language line** used by "Copy as text": a reader with no knowledge of the client, the domain or the project must understand it. No deliverable codes, acronyms, people's names, internal system names, option labels or project nicknames. Say what the thing is in everyday words ("the client's data-protection team", "interviews with the service's end users"). Keep it to one short sentence.

Also fill `about` (one plain sentence on what the engagement is) and `plainPeriod` (the week in words). The copied text is capped at **200 words**; the tab shows a live count next to the button. Aim for around 180–190 so nothing gets cut, and check the count before you hand it over.

Three rules the user has set:

- **Mitigated is not a risk.** If cover is already in place (a named backup, a returning team member with a handover booked, an extension decision already scheduled), leave it out of Key risks. Lower the matching factor in `RISKS` too, so the matrix and the update agree.
- **Ask before calling something a risk when you are unsure.** The delivery lead knows what is already handled. Ask them which risks matter this week rather than inferring.
- **Check figures before you use them.** Hours, rates and budget numbers in RAID logs and meeting notes can be out of date or wrong. Confirm any figure that goes into an action line or the update with the delivery lead, or mark it [confirm].

Pull the period's evidence from Granola, Slack and Drive (stand-ups, sponsor calls, RAID log) before drafting. Mark the update as internal only.

### 6. Check the HTML file

Before handing anything over, open the file in a headless browser (Playwright and Chromium are usually available) and confirm:

- The page loads with no JavaScript errors.
- All three tabs render: Risk matrix, Risk glossary and Weekly update.
- The exec summary shows three cards, and the matrix shows all 21 markers.
- The Weekly update word count reads 200 or fewer (aim for 180–190), so the trend labels are not dropped and nothing is cut.

Fix any failure in the `ENGAGEMENT DATA` block and check again. A screenshot of the Weekly update tab is a quick way to sanity-check layout.

### 7. Deliver

Deliver the `.html` file itself, as set out under "Output: always one HTML file". A scan built from internal sources (RAID log rows marked not shareable, budget, team cover) is internal only: say so, and don't publish it as a link unless the user asks.

Then tell the user, briefly:

- The top three and their severity
- The quadrant spread (how many in act-now / contain / watch / monitor)
- Which scores you had to assume, so they can correct them
- Anything in the weekly update that depends on a pending decision

## Keep the skill itself free of engagement data

When improving this skill from a real engagement, carry over only the method. Never write client names, project names, people's names, contact details, budgets, rates, hours or other figures from an engagement into this file or its template. Use generic examples and placeholders instead.

## What the page contains

All of these are in the template already — this is orientation, not a build list.

1. **Header**: title, engagement kicker (client, engagement, scored date, scorer), and the three top-level tabs, "Risk matrix", "Risk glossary" and "Weekly update".
2. **Risk matrix tab**, starting with the **exec summary**: the hand-written headline, then the top three by severity as ranked cards with a five-segment severity meter and an action line.
3. **Weekly update tab**: suggested statuses; top 3 successes, top 3 key risks, top 3 issues and the top growth opportunity, tagged with deliverable chips; a deliverable key; and a "Copy as text" button with a word count, which copies the plain-language version (200 words max) for the status file.
4. **Quadrant playbook** — what Act now / Contain / Watch / Monitor each ask of you, with every factor in that quadrant listed beneath, ordered by severity.
5. **The matrix** — all factors plotted, probability on X, impact on Y, coloured by theme, with theme filters, hover detail and a side panel.
6. **Ranked register** and **glossary** — every factor by severity, and every definition grouped by theme.

## Reading the result with the user

Two things are worth saying out loud when handing a scan over, because the visual invites the wrong conclusion if nobody says them:

- **The top-left quadrant is not low risk.** Compliance obligations or a volatile business case score low on severity precisely because they rarely fire — but when they do, they end engagements. Contain them in the contract, not the plan.
- **Severity flattens two different things.** A 5/1 factor can kill the work outright while a 3/4 factor merely makes it painful, and multiplication ranks the second one higher. Read the quadrants, then the scores.

## Re-scoring an existing scan

If the user has a previous scan, open the `.html` file, read the `RISKS` array out of it, and change only the scores that have moved. Keeping the unchanged entries intact is what makes two scans comparable — and the movement between them ("S2 went from 3 to 5 after the date was fixed") is usually more interesting to a sponsor than either scan alone. Mention the notable shifts when you hand it back. When re-scoring for a new week, rewrite `WEEKLY_UPDATE` from scratch and keep it consistent with the new scores. Save the result as a new dated `.html` file rather than overwriting the old one, so the two can be compared.

## Brand

The template carries CreateFuture styling already: Syne for headings, Montserrat for body, midnight and purple surfaces, lime as the single accent, and a light/dark pair that follows the reader's system setting. Leave it be unless the user asks for another brand — in which case the colour tokens all sit in `:root` at the top of the `<style>` block, in one place.

Four of the five theme colours (aqua, amber, periwinkle, coral) are extensions rather than official brand tokens — the core palette does not carry five distinguishable data colours. If your team adopts an official chart palette, replace `--c-commercial` through `--c-team` with it.

---

## Appendix A — Risk factors and scoring anchors

The standard set of 21 factors, the definitions to use when scoring, and anchors for the 1–5 scales. Read this before scoring an engagement.

### How to score

Score each factor twice: **impact** (the damage if it lands) and **probability** (the likelihood it lands *on this engagement*, not in general). Severity is impact × probability out of 25, calculated by the template.

Three rules that keep a scan useful:

1. **Score the engagement, not the factor.** "Data migration & quality" is inherently risky, but if this engagement moves 200 rows of clean reference data, its probability is 1. Copying generic scores defeats the exercise.
2. **Impact means impact on the client's outcome**, not on the delivery team's comfort. A factor that costs the team two painful weeks but delivers on time is a 2, not a 4.
3. **Resist clustering at 3.** If everything scores 3/3 the matrix tells nobody anything. Force a spread — some factors genuinely belong at 1.

Half points (4.5) are fine and help separate markers that would otherwise overlap on the plot.

### Impact anchors (1–5)

| Score | Meaning |
|---|---|
| 1 | Absorbed inside a sprint. Nobody outside the team notices. |
| 2 | Noticeable friction. Costs days, handled within existing contingency. |
| 3 | Costs weeks or forces a scope trade. The client needs telling. |
| 4 | Threatens the date, the margin, or a committed outcome. Escalation to sponsor. |
| 5 | Threatens the engagement itself — the business case, the contract, or the relationship. |

### Probability anchors (1–5)

| Score | Meaning |
|---|---|
| 1 | Would be a genuine surprise. No current signal. |
| 2 | Plausible. Has happened on comparable engagements. |
| 3 | Even odds on this engagement. |
| 4 | Expect it. Early signals already visible. |
| 5 | Already happening, or certain to. |

If a factor scores 5 on probability it is arguably an issue rather than a risk — consider whether it belongs in the issue log instead, and say so in the exec summary.

---

### The 21 factors

#### Commercial & Contractual (`commercial`)

The deal itself: what was agreed, how it is priced, whether the justification holds, and whether the client is one you should be serving.

| ID | Factor | Definition to use |
|---|---|---|
| C1 | Contractual ambiguity | Gaps between what was sold, what was signed, and what the client expects to receive. |
| C2 | Commercial model risk | Fixed price vs T&M, margin sensitivity, penalty clauses, gain-share mechanics. |
| C3 | Business case volatility | The underlying justification shifts mid-flight and renders the current scope obsolete. |
| C4 | ICP fit | Whether a new client maps to the ideal client profile and the wider strategy. |

#### Technical & Solution Complexity (`technical`)

The inherent difficulty of the thing being built, plus the conditions needed to prove it works.

| ID | Factor | Definition to use |
|---|---|---|
| T1 | Technical complexity | Platforms, integrations, legacy dependencies. |
| T2 | Integration touchpoints | Number of systems, APIs or platforms that must talk to each other at go-live. |
| T3 | Data migration & quality | Volume, cleanliness and mapping complexity of data moving between systems. |
| T4 | Testing & environment constraints | Production environments that cannot be replicated, and reliance on mocked data for critical integrations. |
| T5 | NFR stringency | Extreme performance, latency, availability or accessibility targets that dictate architecture. |

#### Scope, Schedule & Dependencies (`scope`)

Constraints on what must be delivered, by when, and what else has to line up first.

| ID | Factor | Definition to use |
|---|---|---|
| S1 | Requirement ambiguity | How well defined the scope and success criteria actually are. |
| S2 | Timeline compression | How tight the deadline is relative to scope — immovable or political dates. |
| S3 | Dependency chain length | How many third parties, vendors or parallel workstreams must align. |
| S4 | Compliance requirements | Regulatory, audit and data protection obligations. |

#### Client & Stakeholder Environment (`client`)

The client's ability and willingness to decide, absorb, and adopt.

| ID | Factor | Definition to use |
|---|---|---|
| K1 | Client political complexity | Power dynamics, hidden agendas, sponsor strength, organisational change fatigue. |
| K2 | Stakeholder density | Number of decision-makers, competing interests, approval chains. |
| K3 | Client maturity level | Technical understanding and willingness to take ownership. |
| K4 | Organisational readiness | Capacity to absorb the project alongside everything else they are running. |
| K5 | High change impact | Degree of disruption to BAU processes, people and systems. |

#### Team & Delivery Capability (`team`)

Whether you have the right people, arranged in a workable way, doing something they have done before.

| ID | Factor | Definition to use |
|---|---|---|
| D1 | Cast team | The start date dictated a team that was available rather than one that matched the need. |
| D2 | Team distribution | Geographic spread, time zones, onshore/offshore mix, language barriers. |
| D3 | Novelty / first-of-kind | Whether the team or client has done anything like this before. |

---

### Grouping judgement calls

Two placements are debatable, and it is worth knowing why they sit where they do:

- **S4 Compliance requirements** sits under Scope because regulation acts as a non-negotiable boundary on scope and pace. It could equally sit under Technical, since regulation often dictates architecture.
- **D3 Novelty / first-of-kind** sits under Team because the factor is framed around prior experience rather than the technology itself.

An alternative cut is to align the five themes to **owners** — commercial lead, tech lead, delivery lead — rather than to subject. The theme filters in the scanner support this reading: give each owner a colour and the matrix becomes an accountability view. If a team works that way, rename the `THEMES` labels in the template and keep the keys unchanged.

### Adding or removing factors

The template is driven entirely by the `RISKS` array, so adding a factor is a matter of appending an entry with a new ID and one of the five theme keys. Keep IDs to two or three characters — they are rendered inside the matrix markers and longer strings overflow the circles.

If an engagement genuinely has no exposure to a factor, score it low rather than deleting it. A factor that is present at 1/1 tells the reader it was considered; a missing factor looks like an oversight.

---

## Appendix B — HTML template

Reproduce this file exactly, then edit only the ENGAGEMENT DATA block (which includes `DELIVERABLES` and `WEEKLY_UPDATE`).

````html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Agentic Delivery Risk Scanner</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  /* ============ CreateFuture brand tokens ============
     Midnight #0A0019 · Purple #24004C · Lime #C3FF34
     Magenta #7D2271 · Pink #FE7AF6 · Off-white #F2F2F2 · Mid grey #9E9E9E
  ==================================================== */
  :root{
    --font-head:'Syne','Arial Black',sans-serif;
    --font-body:'Montserrat','Arial',sans-serif;

    --lime:#C3FF34;
    --midnight:#0A0019;
    --purple:#24004C;

    /* light surface (default) */
    --bg:#F2F2F2;
    --bg-tint:rgba(36,0,76,.05);
    --surface:#FFFFFF;
    --surface-2:#EBE9EF;
    --surface-3:#E0DDE6;
    --border:rgba(10,0,25,.13);
    --border-strong:rgba(10,0,25,.3);
    --text:#0A0019;
    --text-dim:#544E61;
    --text-faint:#8A8493;
    --grid:rgba(10,0,25,.06);
    --grid-major:rgba(10,0,25,.22);

    --hot:#7D2271;                    /* emphasis that must read as text */
    --hot-bg:rgba(195,255,52,.30);    /* lime wash for the act-now field */
    --lime-ink:#0A0019;               /* text on lime */
    --cool-bg:rgba(36,0,76,.04);
    --shadow-lg:0 20px 44px -26px rgba(10,0,25,.4);
    --shadow-sm:0 2px 10px -5px rgba(10,0,25,.3);

    --c-commercial:#7D2271;
    --c-technical:#0E7D6B;
    --c-scope:#9C5400;
    --c-client:#3B4FB8;
    --c-team:#B03A28;
  }
  @media (prefers-color-scheme: dark){
    :root:not([data-theme="light"]){
      --bg:#0A0019;
      --bg-tint:rgba(36,0,76,.55);
      --surface:#140A28;
      --surface-2:#1C0E38;
      --surface-3:#24004C;
      --border:rgba(242,242,242,.14);
      --border-strong:rgba(242,242,242,.32);
      --text:#FFFFFF;
      --text-dim:#BDB6C8;
      --text-faint:#9E9E9E;
      --grid:rgba(242,242,242,.06);
      --grid-major:rgba(242,242,242,.2);
      --hot:#C3FF34;
      --hot-bg:rgba(195,255,52,.13);
      --cool-bg:rgba(125,34,113,.12);
      --shadow-lg:0 22px 50px -26px rgba(0,0,0,.85);
      --shadow-sm:0 2px 12px -6px rgba(0,0,0,.8);
      --c-commercial:#FE7AF6;
      --c-technical:#5AE5C8;
      --c-scope:#FFB43D;
      --c-client:#9AA8FF;
      --c-team:#FF8A7A;
    }
  }
  :root[data-theme="dark"]{
    --bg:#0A0019;
    --bg-tint:rgba(36,0,76,.55);
    --surface:#140A28;
    --surface-2:#1C0E38;
    --surface-3:#24004C;
    --border:rgba(242,242,242,.14);
    --border-strong:rgba(242,242,242,.32);
    --text:#FFFFFF;
    --text-dim:#BDB6C8;
    --text-faint:#9E9E9E;
    --grid:rgba(242,242,242,.06);
    --grid-major:rgba(242,242,242,.2);
    --hot:#C3FF34;
    --hot-bg:rgba(195,255,52,.13);
    --cool-bg:rgba(125,34,113,.12);
    --shadow-lg:0 22px 50px -26px rgba(0,0,0,.85);
    --shadow-sm:0 2px 12px -6px rgba(0,0,0,.8);
    --c-commercial:#FE7AF6;
    --c-technical:#5AE5C8;
    --c-scope:#FFB43D;
    --c-client:#9AA8FF;
    --c-team:#FF8A7A;
  }

  *{box-sizing:border-box;}
  html,body{margin:0;padding:0;}
  body{
    background:var(--bg);
    background-image:
      radial-gradient(900px 620px at 84% -10%, var(--bg-tint), transparent 72%),
      radial-gradient(700px 480px at -5% 108%, var(--cool-bg), transparent 70%);
    color:var(--text);
    font-family:var(--font-body);
    font-size:16px;line-height:1.6;
    -webkit-font-smoothing:antialiased;
  }
  .wrap{max-width:1140px;margin:0 auto;padding:clamp(22px,4vw,60px) clamp(14px,3.5vw,34px) 70px;}
  .label{
    font-family:var(--font-body);font-weight:600;font-size:10.5px;
    letter-spacing:.2em;text-transform:uppercase;color:var(--text-faint);
  }
  .nums{font-variant-numeric:tabular-nums;}

  /* ---------- Header ---------- */
  .bar{height:4px;width:52px;background:var(--lime);border-radius:2px;}
  .kicker{display:flex;flex-wrap:wrap;gap:6px 22px;margin-top:12px;font-weight:600;font-size:10px;letter-spacing:.16em;text-transform:uppercase;color:var(--text-faint);}
  .kicker b{color:var(--text-dim);font-weight:600;}
  header{padding-bottom:0;}
  .kicker{display:flex;align-items:center;gap:14px;margin:18px 0 0;}
  .kicker span{font-family:var(--font-body);font-weight:600;font-size:11px;letter-spacing:.22em;text-transform:uppercase;color:var(--text-dim);}
  h1{
    font-family:var(--font-head);font-weight:800;
    font-size:clamp(20px,3.1vw,32px);line-height:1.12;letter-spacing:-.02em;
    margin:14px 0 0;max-width:none;
  }
  h1 em{font-style:normal;color:var(--hot);}
  .strap{
    margin:18px 0 0;max-width:34ch;font-weight:500;
    font-size:clamp(17px,2.2vw,24px);line-height:1.3;letter-spacing:-.01em;color:var(--text);
  }
  .lead{margin:16px 0 0;max-width:60ch;font-size:clamp(14.5px,1.4vw,16px);color:var(--text-dim);}
  .callout{
    margin-top:24px;padding:14px 18px;border-left:4px solid var(--lime);
    background:var(--surface);border-radius:0 10px 10px 0;font-size:14px;
    color:var(--text-dim);max-width:64ch;box-shadow:var(--shadow-sm);
  }
  .callout strong{color:var(--text);font-weight:600;}

  /* ---------- Exec summary ---------- */
  .exec{
    margin:clamp(22px,3vw,34px) 0 0;background:var(--surface);border:1px solid var(--border);
    border-radius:16px;box-shadow:var(--shadow-sm);overflow:hidden;
  }
  .exec-head{padding:20px 22px 18px;border-left:4px solid var(--lime);}
  .exec-line{margin:10px 0 0;max-width:78ch;font-size:clamp(14.5px,1.5vw,16.5px);color:var(--text-dim);}
  .exec-top{
    display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:1px;
    background:var(--border);border-top:1px solid var(--border);
  }
  .ex{background:var(--surface-2);padding:17px 20px 19px;min-width:0;position:relative;}
  .ex-rank{
    font-family:var(--font-head);font-weight:800;font-size:10.5px;letter-spacing:.1em;
    color:var(--lime-ink);background:var(--lime);border-radius:4px;padding:1px 7px;
  }
  .ex-sev{float:right;text-align:right;}
  .ex-meter{display:flex;gap:3px;justify-content:flex-end;}
  .ex-meter i{
    width:8px;height:19px;border-radius:2px;
    border:1px solid color-mix(in srgb, var(--ec) 45%, transparent);background:transparent;
  }
  .ex-meter i[data-on="1"]{background:var(--ec);border-color:var(--ec);}
  .ex-sev .cap{
    display:block;margin-top:6px;font-weight:600;font-size:9px;letter-spacing:.16em;
    text-transform:uppercase;color:var(--text-faint);
  }
  .ex-name{
    font-family:var(--font-head);font-weight:700;font-size:16.5px;line-height:1.2;
    letter-spacing:-.01em;margin:12px 0 4px;
  }
  .ex-name .eid{font-size:11px;letter-spacing:.06em;color:var(--ec);margin-right:7px;}
  .ex-theme{font-weight:600;font-size:9.5px;letter-spacing:.16em;text-transform:uppercase;color:var(--text-faint);}
  .ex-so{margin:10px 0 0;font-size:13px;line-height:1.5;color:var(--text-dim);}
  .ex-scores{
    margin-top:11px;font-weight:600;font-size:9.5px;letter-spacing:.14em;text-transform:uppercase;
    color:var(--text-faint);font-variant-numeric:tabular-nums;
  }
  .exec-meta{
    display:flex;flex-wrap:wrap;gap:6px 26px;padding:13px 22px;border-top:1px solid var(--border);
    font-weight:600;font-size:10px;letter-spacing:.16em;text-transform:uppercase;color:var(--text-faint);
  }
  .exec-meta b{color:var(--text);font-variant-numeric:tabular-nums;}

  /* ---------- Tabs ---------- */
  .tabs{display:flex;flex-wrap:wrap;gap:4px;margin:clamp(18px,2.4vw,26px) 0 0;border-bottom:1px solid var(--border);}
  .tab{
    appearance:none;background:none;border:none;cursor:pointer;
    font-family:var(--font-body);font-weight:600;font-size:11px;letter-spacing:.18em;
    text-transform:uppercase;color:var(--text-faint);padding:12px 16px;
    border-bottom:3px solid transparent;margin-bottom:-1px;transition:color .16s, border-color .16s;
  }
  .tab:hover{color:var(--text-dim);}
  .tab[aria-selected="true"]{color:var(--text);border-bottom-color:var(--lime);}
  .tab:focus-visible{outline:2px solid var(--hot);outline-offset:-2px;border-radius:4px;}

  /* ---------- Glossary ---------- */
  .glossary{display:flex;flex-direction:column;gap:14px;}
  .gl-group{
    background:var(--surface);border:1px solid var(--border);border-radius:14px;
    padding:18px 20px;border-left:4px solid var(--gc);min-width:0;box-shadow:var(--shadow-sm);
  }
  .gl-head{display:flex;align-items:baseline;gap:10px;flex-wrap:wrap;margin-bottom:16px;}
  .gl-head h3{font-family:var(--font-head);font-weight:700;font-size:16.5px;letter-spacing:-.01em;margin:0;color:var(--gc);}
  .gl-head .ct{font-weight:600;font-size:10px;letter-spacing:.18em;text-transform:uppercase;color:var(--text-faint);}
  .gl-items{display:grid;grid-template-columns:repeat(auto-fit,minmax(290px,1fr));gap:14px;}
  .gl-item{display:grid;grid-template-columns:34px minmax(0,1fr);gap:11px;min-width:0;}
  .gl-item .gid{
    font-family:var(--font-head);font-weight:700;font-size:10.5px;letter-spacing:.04em;text-align:center;
    color:var(--gc);background:color-mix(in srgb, var(--gc) 20%, transparent);
    border:1px solid color-mix(in srgb, var(--gc) 50%, transparent);border-radius:5px;
    height:22px;display:grid;place-items:center;
  }
  .gl-item .gname{font-weight:600;font-size:14px;line-height:1.3;}
  .gl-item .gwhy{margin:4px 0 0;font-size:13px;color:var(--text-dim);line-height:1.5;}
  .gl-item .gsco{
    margin-top:6px;font-weight:600;font-size:9.5px;letter-spacing:.16em;text-transform:uppercase;
    color:var(--text-faint);font-variant-numeric:tabular-nums;
  }

  /* ---------- Sections ---------- */
  section{margin-top:clamp(36px,5vw,66px);}
  .section-label{display:flex;align-items:center;gap:12px;}
  .section-label .num{
    font-family:var(--font-head);font-weight:700;font-size:12px;letter-spacing:.1em;
    color:var(--lime-ink);background:var(--lime);padding:2px 8px;border-radius:4px;
  }
  h2{font-family:var(--font-head);font-weight:700;font-size:clamp(21px,2.8vw,31px);letter-spacing:-.02em;margin:12px 0 6px;}
  .section-note{color:var(--text-dim);font-size:14.5px;margin:0 0 22px;max-width:62ch;}

  /* ---------- Filters ---------- */
  .filters{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:18px;}
  .chip{
    font-family:var(--font-body);font-weight:600;font-size:11px;letter-spacing:.12em;
    text-transform:uppercase;background:var(--surface);color:var(--text-dim);
    border:1px solid var(--border);padding:7px 13px 7px 10px;border-radius:999px;
    cursor:pointer;display:inline-flex;align-items:center;gap:8px;
    transition:border-color .16s, color .16s, opacity .2s;
  }
  .chip:hover{border-color:var(--border-strong);color:var(--text);}
  .chip .dot{width:9px;height:9px;border-radius:50%;background:var(--ch);flex:none;}
  .chip[aria-pressed="false"]{opacity:.4;}

  /* ---------- Matrix ---------- */
  .matrix-shell{display:grid;grid-template-columns:minmax(0,1fr) 258px;gap:22px;align-items:start;}
  @media (max-width:900px){ .matrix-shell{grid-template-columns:minmax(0,1fr);} }

  .plot-frame{
    position:relative;background:var(--surface);border:1px solid var(--border);
    border-radius:16px;padding:16px;box-shadow:var(--shadow-lg);
    display:grid;grid-template-columns:22px minmax(0,1fr);grid-template-rows:minmax(0,1fr) 24px;
  }
  .y-axis,.x-axis{
    font-family:var(--font-body);font-weight:600;font-size:10.5px;letter-spacing:.2em;
    text-transform:uppercase;color:var(--text-faint);display:flex;align-items:center;justify-content:center;
  }
  .y-axis{grid-column:1;grid-row:1;writing-mode:vertical-rl;transform:rotate(180deg);}
  .x-axis{grid-column:2;grid-row:2;}
  .field{
    grid-column:2;grid-row:1;position:relative;aspect-ratio:1/1;min-height:300px;
    border:1px solid var(--border-strong);border-radius:10px;overflow:hidden;
    background:
      linear-gradient(to top right, transparent 38%, var(--hot-bg) 100%),
      linear-gradient(var(--grid) 1px, transparent 1px),
      linear-gradient(90deg, var(--grid) 1px, transparent 1px);
    background-size:auto, 12.5% 12.5%, 12.5% 12.5%;
  }
  .divider-v,.divider-h{position:absolute;background:var(--grid-major);}
  .divider-v{left:50%;top:0;bottom:0;width:1px;}
  .divider-h{top:50%;left:0;right:0;height:1px;}
  .qlabel{
    position:absolute;pointer-events:none;max-width:44%;line-height:1.5;
    font-size:10.5px;color:var(--text-faint);
  }
  .qlabel b{
    display:block;font-family:var(--font-head);font-weight:700;font-size:12.5px;
    letter-spacing:.06em;text-transform:uppercase;color:var(--text-dim);margin-bottom:1px;
  }
  .q-tr{top:12px;right:14px;text-align:right;}
  .q-tr b{color:var(--hot);}
  .q-tl{top:12px;left:14px;}
  .q-br{bottom:12px;right:14px;text-align:right;}
  .q-bl{bottom:12px;left:14px;}

  .blip{
    position:absolute;transform:translate(-50%,50%);
    --blip:clamp(29px,5.4vw,38px);width:var(--blip);height:var(--blip);
    border-radius:50%;border:1.5px solid var(--bc);
    background:color-mix(in srgb, var(--bc) 22%, var(--surface));
    color:var(--bc);font-family:var(--font-head);font-weight:700;
    font-size:clamp(10px,1.6vw,12px);letter-spacing:.02em;cursor:pointer;padding:0;
    display:grid;place-items:center;z-index:2;
    transition:transform .16s ease, box-shadow .16s ease, opacity .2s;
  }
  .blip:hover,.blip:focus-visible{
    transform:translate(-50%,50%) scale(1.18);z-index:5;outline:none;
    box-shadow:0 0 0 4px color-mix(in srgb, var(--bc) 26%, transparent);
  }
  .blip[data-muted="true"]{opacity:.15;pointer-events:none;}
  .blip[data-selected="true"]{box-shadow:0 0 0 3px var(--surface), 0 0 0 5px var(--bc);z-index:6;}
  @keyframes blipIn{from{opacity:0;transform:translate(-50%,50%) scale(.4);}to{opacity:1;transform:translate(-50%,50%) scale(1);}}
  .blip{animation:blipIn .42s cubic-bezier(.2,.8,.3,1) backwards;}

  .tip{
    position:absolute;z-index:20;pointer-events:none;opacity:0;transition:opacity .13s;
    background:var(--surface-3);border:1px solid var(--border-strong);border-radius:10px;
    padding:10px 13px;max-width:min(262px,74%);box-shadow:var(--shadow-lg);
    font-size:12.5px;line-height:1.45;color:var(--text-dim);
  }
  .tip[data-show="true"]{opacity:1;}
  .tip .tip-name{
    display:block;font-family:var(--font-head);font-weight:700;color:var(--text);
    font-size:13.5px;margin-bottom:4px;line-height:1.25;
  }
  .tip .tip-scores{
    display:block;margin-top:6px;font-weight:600;font-size:10.5px;letter-spacing:.14em;
    text-transform:uppercase;color:var(--text-faint);font-variant-numeric:tabular-nums;
  }

  /* ---------- Side rail ---------- */
  .rail{display:flex;flex-direction:column;gap:14px;min-width:0;}
  .card{
    background:var(--surface);border:1px solid var(--border);border-radius:14px;
    padding:16px 18px;min-width:0;overflow-wrap:break-word;
  }
  .card--detail{background:var(--surface-2);box-shadow:var(--shadow-sm);border-color:var(--border-strong);}
  .card h3{margin:0 0 12px;font-family:var(--font-body);font-weight:600;font-size:10.5px;letter-spacing:.2em;text-transform:uppercase;color:var(--text-faint);}
  .detail-code{font-weight:600;font-size:10.5px;letter-spacing:.16em;text-transform:uppercase;color:var(--dc,var(--hot));}
  .detail-name{font-family:var(--font-head);font-weight:700;font-size:18px;letter-spacing:-.01em;margin:5px 0 7px;line-height:1.2;}
  .detail-why{font-size:13.5px;color:var(--text-dim);margin:0 0 14px;}
  .bars{display:flex;flex-direction:column;gap:10px;}
  .bar-row{display:grid;grid-template-columns:74px minmax(0,1fr) 30px;gap:9px;align-items:center;}
  .bar-row span:first-child{font-weight:600;font-size:9.5px;letter-spacing:.16em;text-transform:uppercase;color:var(--text-faint);}
  .bar-track{height:7px;border-radius:99px;background:var(--surface-3);overflow:hidden;}
  .bar-fill{height:100%;border-radius:99px;background:var(--dc,var(--hot));transition:width .3s ease;}
  .bar-num{font-family:var(--font-head);font-weight:700;font-size:12.5px;text-align:right;font-variant-numeric:tabular-nums;}
  .zone-pill{
    display:inline-block;margin-top:14px;font-weight:600;font-size:10px;letter-spacing:.16em;
    text-transform:uppercase;padding:5px 10px;border-radius:5px;
    background:var(--lime);color:var(--lime-ink);
  }
  .legend-list{display:flex;flex-direction:column;gap:8px;margin:0;padding:0;list-style:none;}
  .legend-list li{display:flex;align-items:center;gap:10px;font-size:13px;color:var(--text-dim);min-width:0;}
  .legend-list .sw{width:10px;height:10px;border-radius:3px;background:var(--ch);flex:none;}
  .legend-list .ct{margin-left:auto;font-weight:600;font-size:11px;color:var(--text-faint);font-variant-numeric:tabular-nums;}

  /* ---------- Playbook ---------- */
  .playbook{display:grid;grid-template-columns:repeat(auto-fit,minmax(218px,1fr));gap:13px;}
  .section-label + .playbook{margin-top:20px;}
  .pb{
    background:var(--surface);border:1px solid var(--border);border-radius:14px;
    padding:17px 18px;border-top:3px solid var(--pc,var(--border-strong));min-width:0;
  }
  .pb--primary{background:var(--surface-2);box-shadow:var(--shadow-sm);}
  .pb .pb-q{font-weight:600;font-size:9.5px;letter-spacing:.18em;text-transform:uppercase;color:var(--text-faint);}
  .pb h4{font-family:var(--font-head);font-weight:700;margin:8px 0 8px;font-size:17px;letter-spacing:-.01em;display:flex;align-items:baseline;gap:8px;}
  .pb h4 .cnt{font-family:var(--font-body);font-weight:600;font-size:11px;letter-spacing:.1em;color:var(--text-faint);}
  .pb p{margin:0;font-size:13.5px;color:var(--text-dim);}
  .pb-list{list-style:none;margin:14px 0 0;padding:14px 0 0;border-top:1px solid var(--border);display:flex;flex-direction:column;gap:9px;}
  .pb-list li{display:grid;grid-template-columns:26px minmax(0,1fr) auto;gap:9px;align-items:start;font-size:12.5px;line-height:1.35;}
  .pb-list .pid{
    font-family:var(--font-head);font-weight:700;font-size:10px;letter-spacing:.04em;
    color:var(--pl-ink,var(--text));background:color-mix(in srgb, var(--pl) 24%, transparent);
    border:1px solid color-mix(in srgb, var(--pl) 55%, transparent);
    border-radius:4px;text-align:center;padding:2px 0;
  }
  .pb-list .pname{color:var(--text);font-weight:500;overflow-wrap:break-word;}
  .pb-list .psev{display:flex;gap:2px;align-items:center;padding-top:3px;}
  .pb-list .psev i{
    width:5px;height:12px;border-radius:1.5px;
    border:1px solid color-mix(in srgb, var(--pl) 45%, transparent);background:transparent;
  }
  .pb-list .psev i[data-on="1"]{background:var(--pl);border-color:var(--pl);}
  .pb-more{margin:10px 0 0;font-weight:600;font-size:9.5px;letter-spacing:.16em;text-transform:uppercase;color:var(--text-faint);}

  /* ---------- Table ---------- */
  .table-wrap{overflow-x:auto;border:1px solid var(--border);border-radius:14px;background:var(--surface);box-shadow:var(--shadow-sm);}
  table{width:100%;border-collapse:collapse;font-size:14px;min-width:730px;}
  thead th{
    position:sticky;top:0;background:var(--surface-2);text-align:left;
    font-weight:600;font-size:9.5px;letter-spacing:.18em;text-transform:uppercase;
    color:var(--text-faint);padding:13px 15px;border-bottom:1px solid var(--border-strong);white-space:nowrap;
  }
  tbody td{padding:12px 15px;border-bottom:1px solid var(--border);vertical-align:top;}
  tbody tr:last-child td{border-bottom:none;}
  tbody tr{cursor:pointer;}
  tbody tr[data-muted="true"]{opacity:.3;}
  tbody tr[data-selected="true"]{background:var(--surface-2);}
  .num{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap;}
  .rcode{font-family:var(--font-head);font-weight:700;font-size:11.5px;letter-spacing:.06em;color:var(--rc);}
  .rname{font-weight:600;}
  .rwhy{display:block;color:var(--text-faint);font-size:12.5px;margin-top:3px;max-width:46ch;line-height:1.5;}
  .theme-cell{white-space:nowrap;font-size:12.5px;color:var(--text-dim);}
  .theme-cell .sw{display:inline-block;width:8px;height:8px;border-radius:2px;background:var(--rc);margin-right:8px;}
  .score{font-family:var(--font-head);font-weight:700;}
  .zone{font-weight:600;font-size:10px;letter-spacing:.14em;text-transform:uppercase;white-space:nowrap;}
  .zone[data-z="act"]{color:var(--hot);}
  .zone[data-z="contain"],.zone[data-z="watch"]{color:var(--text-dim);}
  .zone[data-z="monitor"]{color:var(--text-faint);}

  details{margin-top:15px;border:1px solid var(--border);border-radius:12px;background:var(--surface);}
  summary{cursor:pointer;padding:13px 17px;font-weight:600;font-size:10.5px;letter-spacing:.18em;text-transform:uppercase;color:var(--text-dim);}
  details[open] summary{border-bottom:1px solid var(--border);}
  .details-body{padding:15px 17px;font-size:14px;color:var(--text-dim);}
  .details-body ul{margin:0;padding-left:19px;}
  .details-body li{margin-bottom:9px;}
  .details-body strong{color:var(--text);font-weight:600;}

  footer{
    margin-top:50px;padding-top:20px;border-top:1px solid var(--border);
    display:flex;flex-wrap:wrap;gap:10px 24px;align-items:center;justify-content:space-between;
  }
  .wordmark{font-family:var(--font-head);font-weight:800;font-size:15px;letter-spacing:-.01em;}
  .wordmark span{color:var(--hot);}
  .foot-meta{display:flex;flex-wrap:wrap;gap:8px 20px;font-weight:600;font-size:10px;letter-spacing:.18em;text-transform:uppercase;color:var(--text-faint);}


  /* ---------- Weekly update ---------- */
  .wu-head{display:flex;flex-wrap:wrap;gap:10px 20px;align-items:center;justify-content:space-between;}
  .wu-meta{font-weight:600;font-size:13px;color:var(--text);}
  .wu-copy{font-family:var(--font-body);font-weight:600;font-size:10.5px;letter-spacing:.14em;text-transform:uppercase;
    background:var(--lime);color:var(--lime-ink);border:none;border-radius:999px;padding:8px 14px;cursor:pointer;}
  .wu-copywrap{display:inline-flex;align-items:center;gap:10px;}
  .wu-wc{font-weight:600;font-size:10px;letter-spacing:.14em;text-transform:uppercase;color:var(--text-faint);font-variant-numeric:tabular-nums;}
  .wu-copy:focus-visible{outline:2px solid var(--hot);outline-offset:2px;}
  .wu-status{display:flex;flex-wrap:wrap;gap:6px;margin:12px 0 0;}
  .wu-pill{display:inline-flex;gap:7px;align-items:center;border:1px solid var(--border);background:var(--surface);border-radius:999px;
    padding:4px 11px;font-weight:600;font-size:10px;letter-spacing:.14em;text-transform:uppercase;color:var(--text-faint);}
  .wu-pill b{color:var(--text);}
  .wu-pill i{width:7px;height:7px;border-radius:50%;background:var(--sc);}
  .wu-pill[data-s="Critical"]{--sc:var(--c-team);}
  .wu-pill[data-s="Moderate"]{--sc:var(--c-scope);}
  .wu-pill[data-s="Green"]{--sc:var(--c-technical);}
  .wu-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,440px),1fr));gap:12px;margin-top:16px;}
  .wu-card{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:14px 16px;border-left:3px solid var(--wc);min-width:0;}
  .wu-card h3{font-family:var(--font-head);font-weight:700;font-size:14.5px;margin:0 0 8px;color:var(--wc);}
  .wu-list{list-style:none;margin:0;padding:0;}
  .wu-list li{display:flex;gap:10px;justify-content:space-between;align-items:baseline;padding:7px 0;border-top:1px solid var(--border);font-size:13.5px;line-height:1.4;}
  .wu-list li:first-child{border-top:none;}
  .wu-tags{display:flex;gap:5px;flex:none;align-items:baseline;}
  .wu-d{font-family:var(--font-head);font-weight:700;font-size:10px;letter-spacing:.04em;text-decoration:none;
    color:var(--text);border:1px solid var(--border-strong);border-radius:4px;padding:1px 6px;background:var(--surface-2);white-space:nowrap;}
  a.wu-d{border-color:var(--hot);color:var(--hot);}
  a.wu-d:hover{background:var(--hot-bg);}
  .wu-trend{font-weight:600;font-size:9px;letter-spacing:.14em;text-transform:uppercase;color:var(--text-faint);}
  .wu-trend[data-t="worse"],.wu-trend[data-t="new"]{color:var(--hot);}
  .wu-key{margin:14px 0 0;font-size:11.5px;color:var(--text-faint);line-height:2;}
  .wu-key .sep{margin:0 8px;}
  .wu-note{font-size:11.5px;color:var(--text-faint);margin:6px 0 0;}

  @media (prefers-reduced-motion: reduce){ *{animation:none !important;transition:none !important;} }
</style>
</head>
<body>
<div class="wrap">

<header>
  <div class="bar"></div>
  <h1>Agentic Delivery <em>Risk Scanner</em></h1>
  <div class="kicker" id="kicker"></div>
  <nav class="tabs" role="tablist" aria-label="Views">
  <button class="tab" role="tab" id="tab-matrix" aria-controls="panel-matrix" aria-selected="true">Risk matrix</button>
  <button class="tab" role="tab" id="tab-glossary" aria-controls="panel-glossary" aria-selected="false">Risk glossary</button>
  <button class="tab" role="tab" id="tab-weekly" aria-controls="panel-weekly" aria-selected="false">Weekly update</button>
</nav>
</header>

<div class="panel" id="panel-matrix" role="tabpanel" aria-labelledby="tab-matrix">
<div class="exec">
  <div class="exec-head">
    <span class="label">Executive summary</span>
    <p class="exec-line" id="exec-line"></p>
  </div>
  <div class="exec-top" id="exec-top"></div>
  <div class="exec-meta">
    <span id="meta-count"></span>
    <span><b id="kpi-act">10</b> in the act-now zone</span>
    <span>Mean severity <b id="kpi-mean">12.1</b> of 25</span>
  </div>
</div>
<section>
  <div class="section-label"><span class="num">01</span><span class="label">Quadrant playbook</span></div>
  <div class="playbook">
    <div class="pb pb--primary" data-zone="act" style="--pc:var(--lime)">
      <div class="pb-q">High impact · high probability</div>
      <h4>Act now</h4>
      <p>Named owner, mitigation in the plan, contingency in the estimate. If these are still open at mobilisation, the delivery date is a guess.</p>
      <ul class="pb-list"></ul>
    </div>
    <div class="pb" data-zone="contain" style="--pc:var(--c-commercial)">
      <div class="pb-q">High impact · low probability</div>
      <h4>Contain</h4>
      <p>Handle in the contract and the commercial model rather than the plan. Caps, change control, exit clauses, insurance.</p>
      <ul class="pb-list"></ul>
    </div>
    <div class="pb" data-zone="watch" style="--pc:var(--c-scope)">
      <div class="pb-q">Low impact · high probability</div>
      <h4>Watch</h4>
      <p>Near-certain friction you can absorb. Design cadence and ways of working so these never accumulate into something structural.</p>
      <ul class="pb-list"></ul>
    </div>
    <div class="pb" data-zone="monitor" style="--pc:var(--c-team)">
      <div class="pb-q">Low impact · low probability</div>
      <h4>Monitor</h4>
      <p>Review at stage gates only. Spending mitigation effort here is the most common form of risk-management theatre.</p>
      <ul class="pb-list"></ul>
    </div>
  </div>
</section>

<section>
  <div class="section-label"><span class="num">02</span><span class="label">The matrix</span></div>
  <h2>Where each factor sits</h2>
  <p class="section-note">Tap or hover a marker for detail. Use the theme chips to isolate one group — useful when a single owner wants to see only their column of the risk register.</p>

  <div class="filters" id="filters"></div>

  <div class="matrix-shell">
    <div class="plot-frame">
      <div class="y-axis">Impact if realised →</div>
      <div class="field" id="field">
        <div class="divider-v"></div>
        <div class="divider-h"></div>
        <div class="qlabel q-tl"><b>Contain</b>Hurts badly, rarely fires</div>
        <div class="qlabel q-tr"><b>Act now</b>Mitigate before mobilisation</div>
        <div class="qlabel q-bl"><b>Monitor</b>Note it, move on</div>
        <div class="qlabel q-br"><b>Watch</b>Constant friction, survivable</div>
        <div class="tip" id="tip"></div>
      </div>
      <div class="x-axis">Probability of occurring →</div>
    </div>

    <div class="rail">
      <div class="card card--detail" id="detail">
        <h3>Selected factor</h3>
        <div class="detail-code" id="d-code">—</div>
        <div class="detail-name" id="d-name">Pick a marker</div>
        <p class="detail-why" id="d-why">Hover or tap any marker on the matrix to read its definition and scores.</p>
        <div class="bars">
          <div class="bar-row"><span>Impact</span><div class="bar-track"><div class="bar-fill" id="d-ibar" style="width:0%"></div></div><span class="bar-num" id="d-inum">–</span></div>
          <div class="bar-row"><span>Probability</span><div class="bar-track"><div class="bar-fill" id="d-pbar" style="width:0%"></div></div><span class="bar-num" id="d-pnum">–</span></div>
        </div>
        <span class="zone-pill" id="d-zone" hidden></span>
      </div>
      <div class="card">
        <h3>Themes</h3>
        <ul class="legend-list" id="legend"></ul>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="section-label"><span class="num">03</span><span class="label">Ranked register</span></div>
  <h2>All 21 factors by severity</h2>
  <p class="section-note">Severity is impact multiplied by probability, out of a maximum of 25. Rows follow the theme filters above; click a row to select it on the matrix.</p>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th><th>Risk factor</th><th>Theme</th>
          <th class="num">Impact</th><th class="num">Prob.</th><th class="num">Severity</th><th>Zone</th>
        </tr>
      </thead>
      <tbody id="tbody"></tbody>
    </table>
  </div>

</section>

</div>

<div class="panel" id="panel-glossary" role="tabpanel" aria-labelledby="tab-glossary" hidden>
  <section style="margin-top:clamp(24px,3vw,36px)">
    <div class="section-label"><span class="num">G</span><span class="label">Risk glossary</span></div>
    <p class="section-note" style="margin-top:16px">Every factor in the scanner, grouped by theme, with the definition used when scoring it. Scores shown are impact, probability and resulting severity.</p>
    <div class="glossary" id="glossary"></div>
  </section>
</div>

<div class="panel" id="panel-weekly" role="tabpanel" aria-labelledby="tab-weekly" hidden>
  <section style="margin-top:clamp(20px,2.6vw,30px)">
    <div class="wu-head">
      <div class="wu-meta" id="wu-meta"></div>
      <span class="wu-copywrap"><span class="wu-wc" id="wu-wc"></span><button class="wu-copy" type="button" id="wu-copy">Copy as text</button></span>
    </div>
    <div class="wu-status" id="wu-status"></div>
    <p class="wu-note">Suggested statuses for the Ops status file · internal only</p>
    <div class="wu-grid" id="wu-grid"></div>
    <p class="wu-key" id="wu-key"></p>
  </section>
</div>
<footer>
  <div class="wordmark">Create<span>future</span></div>
  <div class="foot-meta">
    <span id="foot-count"></span>
    <span>Illustrative data · scale 1–5 per axis</span>
  </div>
</footer>
</div>

<script>
/* ═══════════════════════════════════════════════════════════════════════
   ENGAGEMENT DATA — THIS IS THE ONLY BLOCK YOU NEED TO EDIT
   Everything below the END marker is presentation logic. Leave it alone.
   ═══════════════════════════════════════════════════════════════════════ */

/* Who this scan is for. Any field left as "" is hidden. */
const ENGAGEMENT = {
  client:  "Client name",
  project: "Engagement or phase name",
  scored:  "Scored 00 Month 2026",
  by:      "Scored by Name, Delivery Manager"
};

/* Two or three sentences: where the exposure concentrates and what it means.
   Written by hand — this is the bit an exec actually reads. */
const EXEC_HEADLINE = "Exposure is concentrated in <where>. <N> of the <total> factors sit in the act-now quadrant; these three carry the highest severity and need a named owner before mobilisation.";

/* The five themes. Rename the labels if your taxonomy differs; keep the keys. */
const THEMES = {
  commercial:{label:"Commercial & Contractual", v:"--c-commercial"},
  technical:{label:"Technical & Solution Complexity", v:"--c-technical"},
  scope:{label:"Scope, Schedule & Dependencies", v:"--c-scope"},
  client:{label:"Client & Stakeholder Environment", v:"--c-client"},
  team:{label:"Team & Delivery Capability", v:"--c-team"}
};

/* One entry per factor.
     i  = impact 1-5      (damage if it lands)
     p  = probability 1-5 (likelihood on THIS engagement)
     why = the definition, shown in the glossary
     so  = recommended action; only needed on the likely top 3, optional elsewhere
   Severity is impact x probability and is calculated for you. */
const RISKS = [
  {id:"C1", name:"Contractual ambiguity", theme:"commercial", i:4.3, p:3.4, why:"Gaps between what was sold, what was signed, and what the client expects to receive.", so:"Reconcile the sold position, the signed contract and the client's expectation in writing in week one."},
  {id:"C2", name:"Commercial model risk", theme:"commercial", i:4.6, p:2.6, why:"Fixed price vs T&M, margin sensitivity, penalty clauses, gain-share mechanics."},
  {id:"C3", name:"Business case volatility", theme:"commercial", i:4.8, p:1.9, why:"The underlying justification shifts mid-flight and renders the current scope obsolete."},
  {id:"C4", name:"ICP fit", theme:"commercial", i:2.6, p:2.2, why:"Whether a new client maps to the ideal client profile and the wider strategy."},
  {id:"T1", name:"Technical complexity", theme:"technical", i:3.9, p:3.7, why:"Platforms, integrations, legacy dependencies."},
  {id:"T2", name:"Integration touchpoints", theme:"technical", i:3.5, p:4.3, why:"Number of systems, APIs or platforms that must talk to each other at go-live.", so:"Map every integration and its owner at mobilisation; each third-party interface is a dependency you do not control."},
  {id:"T3", name:"Data migration & quality", theme:"technical", i:4.1, p:4.5, why:"Volume, cleanliness and mapping complexity of data moving between systems.", so:"Scope a data discovery and a cleanse plan before committing to a go-live date; assume the source data is worse than described."},
  {id:"T4", name:"Testing & environment constraints", theme:"technical", i:2.9, p:4.6, why:"Production environments that cannot be replicated, and reliance on mocked data for critical integrations."},
  {id:"T5", name:"NFR stringency", theme:"technical", i:4.4, p:2.2, why:"Extreme performance, latency, availability or accessibility targets that dictate architecture."},
  {id:"S1", name:"Requirement ambiguity", theme:"scope", i:4.0, p:4.1, why:"How well defined the scope and success criteria actually are.", so:"Fund a discovery or inception phase. Definition debt compounds into rework at exactly the point the timeline has no slack."},
  {id:"S2", name:"Timeline compression", theme:"scope", i:4.5, p:4.0, why:"How tight the deadline is relative to scope — immovable or political dates.", so:"Agree what gets dropped if the date holds. An immovable date with unnegotiated scope is the single most common cause of overrun."},
  {id:"S3", name:"Dependency chain length", theme:"scope", i:3.6, p:3.3, why:"How many third parties, vendors or parallel workstreams must align."},
  {id:"S4", name:"Compliance requirements", theme:"scope", i:4.7, p:1.6, why:"Regulatory, audit and data protection obligations."},
  {id:"K1", name:"Client political complexity", theme:"client", i:4.2, p:3.1, why:"Power dynamics, hidden agendas, sponsor strength, organisational change fatigue."},
  {id:"K2", name:"Stakeholder density", theme:"client", i:2.9, p:4.0, why:"Number of decision-makers, competing interests, approval chains."},
  {id:"K3", name:"Client maturity level", theme:"client", i:2.7, p:3.8, why:"Technical understanding and willingness to take ownership."},
  {id:"K4", name:"Organisational readiness", theme:"client", i:3.25, p:3.05, why:"Capacity to absorb the project alongside everything else they are running."},
  {id:"K5", name:"High change impact", theme:"client", i:4.0, p:2.8, why:"Degree of disruption to BAU processes, people and systems."},
  {id:"D1", name:"Cast team", theme:"team", i:3.3, p:4.4, why:"The start date dictated a team that was available rather than one that matched the need.", so:"Name the capability gaps in the cast team and plan the cover — coaching, a specialist, or a scope trade."},
  {id:"D2", name:"Team distribution", theme:"team", i:2.3, p:3.1, why:"Geographic spread, time zones, onshore/offshore mix, language barriers."},
  {id:"D3", name:"Novelty / first-of-kind", theme:"team", i:4.1, p:2.4, why:"Whether the team or client has done anything like this before."},
];

/* Deliverables from the SOW. Weekly-update tags use these codes; add a url to make a chip a link. */
const DELIVERABLES = {
  A1:{name:"Deliverable name", url:""},
  A2:{name:"Deliverable name"},
  Gov:{name:"Governance, commercial & contract"}
};

/* Weekly update for CreateFuture Operations. Rewrite each week; the "Weekly update" tab renders from it.
   Exactly 3 successes, 3 risks, 3 issues and 1 growth opportunity.
   t = tab line, nine words or fewer, project shorthand allowed.
   p = plain-language line for "Copy as text": no codes, acronyms, names or project jargon.
   d = deliverable codes. trend (risks only) = new | worse | stable | better.
   Status values: Green | Moderate | Critical. Copied text is capped at 200 words. */
const WEEKLY_UPDATE = {
  period: "W/c 00 Month 2026 · Week N of N · Due Fri 00 Month, 2pm",
  about:  "One plain sentence saying what the engagement is, for readers with no context.",
  plainPeriod: "Week of 00 Month 2026 (week N of N)",
  status: [
    {k:"Overall", v:"Moderate"}, {k:"Delivery", v:"Moderate"}, {k:"People", v:"Green"},
    {k:"Client", v:"Green"}, {k:"Budget", v:"Green"}
  ],
  successes: [
    {t:"Success one, nine words or fewer.", p:"Success one in plain language.", d:["A1"]},
    {t:"Success two, nine words or fewer.", p:"Success two in plain language.", d:["A2"]},
    {t:"Success three, nine words or fewer.", p:"Success three in plain language.", d:["Gov"]}
  ],
  risks: [
    {t:"Risk one, nine words or fewer.", p:"Risk one in plain language.", d:["A1"], trend:"new"},
    {t:"Risk two, nine words or fewer.", p:"Risk two in plain language.", d:["A2"], trend:"stable"},
    {t:"Risk three, nine words or fewer.", p:"Risk three in plain language.", d:["Gov"], trend:"worse"}
  ],
  issues: [
    {t:"Issue one; the ask in brief.", p:"Issue one and the ask, in plain language.", d:["A1"]},
    {t:"Issue two; the ask in brief.", p:"Issue two and the ask, in plain language.", d:["A2"]},
    {t:"Issue three; the ask in brief.", p:"Issue three and the ask, in plain language.", d:["Gov"]}
  ],
  growth: [
    {t:"Most relevant growth opportunity on the account.", p:"The opportunity in plain language.", d:["Gov"]}
  ]
};

/* ═══════════════════════ END OF ENGAGEMENT DATA ═══════════════════════ */

const ZONES = {act:{label:"Act now"}, contain:{label:"Contain"}, watch:{label:"Watch"}, monitor:{label:"Monitor"}};
const zoneOf = r => r.i >= 3 ? (r.p >= 3 ? "act" : "contain") : (r.p >= 3 ? "watch" : "monitor");
const sev = r => Math.round(r.i * r.p * 10) / 10;
const colOf = r => `var(${THEMES[r.theme].v})`;
const pct = v => ((v - 1) / 4) * 100;

const meterOf = r => {
  const bars = Math.min(5, Math.max(1, Math.round(sev(r) / 5)));
  return [1,2,3,4,5].map(n => `<i data-on="${n <= bars ? 1 : 0}"></i>`).join("");
};

const active = new Set(Object.keys(THEMES));
let selected = null;

const filters = document.getElementById("filters");
const legend = document.getElementById("legend");
Object.entries(THEMES).forEach(([key, t]) => {
  const b = document.createElement("button");
  b.className = "chip"; b.type = "button"; b.setAttribute("aria-pressed", "true");
  b.style.setProperty("--ch", `var(${t.v})`);
  b.innerHTML = `<span class="dot"></span>${t.label.split(" &")[0].split(",")[0]}`;
  b.dataset.key = key;
  b.addEventListener("click", () => {
    active.has(key) ? active.delete(key) : active.add(key);
    if (!active.size) Object.keys(THEMES).forEach(k => active.add(k));
    syncChips(); render();
  });
  filters.appendChild(b);

  const li = document.createElement("li");
  li.style.setProperty("--ch", `var(${t.v})`);
  const n = RISKS.filter(r => r.theme === key).length;
  li.innerHTML = `<span class="sw"></span><span>${t.label}</span><span class="ct">${n}</span>`;
  legend.appendChild(li);
});
const reset = document.createElement("button");
reset.className = "chip"; reset.type = "button"; reset.textContent = "All themes";
reset.addEventListener("click", () => { Object.keys(THEMES).forEach(k => active.add(k)); syncChips(); render(); });
filters.appendChild(reset);

function syncChips(){
  filters.querySelectorAll(".chip[data-key]").forEach(c =>
    c.setAttribute("aria-pressed", active.has(c.dataset.key) ? "true" : "false"));
}

const field = document.getElementById("field");
const tip = document.getElementById("tip");
const sorted = [...RISKS].sort((a, b) => sev(b) - sev(a));

RISKS.forEach((r, n) => {
  const b = document.createElement("button");
  b.className = "blip"; b.type = "button";
  b.style.setProperty("--bc", colOf(r));
  b.style.left = pct(r.p) + "%";
  b.style.bottom = pct(r.i) + "%";
  b.style.animationDelay = (n * 26) + "ms";
  b.textContent = r.id;
  b.dataset.id = r.id;
  b.setAttribute("aria-label", `${r.name}. Impact ${r.i}, probability ${r.p}.`);
  b.addEventListener("mouseenter", () => showTip(r));
  b.addEventListener("focus", () => { showTip(r); select(r); });
  b.addEventListener("mouseleave", hideTip);
  b.addEventListener("blur", hideTip);
  b.addEventListener("click", () => select(r));
  field.appendChild(b);
});

function showTip(r){
  tip.innerHTML = `<span class="tip-name">${r.name}</span>${r.why}
    <span class="tip-scores">I ${r.i.toFixed(1)} · P ${r.p.toFixed(1)} · Sev ${sev(r).toFixed(1)} · ${ZONES[zoneOf(r)].label}</span>`;
  tip.dataset.show = "true";
  const fw = field.clientWidth, fh = field.clientHeight;
  const x = pct(r.p) / 100 * fw, y = pct(r.i) / 100 * fh;
  tip.style.left = ""; tip.style.right = ""; tip.style.top = ""; tip.style.bottom = "";
  const tw = tip.offsetWidth, th = tip.offsetHeight;
  tip.style.left = Math.min(Math.max(x - tw / 2, 6), fw - tw - 6) + "px";
  const above = y + 30 + th < fh;
  tip.style.bottom = above ? (y + 28) + "px" : "";
  tip.style.top = above ? "" : (fh - y + 28) + "px";
}
function hideTip(){ tip.dataset.show = "false"; }

function select(r){
  selected = r.id;
  const c = colOf(r);
  const d = document.getElementById("detail");
  d.style.setProperty("--dc", c);
  const code = document.getElementById("d-code");
  code.textContent = `${r.id} · ${THEMES[r.theme].label}`;
  code.style.color = c;
  document.getElementById("d-name").textContent = r.name;
  document.getElementById("d-why").textContent = r.why;
  document.getElementById("d-ibar").style.width = (r.i / 5 * 100) + "%";
  document.getElementById("d-pbar").style.width = (r.p / 5 * 100) + "%";
  document.getElementById("d-inum").textContent = r.i.toFixed(1);
  document.getElementById("d-pnum").textContent = r.p.toFixed(1);
  const z = document.getElementById("d-zone");
  z.hidden = false;
  z.textContent = `${ZONES[zoneOf(r)].label} · severity ${sev(r).toFixed(1)}`;
  render();
}

const tbody = document.getElementById("tbody");
sorted.forEach(r => {
  const tr = document.createElement("tr");
  tr.dataset.id = r.id; tr.dataset.theme = r.theme;
  tr.style.setProperty("--rc", colOf(r));
  const z = zoneOf(r);
  tr.innerHTML = `
    <td class="rcode">${r.id}</td>
    <td><span class="rname">${r.name}</span><small class="rwhy">${r.why}</small></td>
    <td class="theme-cell"><span class="sw"></span>${THEMES[r.theme].label.split(" &")[0].split(",")[0]}</td>
    <td class="num">${r.i.toFixed(1)}</td>
    <td class="num">${r.p.toFixed(1)}</td>
    <td class="num score">${sev(r).toFixed(1)}</td>
    <td><span class="zone" data-z="${z}">${ZONES[z].label}</span></td>`;
  tr.addEventListener("click", () => select(r));
  tbody.appendChild(tr);
});

document.querySelectorAll(".pb[data-zone]").forEach(card => {
  const z = card.dataset.zone;
  const all = sorted.filter(r => zoneOf(r) === z);
  const ul = card.querySelector(".pb-list");
  const h = card.querySelector("h4");
  h.insertAdjacentHTML("beforeend", `<span class="cnt">${all.length}</span>`);
  all.forEach(r => {
    const li = document.createElement("li");
    li.style.setProperty("--pl", colOf(r));
    li.innerHTML = `<span class="pid" style="color:${colOf(r)}">${r.id}</span>
      <span class="pname">${r.name}</span>
      <span class="psev" title="Severity ${sev(r).toFixed(1)} of 25">${meterOf(r)}</span>`;
    ul.appendChild(li);
  });
});

if (document.getElementById("foot-count"))
  document.getElementById("foot-count").textContent = `${RISKS.length} factors · ${Object.keys(THEMES).length} themes`;
document.getElementById("meta-count").textContent =
  `${RISKS.length} factors · ${Object.keys(THEMES).length} themes`;
document.getElementById("kpi-act").textContent = RISKS.filter(r => zoneOf(r) === "act").length;
document.getElementById("kpi-mean").textContent =
  (RISKS.reduce((s, r) => s + r.i * r.p, 0) / RISKS.length).toFixed(1);

function render(){
  document.querySelectorAll(".blip").forEach(b => {
    const r = RISKS.find(x => x.id === b.dataset.id);
    b.dataset.muted = active.has(r.theme) ? "false" : "true";
    b.dataset.selected = (selected === r.id) ? "true" : "false";
  });
  tbody.querySelectorAll("tr").forEach(tr => {
    tr.dataset.muted = active.has(tr.dataset.theme) ? "false" : "true";
    tr.dataset.selected = (selected === tr.dataset.id) ? "true" : "false";
  });
}
render();

/* ---- engagement header + exec headline ---- */
document.getElementById("kicker").innerHTML =
  [ENGAGEMENT.client, ENGAGEMENT.project, ENGAGEMENT.scored, ENGAGEMENT.by]
    .filter(Boolean).map((v, n) => n === 0 ? `<b>${v}</b>` : `<span>${v}</span>`).join("");
document.getElementById("exec-line").textContent = EXEC_HEADLINE;

/* ---- exec summary: top 3 by severity ---- */
const execTop = document.getElementById("exec-top");
sorted.slice(0, 3).forEach((r, n) => {
  const d = document.createElement("div");
  d.className = "ex";
  d.style.setProperty("--ec", colOf(r));
  const meter = meterOf(r);
  d.innerHTML = `<span class="ex-sev"><span class="ex-meter">${meter}</span><span class="cap">Severity</span></span>
    <span class="ex-rank">0${n + 1}</span>
    <div class="ex-name"><span class="eid">${r.id}</span>${r.name}</div>
    <div class="ex-theme">${THEMES[r.theme].label}</div>
    <p class="ex-so">${r.so || r.why}</p>
    <div class="ex-scores">Impact ${r.i.toFixed(1)} · Probability ${r.p.toFixed(1)} · ${ZONES[zoneOf(r)].label}</div>`;
  execTop.appendChild(d);
});

/* ---- glossary ---- */
const gl = document.getElementById("glossary");
Object.entries(THEMES).forEach(([key, t]) => {
  const items = RISKS.filter(r => r.theme === key).sort((a, b) => sev(b) - sev(a));
  const g = document.createElement("div");
  g.className = "gl-group";
  g.style.setProperty("--gc", `var(${t.v})`);
  g.innerHTML = `<div class="gl-head"><h3>${t.label}</h3><span class="ct">${items.length} factors</span></div>
    <div class="gl-items">${items.map(r => `
      <div class="gl-item">
        <span class="gid">${r.id}</span>
        <div>
          <div class="gname">${r.name}</div>
          <p class="gwhy">${r.why}</p>
          <div class="gsco">Impact ${r.i.toFixed(1)} · Probability ${r.p.toFixed(1)} · Severity ${sev(r).toFixed(1)} · ${ZONES[zoneOf(r)].label}</div>
        </div>
      </div>`).join("")}</div>`;
  gl.appendChild(g);
});

/* ---- tabs ---- */
const tabs = [...document.querySelectorAll(".tab")];
tabs.forEach(t => t.addEventListener("click", () => {
  tabs.forEach(o => {
    const on = o === t;
    o.setAttribute("aria-selected", on ? "true" : "false");
    document.getElementById(o.getAttribute("aria-controls")).hidden = !on;
  });
  window.scrollTo({ top: 0, behavior: "smooth" });
}));

/* ---- weekly update ---- */
if (typeof WEEKLY_UPDATE !== "undefined") {
  const W = WEEKLY_UPDATE;
  const esc = s => String(s).replace(/[&<>"]/g, c => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
  const TREND = {new:"New", worse:"Worse", stable:"Same", better:"Better"};
  document.getElementById("wu-meta").textContent = W.period;
  document.getElementById("wu-status").innerHTML = W.status.map(s =>
    `<span class="wu-pill" data-s="${esc(s.v)}"><i></i>${esc(s.k)} <b>${esc(s.v)}</b></span>`).join("");
  const chip = c => {
    const d = DELIVERABLES[c] || {name:c};
    return d.url
      ? `<a class="wu-d" href="${esc(d.url)}" target="_blank" rel="noopener" title="${esc(d.name)}">${esc(c)}</a>`
      : `<span class="wu-d" title="${esc(d.name)}">${esc(c)}</span>`;
  };
  const block = (title, color, items) => `<div class="wu-card" style="--wc:${color}">
      <h3>${title}</h3><ul class="wu-list">${items.map(x => `<li><span class="wu-t">${esc(x.t)}</span>
      <span class="wu-tags">${x.trend ? `<span class="wu-trend" data-t="${x.trend}">${TREND[x.trend]}</span>` : ""}${(x.d||[]).map(chip).join("")}</span></li>`).join("")}</ul></div>`;
  document.getElementById("wu-grid").innerHTML =
    block("Top 3 successes", "var(--c-technical)", W.successes) +
    block("Top 3 key risks", "var(--c-scope)", W.risks) +
    block("Top 3 issues", "var(--c-team)", W.issues) +
    block("Top growth opportunity", "var(--c-client)", W.growth);
  document.getElementById("wu-key").innerHTML = Object.entries(DELIVERABLES)
    .map(([c, d]) => `${chip(c)} ${esc(d.name)}`).join('<span class="sep">·</span>');

  const MAX_WORDS = 200;
  const countWords = s => s.split(/\s+/).filter(Boolean).length;
  /* Plain-language text for readers with no project context: uses each item's p (falls back to t),
     no deliverable codes, acronyms or names. */
  const TREND_TXT = {new:"new this week", worse:"worsening", stable:"unchanged", better:"improving"};
  const build = withTrend => {
    const L = [`${ENGAGEMENT.client}: weekly update, ${W.plainPeriod || W.period}`];
    if (W.about) L.push(W.about);
    L.push("Status: " + W.status.map(s => `${s.k.toLowerCase()} ${s.v.toLowerCase()}`).join(", ") + ".", "");
    const sec = (h, a) => { L.push(h); a.forEach(x => L.push(`• ${x.p || x.t}` + (withTrend && x.trend ? ` (${TREND_TXT[x.trend]})` : ""))); L.push(""); };
    sec("Top 3 successes", W.successes); sec("Top 3 risks", W.risks); sec("Top 3 issues", W.issues); sec("Top growth opportunity", W.growth);
    return L.join("\n").trim();
  };
  /* Never more than MAX_WORDS: drop the trend labels first, then cut at the word limit. */
  const asText = () => {
    let t = build(true);
    if (countWords(t) > MAX_WORDS) t = build(false);
    if (countWords(t) > MAX_WORDS) {
      let n = 0;
      t = t.replace(/\S+/g, w => (++n <= MAX_WORDS ? w : "")).replace(/[ \t]+$/gm, "").trim() + "…";
    }
    return t;
  };
  const wc = document.getElementById("wu-wc");
  if (wc) wc.textContent = `${countWords(asText())} / ${MAX_WORDS} words`;
  const btn = document.getElementById("wu-copy");
  btn.addEventListener("click", async () => {
    const t = asText();
    try { await navigator.clipboard.writeText(t); }
    catch(e) { const ta = document.createElement("textarea"); ta.value = t; document.body.appendChild(ta); ta.select(); document.execCommand("copy"); ta.remove(); }
    btn.textContent = "Copied"; setTimeout(() => btn.textContent = "Copy as text", 1600);
  });
}
</script>
</body>
</html>
````