# LinkedIn Company Opportunity Details

Load this reference for real company mapping, scoring, Outreach sheet updates,
or deep-brief output.

Sections: evidence capture, scoring, people search blocks, verdicts, outreach
hooks, Outreach sheet fields, output schema, and anti-patterns.

## Evidence To Capture

Company identity:

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

Jobs:

```text
Job title:
Location:
Work mode if visible:
Posted time if visible:
Applicants if visible:
Job URL:
Fit notes:
```

LinkedIn company pages may show only a jobs carousel, a total opening count, or
`Click to See all jobs at <Company>` rather than the full list. If the carousel
is sparse, open the company jobs/search link and extract the full visible list
from that page before concluding job coverage is weak.

Posts:

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

People:

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

## Scoring

Job score, 0-10:

- role fit: exact = 3, adjacent = 2, weak = 1
- geography fit: target city/country = 2, remote/hybrid plausible = 1
- seniority fit: student/fresh/junior aligned = 2, stretch = 1, too senior = 0
- evidence richness: clear requirements/team = 1
- recency: fresh = 1
- application route clarity = 1

Decision: `8-10` prioritize application/contact mapping, `6-7` possible/stretch,
`<=5` ignore unless strategically important.

Post signal score, 0-10:

- recency: this week/month = 2, older but relevant = 1
- opportunity relevance: direct hiring = 3, role-adjacent project = 2
- role/domain match = 2
- geography match = 1
- contact/person tagged = 1
- actionable hook = 1

Contact score, 0-10:

- current company evidence = 2
- role relevance = 3
- decision/contact likelihood = 2
- location or market relevance = 1
- warmth: second-degree/mutual/alumni/shared context = 1
- profile clarity = 1

Decision: `8-10` priority outreach/contact, `6-7` secondary, `<=5` discard unless
niche-critical.

## People Search Blocks

Search contacts in this order:

1. Recruiters / Talent Acquisition / HR
2. Hiring managers for target function
3. Department heads or team leads
4. Founders or executives for startups/small companies
5. Employees in the target team/location
6. Alumni, mutuals, or second-degree connections

Useful query blocks:

```text
recruiter OR "talent acquisition" OR hiring OR "people operations" OR HR
"machine learning" OR "AI engineer" OR "data scientist" OR "data analyst" OR "analytics" OR "computer vision"
"software engineer" OR backend OR frontend OR platform OR product OR "product manager"
head OR lead OR manager OR director OR founder OR CTO OR VP
```

## Verdicts

- `High`: active relevant jobs or strong hiring posts plus identifiable contacts.
- `Medium`: relevant company and contacts, but weak/no live hiring evidence.
- `Low`: possible domain fit, but no strong jobs/posts/contacts.
- `Ignore for now`: irrelevant domain, wrong geography, too senior,
  stale/inactive page, or no useful route.

Avoid optimistic inflation; verdicts must cite evidence.

## Outreach Hooks

Generate one to three short hooks from visible evidence:

- specific job posting
- recent project/launch/post
- Saudi expansion or location signal
- team/function match
- mutual connection or alumni signal
- recruiter associated with the role/function

Avoid generic admiration, hidden assumptions, or long messages before the user
asks to send outreach.

Hook format:

```text
Hook: Saw your recent post/job about <specific evidence>. My background in <grounded candidate evidence> maps to <role/team>. Worth contacting <person> or applying to <job>.
```

## Outreach Sheet

If tracking is requested:

1. Use `linkedin-outreach-sheet-workflow`.
2. Use `google-sheets-connector-reliability`.
3. Add only action-ready people or company leads.
4. Deduplicate by profile URL or company.

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

## Output Schema

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

## Anti-Patterns

- Treating follower count as opportunity quality.
- Contacting only recruiters when hiring manager/team lead is visible.
- Assuming "AI" marketing means AI roles exist.
- Using Google before LinkedIn-native tabs unless LinkedIn is blocked or sparse.
- Adding every employee to Outreach instead of action-ready contacts.
- Losing company URL or profile URL evidence.
