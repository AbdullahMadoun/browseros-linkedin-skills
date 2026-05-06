---
name: linkedin-ksa-recent-hiring-posts
description: >-
  Find recent Saudi Arabia LinkedIn hiring posts with a LinkedIn-first search
  ladder, bilingual query packs, candidate-to-role mapping, recruiter/company
  pivots, disciplined state verification, and Google X-ray only after
  LinkedIn-native recovery is exhausted.
metadata:
  display-name: LinkedIn KSA Recent Hiring Posts
  enabled: "true"
  version: "1.3"
---

# LinkedIn KSA Recent Hiring Posts

## Purpose

Find fresh KSA hiring posts and contact/application routes from LinkedIn Posts first. This skill is for post-led opportunity discovery, not LinkedIn Jobs scraping.

Default source order:

1. LinkedIn Posts
2. LinkedIn People pivots for recruiters/hiring managers
3. LinkedIn Company/JOBS validation pivots
4. Google X-ray over LinkedIn URLs only after LinkedIn-native recovery fails

Google recency is never enough by itself. If Google X-ray is used, count a result
as recent only after the LinkedIn post itself shows acceptable date evidence.

Use `QUERY_PACK_TEMPLATE.md` for concrete query ladders, Arabic/English mirrors, and Google X-ray fallback strings. Use `templates/run_log_template.md` and `templates/results_template.csv` for substantial runs.

## Trigger

Use when the user wants recent Saudi/KSA LinkedIn hiring posts, especially posts with visible contact routes, recruiter signals, company hiring activity, or fresh role-specific openings.

Do not use this for:

- normal LinkedIn Jobs applications
- broad web research outside LinkedIn
- company-only mapping without a post search; use `linkedin-company-opportunity-mapper`
- comment-only analysis on one post; use `linkedin-hiring-post-comment-miner`

## Required Setup

- Use `search-state-verification-hygiene` before repeated filtering.
- Start from a clean LinkedIn Posts URL or verified reset state.
- Confirm the active vertical is Posts, not All.
- Change one variable per pass: role, city, date, language, contact token, or poster type.
- Treat old filters and stale chips as corrupt until verified.

## Fast Path

1. Build a query from role + hiring intent + KSA/city.
2. Open the direct Posts URL with `datePosted` instead of using the global search UI.
3. Extract visible cards with page content before clicking.
4. Open only shortlisted candidates to verify timestamp, contact route, and fit.
5. Stop once enough high-signal non-duplicates are found.

## Candidate-To-Role Mapping

If a CV/profile is supplied, derive 3-5 role clusters before searching; do not search one literal title only.

Common clusters:

- Applied AI/ML
- Computer Vision
- Data Science/Analytics
- Software Engineering with AI/Data bias

Search the top 2-3 clusters first. For students/recent graduates, bias toward `intern`, `trainee`, `fresh graduate`, `graduate program`, `junior`, and `entry level`.

Before logging profile-derived data, remove names, contact details, schools, employers, profile URLs, and identifiers unless the user explicitly asks otherwise.

## Query Strategy

Build queries from blocks:

- hiring intent: `we are hiring`, `hiring`, `looking for`, `join our team`, `توظيف`, `مطلوب`, `فرصة وظيفية`
- role family: exact role plus 2-4 adjacent titles
- geography: Saudi Arabia, KSA, Riyadh, Jeddah, Dammam, Khobar, and Arabic mirrors
- contact/poster: `send your CV`, `email`, `hr@`, `careers@`, `talent@`, recruiter, talent acquisition, hiring manager

Start with 2 blocks, move to 3 after proving volume, and use 4 only for precision. Try Arabic mirrors every serious run.

## Recovery Ladder

If results are weak, recover inside LinkedIn before Google:

1. remove strict contact tokens
2. keep hiring intent + role + geography
3. expand role variants
4. expand city to Saudi-level geography
5. widen 24h to week
6. switch English/Arabic mirror query
7. pivot to People for recruiters/hiring managers
8. inspect company pages/posts
9. use LinkedIn Jobs only to discover active employers
10. return to Posts with discovered company/poster terms
11. use Google X-ray only as last resort

If the search page shows `No results found`, do not spend clicks in the edit
search UI first. Reopen a broader direct Posts URL with one removed constraint,
then reassess visible cards.

## Result Validation

Count a post only when there is evidence for most of:

- visible recency
- hiring intent
- target or adjacent role signal
- Saudi/city evidence
- contact route or apply path
- credible poster: recruiter, hiring manager, founder, company page, or team member
- non-duplicate status

Reject employer branding, stale reposts, generic job-board spam, courses, bootcamps, visa posts, and motivational content unless explicitly requested.

For recent-hiring runs, visible LinkedIn-side recency is mandatory for kept
results. Do not rely on Google result order, Google snippets, or Google date
filters as proof that the LinkedIn post is fresh.

LinkedIn search result pages may show active `Past week` filters while hiding
exact dates on individual cards. In that case, open the candidate post or job
detail and verify its visible timestamp before counting it.

## Signal Score

Score 0-10:

- recency: 24h = 2, week = 1
- role match: exact = 2, adjacent = 1
- KSA/city evidence = up to 2
- contact clarity: corporate email/apply route = 3, personal phone/WhatsApp/personal email = 2, vague CTA = 1
- poster credibility = 1

Action thresholds:

- 8-10: immediate priority
- 7: keep and review
- <=6: discard unless niche-critical

Summarize personal phone, WhatsApp, or personal email as route type unless the user explicitly asks to preserve raw contact details.

## Stop And Pivot

Stop a branch when:

- 3 consecutive query mutations are neutral/worse
- filter state cannot be verified after one retry
- results drift out of Posts relevance
- enough high-signal leads have been collected

Pivot instead of brute-forcing more keywords.

## Output

For each kept post:

```text
Post URL:
Posted time:
Role:
Company/poster:
KSA evidence:
Contact route type:
Language:
Signal score:
Candidate-fit cluster:
Duplicate group:
Next pivot:
Notes:
```

End with winning query, best signal pattern, noise observed, discarded duplicate count, and next recommended query/pivot.
