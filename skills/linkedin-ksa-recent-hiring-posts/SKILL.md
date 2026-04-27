---
name: linkedin-ksa-recent-hiring-posts
description: Find recent Saudi Arabia LinkedIn hiring posts with direct contact routes using two-lane English/Arabic search, freshness filters, scoring, deduplication, and Google X-ray fallback.
metadata:
  display-name: LinkedIn KSA Recent Hiring Posts
  enabled: "true"
  version: "1.0"
---

# Skill: LinkedIn KSA Recent Hiring Posts

## Trigger

Use this skill when BrowserOS needs to find recent LinkedIn hiring posts in Saudi Arabia with a direct contact route, preferably email.

## Purpose

Find fresh KSA hiring signals by searching LinkedIn posts first, using a two-lane query strategy, scoring direct-contact evidence, expanding carefully when results are sparse, and falling back to Google X-ray only when useful.

## Metadata

- Region: Saudi Arabia.
- Primary source: LinkedIn Posts search.
- Fallback source: Google X-ray over LinkedIn posts and feed updates.
- Priority signal: direct email in post text; clear apply CTA is second-best.
- Freshness priority: past 24 hours, then past week.
- Language support: English and Arabic.

## Inputs

- `ROLE_KEYWORDS`: required target role terms.
- `INDUSTRY_KEYWORDS`: optional industry terms.
- `GEO_SCOPE`: Saudi Arabia, Riyadh, Jeddah, Dammam, Khobar, or another KSA city.
- `FRESHNESS_SEQUENCE`: default `past-24h`, then `past-week`.
- `MIN_SIGNAL_SCORE`: default `7`.

## Execution model: two-lane search

### Lane A: yield lane

Run broad, high-hit-rate queries first to discover active hiring streams.

1. `"we are hiring" "Saudi Arabia" "send your CV"`
2. `hiring Riyadh hr@`
3. `"وظائف السعودية" hr@`

### Lane B: precision lane

Run role-targeted queries after Lane A proves there is market signal.

4. `"[ROLE]" hiring "Saudi Arabia"`
5. `"[ROLE]" "send your CV" Riyadh`
6. `("hiring" OR "looking for") "[ROLE]" [INDUSTRY] ("Saudi Arabia" OR KSA)`

### Arabic precision variants

7. `توظيف [ROLE] السعودية`
8. `"[ROLE]" الرياض السيرة`

## LinkedIn filter strategy

Apply in this order:

1. Switch to `Posts`.
2. Set `Date posted` to `Past 24 hours`.
3. Add location at country level first.
4. Narrow to city only if volume is high.
5. Expand to `Past week` only if 24h is sparse.

Prefer country-level first. City-level too early can hide relevant posts.

## Repeatable LinkedIn content URL

```text
https://www.linkedin.com/search/results/content/?keywords=<ENCODED_QUERY>&origin=GLOBAL_SEARCH_HEADER&datePosted=%22past-24h%22
```

Switch `datePosted` to:

```text
%22past-week%22
```

when the 24h run is sparse.

## Adaptive logic

If results are weak or zero:

1. Remove strict email tokens first: `hr@`, `careers@`, `@gmail.com`.
2. Keep role + hiring + geography intact.
3. Widen freshness from 24h to week.
4. Switch between English and Arabic mirror queries.
5. Use Google X-ray fallback.

If results are noisy:

1. Add quoted role phrase.
2. Add city token such as Riyadh.
3. Add Google negative terms: `-internship -course -bootcamp -freelance`.

## Google X-ray fallback

Use Google only when LinkedIn ranking quality drops or the in-app UI behaves inconsistently.

Recommended:

```text
site:linkedin.com/posts ("hiring" OR "we are hiring") ("Saudi Arabia" OR Riyadh) ("send your CV" OR email)
```

Optional:

```text
site:linkedin.com/feed/update "hiring" "Saudi Arabia" "send your CV"
```

Google recency controls:

- Week: append `&tbs=qdr:w`.
- Month: append `&tbs=qdr:m`.

## Live-tested lessons

- Broad hiring + KSA + CV/contact phrasing produced fresh posts and visible contact routes.
- Strict role + exact email token combinations can return zero results.
- Arabic KSA hiring patterns produced strong direct-email signals.
- `hiring Riyadh hr@` was high-signal for city-aligned recruiter emails.
- Strict Google X-ray role+email queries were weak and often stale.
- Broad Google X-ray hiring+geo+CV/email patterns are useful as fallback.
- People pivots are useful for discovering repeat high-signal posters.
- Company pivots work best broad; avoid combining exact company + strict contact phrase too early.

## High-signal scoring

Score each candidate from 0 to 10:

- Recency: 24h = 2, week = 1.
- Role match: explicit role fit = up to 2.
- KSA match: Saudi/city evidence = up to 2.
- Contact clarity: direct email = 3, clear CTA = 2, vague CTA = 1.
- Poster credibility: recruiter, hiring manager, or company page = 1.

Action thresholds:

- `8-10`: immediate priority.
- `7`: keep and review.
- `<=6`: discard unless niche-critical.

## Deduplication rules

Treat entries as duplicates if any two of these match:

- Same email.
- Same role phrase.
- Same company or poster.
- Same CTA wording within 7 days.

Keep the highest-recency copy.

## Pivot strategy

After finding two or more strong posts:

1. Pivot to People to identify repeat high-signal recruiters.
2. Pivot to Companies using broad terms such as `Saudi recruitment`.
3. Return to Posts with discovered names plus hiring terms.

Avoid over-constraining with exact company name + strict contact phrase in one query.

## Output schema

```text
Post URL:
Posted time:
Role:
Company or poster:
KSA evidence:
Contact email or CTA:
Signal score:
Duplicate group:
Notes:
```

## Run sequence

1. Run Lane A queries with 24h freshness.
2. Score top results.
3. Run Lane B for target roles.
4. Expand to past week where needed.
5. Use Arabic mirror queries when English signal is weak.
6. Use Google X-ray fallback if LinkedIn quality drops.
7. Pivot from strong posts to People and Companies.
8. Deduplicate.
9. Keep only records with score greater than or equal to `MIN_SIGNAL_SCORE`.

## What this skill avoids

- Brittle UI element IDs.
- Click-by-click hardcoding.
- Single-query dependence.
- Over-constrained zero-result patterns.
- Treating old Google-indexed posts as fresh without checking date evidence.
