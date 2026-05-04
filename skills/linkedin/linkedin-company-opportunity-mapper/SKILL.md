---
name: linkedin-company-opportunity-mapper
description: >-
  Analyze LinkedIn company pages for opportunity intelligence: jobs, posts,
  people, hiring signals, Saudi/location fit, best contacts, outreach angles,
  and pivots into recruiters, hiring managers, posts, and the Outreach sheet.
metadata:
  display-name: LinkedIn Company Opportunity Mapper
  enabled: 'true'
  version: '1.1'
---

# LinkedIn Company Opportunity Mapper

## Trigger

Use this skill when BrowserOS needs to investigate a LinkedIn company page as an opportunity source, especially before applying, reaching out, mapping a target account, or deciding whether a company is worth pursuing.

Use it when the user says things like:
- "analyze this company"
- "map this LinkedIn company page"
- "find who to contact at this company"
- "check this company for opportunities"
- "see if this company is hiring"
- "build a company intelligence brief"

## Purpose

Turn a LinkedIn company page into an action-ready opportunity map by checking the company's visible LinkedIn surfaces:

1. About and positioning
2. Jobs and hiring activity
3. Recent posts and hiring/content signals
4. People tab and relevant employees
5. Recruiters, founders, managers, and department leads
6. Saudi/KSA or target-location relevance
7. Outreach hooks and next actions

This skill is designed for free LinkedIn usage. Do not depend on Premium-only features.

## Inputs

- `COMPANY_URL`: LinkedIn company page URL, required if available.
- `COMPANY_NAME`: company name, required if URL is unknown.
- `TARGET_ROLE`: user's target role family, e.g. AI Engineer, Data Analyst, Product, Software Engineer.
- `GEO_SCOPE`: target geography, default Saudi Arabia/KSA if user context suggests it.
- `CANDIDATE_PROFILE`: optional redacted resume, LinkedIn summary, or experience notes.
- `MODE`: `quick-scan`, `target-account`, `pre-application`, `outreach-map`, or `deep-brief`.
- `OUTREACH_TRACKING`: optional; if true, add strong contacts/leads to the Outreach sheet using the Google Sheets connector workflow.

## Outputs

Produce a compact company opportunity brief with:

- Company page URL
- Company summary from LinkedIn-visible evidence
- Opportunity verdict: High / Medium / Low / Ignore for now
- Hiring evidence
- Relevant jobs or role clusters
- Key posts and signals
- Best people to contact
- Suggested outreach angles
- Recommended next actions
- Pivots into People, Posts, Jobs, company website, or Outreach sheet rows
- Reliability notes: login walls, hidden content, stale filters, incomplete visibility

## Core operating rules

1. Stay LinkedIn-first: Company page -> Jobs -> Posts -> People.
2. Do not start with Google unless LinkedIn visibility is blocked or too sparse.
3. Use company-page evidence, not assumptions.
4. Treat company marketing text as weak evidence unless backed by jobs, posts, employees, or concrete initiatives.
5. Prefer contacts with current company/title evidence.
6. Do not message or connect without explicit user instruction or an existing outreach workflow request.
7. Record uncertainty clearly when LinkedIn hides data or the page has limited visible content.

## Privacy rules

- Treat profile URLs, names, personal contact routes, and candidate profile details as sensitive.
- Prefer row IDs, role labels, or redacted labels in chat summaries unless the user asks for exact identifiers.
- Keep public company and corporate application routes when needed, but do not expose personal phone/email details in logs by default.

## Required companion skills

Use these when relevant:

- `search-state-verification-hygiene` before repeated LinkedIn filtering.
- `linkedin-people-url-filtering` for People tab or target-company people searches.
- `linkedin-boolean-query-refinement` when post or people search terms are noisy.
- `lead-scoring-dedup-pivots` after collecting candidate people/posts.
- `linkedin-outreach-sheet-workflow` when updating the Outreach sheet.
- `google-sheets-connector-reliability` for connector-first sheet updates.

## Workflow

### 1. Establish clean company identity

If `COMPANY_URL` is available:
- Open the company page directly.
- Verify the visible company name matches the intended company.
- Capture the canonical LinkedIn URL.

If only `COMPANY_NAME` is available:
- Search LinkedIn for the company.
- Prefer exact company-page result over people, posts, or jobs.
- If multiple companies share the name, disambiguate using industry, location, website, logo, or follower count.

Capture:

```text
Company name:
LinkedIn URL:
Industry/category:
Follower count if visible:
Company size if visible:
Headquarters/location if visible:
Website if visible:
Verification notes:
```

### 2. About-page scan

Open or inspect the About section.

Extract only visible evidence:

- What the company does
- Industry/domain
- Headquarters and operating locations
- Company size
- Website/careers link
- Specialties/keywords
- Saudi/KSA relevance if visible
- Product or service areas that map to the user's target role

Do not overvalue generic terms like "innovation", "digital transformation", or "AI-powered" unless supported by jobs/posts.

### 3. Jobs scan

Open LinkedIn Jobs for the company if visible.

Collect relevant jobs:

```text
Job title:
Location:
Work mode if visible:
Posted time if visible:
Applicants if visible:
Job URL:
Fit notes:
```

Score each job from 0 to 10:

- Role fit: exact = 3, adjacent = 2, weak = 1
- Geography fit: target city/country = 2, remote/hybrid plausible = 1
- Seniority fit: student/fresh/junior aligned = 2, stretch = 1, too senior = 0
- Evidence richness: clear requirements/team = 1
- Recency: fresh = 1
- Application route clarity = 1

Decision:
- `8-10`: prioritize application + contact mapping
- `6-7`: keep as possible/stretch
- `<=5`: ignore unless strategically important

If no jobs are visible:
- Check posts for hiring signals.
- Pivot to People for recruiters/talent acquisition.
- Capture "no visible LinkedIn jobs" as a reliability note, not proof that no jobs exist.

### 4. Posts scan

Open recent company posts.

Scan for opportunity signals:

- "we are hiring" / "join our team"
- project launches
- funding/growth/expansion
- office openings or Saudi expansion
- new partnerships
- AI/data/product/engineering initiatives
- event participation
- employee spotlights
- reposts from recruiters or hiring managers

For each useful post:

```text
Post URL:
Posted time:
Signal type: hiring / growth / project / event / partnership / team spotlight
Relevant role/function:
Evidence quote or paraphrase:
People mentioned/tagged:
Potential outreach hook:
Score:
```

Post signal score from 0 to 10:

- Recency: this week/month = 2, older but relevant = 1
- Opportunity relevance: direct hiring = 3, role-adjacent project = 2, generic brand content = 0
- Role/domain match = 2
- Geography match = 1
- Contact/person tagged = 1
- Actionable hook = 1

Prioritize direct hiring posts, tagged managers, and project posts that reveal a relevant team.

### 5. People and contact mapping

Use the company People tab or LinkedIn People URL search.

Search for contacts in this order:

1. Recruiters / Talent Acquisition / HR
2. Hiring managers for target function
3. Department heads or team leads
4. Founders or executives, only for startups/small companies
5. Employees in the target team/location
6. Alumni, mutuals, or second-degree connections

Useful title blocks:

```text
Recruiting block:
recruiter OR "talent acquisition" OR hiring OR "people operations" OR HR

AI/data block:
"machine learning" OR "AI engineer" OR "data scientist" OR "data analyst" OR "analytics" OR "computer vision"

Software/product block:
"software engineer" OR backend OR frontend OR platform OR product OR "product manager"

Leadership block:
head OR lead OR manager OR director OR founder OR CTO OR VP
```

For each contact:

```text
Profile URL:
Name:
Current title:
Company:
Location:
Connection degree:
Why relevant:
Outreach warmth:
Recommended action:
```

Contact score from 0 to 10:

- Current company evidence = 2
- Role relevance = 3
- Decision/contact likelihood = 2
- Location or market relevance = 1
- Warmth: second-degree/mutual/alumni/shared context = 1
- Profile clarity = 1

Decision:
- `8-10`: priority outreach/contact
- `6-7`: keep as secondary
- `<=5`: discard unless niche-critical

### 6. Opportunity verdict

Assign one verdict:

- `High`: active relevant jobs or strong hiring posts + identifiable contacts.
- `Medium`: relevant company and contacts, but weak/no live hiring evidence.
- `Low`: possible domain fit, but no jobs/posts/contacts strong enough.
- `Ignore for now`: irrelevant domain, wrong geography, too senior, stale/inactive page, or no useful route.

Use evidence-first reasoning. Avoid optimistic inflation.

## Outreach angle generation

Generate 1 to 3 short outreach hooks based on observed evidence.

Good hooks:
- A specific job posting
- A recent project/launch/post
- A Saudi expansion or location signal
- A team/function match
- A mutual connection or alumni signal
- A recruiter publicly associated with the role/function

Avoid:
- Generic "I admire your company"
- Overclaiming knowledge of internal hiring
- Mentioning hidden assumptions
- Long messages before the user asks to send outreach

Example hook format:

```text
Hook: Saw your recent post/job about <specific evidence>. My background in <grounded candidate evidence> maps to <role/team>. Worth contacting <person> or applying to <job>.
```

## Outreach sheet integration

If the user asks to track leads or the workflow requires tracking:

1. Use `linkedin-outreach-sheet-workflow`.
2. Use `google-sheets-connector-reliability`.
3. Add only action-ready people or company leads.
4. Do not create duplicate rows if a profile URL or company already exists.

Minimum row fields:

```text
Name / Company:
LinkedIn URL:
Type: company / recruiter / hiring manager / employee
Company:
Title:
Source: LinkedIn company opportunity mapper
Signal:
Next action:
Status:
Notes:
```

## Output schema

```text
# LinkedIn Company Opportunity Brief

Company:
LinkedIn URL:
Mode:
Target role:
Geo scope:
Verdict: High / Medium / Low / Ignore for now

## What the company appears to do
- Evidence:

## Hiring evidence
| Role/Post | Location | Evidence | URL | Fit | Score | Decision |

## Relevant posts/signals
| Signal | Date | Evidence | People tagged | Hook | URL | Score |

## Best contacts
| Name | Title | Location | Why relevant | URL | Score | Recommended action |

## Outreach angles
1.
2.
3.

## Recommended next actions
- Apply:
- Connect/message:
- Comment/engage:
- Pivot search:
- Track in Outreach sheet:

## Reliability notes
-
```

## Stop conditions

Stop and report when:

- LinkedIn requires login, CAPTCHA, or manual verification.
- Company identity cannot be confidently disambiguated.
- The page has no visible posts/jobs/people and no useful pivots.
- After 3 to 4 attempts, LinkedIn search/filter state is stale or inconsistent.

## Anti-patterns

- Treating follower count as opportunity quality.
- Contacting only recruiters when the hiring manager/team lead is visible.
- Assuming "AI" marketing means AI roles exist.
- Using Google before checking LinkedIn-native tabs.
- Adding every employee to the Outreach sheet instead of only action-ready contacts.
- Losing the company URL or profile URL evidence.
