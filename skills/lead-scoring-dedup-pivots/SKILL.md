---
name: lead-scoring-dedup-pivots
description: Score raw search results, remove duplicate leads, decide what to keep or discard, and generate pivot plans from posts, profiles, companies, recruiters, and contact routes.
metadata:
  display-name: Lead Scoring, Deduplication, and Pivots
  enabled: "true"
  version: "1.0"
---

# Skill: Lead Scoring, Deduplication, and Pivots

## Trigger

Use this skill after a search returns candidate posts, profiles, companies, recruiters, or contact routes that need triage.

## Purpose

Convert raw search results into an action-ready shortlist by scoring signal quality, removing duplicates, and pivoting from strong evidence into adjacent sources.

## Inputs

- `CANDIDATES`: raw posts, profiles, companies, or search-result snippets.
- `TARGET_ROLE`: role or persona being searched.
- `GEO_SCOPE`: target country/city/region.
- `CONTACT_PRIORITY`: email, CTA, mutual connection, profile URL, or company page.
- `MIN_SIGNAL_SCORE`: default `7`.

## Outputs

- Scored shortlist.
- Duplicate groups.
- Discard list with reason.
- Pivot plan for next searches.

## Scoring model for hiring posts

Score from 0 to 10:

- Recency: 24h = 2, week = 1, older/unclear = 0.
- Role match: explicit fit = 2, adjacent = 1, unclear = 0.
- Geography match: target city/country evidence = 2, broad regional hint = 1, absent = 0.
- Contact clarity: direct email = 3, clear apply CTA = 2, vague CTA = 1, absent = 0.
- Poster credibility: recruiter, hiring manager, or company page = 1.

Action thresholds:

- `8-10`: immediate priority.
- `7`: keep and review.
- `<=6`: discard unless niche-critical.

## Scoring model for people/profile leads

Score from 0 to 10:

- Role/title match: exact = 3, adjacent = 2, unclear = 0.
- Geography/company fit: strong = 2, partial = 1.
- Outreach warmth: second-degree/mutual-rich = 2, no warmth = 0.
- Domain/seniority fit: strong = 2, partial = 1.
- Profile confidence: current and credible profile = 1.

## Deduplication rules

For posts, treat entries as duplicates if any two match:

- Same email.
- Same role phrase.
- Same company or poster.
- Same CTA wording within 7 days.

For profiles, treat entries as duplicates if any two match:

- Same profile URL.
- Same name + current company.
- Same name + title + location.

Keep the record with the highest recency, clearest contact route, and most complete notes.

## Pivot strategy

After two or more high-signal records:

1. Pivot from posts to People to find repeat high-signal recruiters or hiring managers.
2. Pivot from posts to Companies using broad terms first.
3. Pivot from People back to Posts using recruiter names, company names, and hiring terms.
4. Pivot from Companies to People only after a broad company pattern is found.

Do not over-constrain pivots with exact company + strict contact phrase before proving volume exists.

## Noise handling

Discard or down-rank:

- Internship, course, bootcamp, freelance, or training posts when not requested.
- Old posts that appear through Google but lack fresh date evidence.
- Vague "we are growing" posts without role, geography, or CTA.
- Recruiter-marketing content without a concrete job signal.

## Processing loop

1. Scan up to the configured max results per query.
2. Score each candidate.
3. Mark duplicates.
4. Keep only score `>= MIN_SIGNAL_SCORE`.
5. Sort by score, recency, contact clarity, and credibility.
6. Generate pivots from the strongest two or more records.
7. Record what worked and what failed for the next run.

## Output schemas

### Post lead

```text
Post URL:
Posted time:
Role:
Company or poster:
Geo evidence:
Contact email or CTA:
Score:
Duplicate group:
Decision:
Notes:
```

### Profile lead

```text
Profile URL:
Name:
Current title:
Company:
Location:
Connection degree:
Mutual/context signal:
Score:
Duplicate group:
Decision:
Notes:
```

### Pivot plan

```text
Pivot source:
Why it is high-signal:
Next vertical: People / Posts / Companies / Google
Next query:
Expected evidence:
Stop condition:
```
