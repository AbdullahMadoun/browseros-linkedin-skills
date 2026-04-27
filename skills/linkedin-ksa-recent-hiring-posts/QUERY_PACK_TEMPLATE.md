# Query Pack: LinkedIn KSA Recent Hiring Posts

Replace placeholders:

- `[ROLE]`
- `[INDUSTRY]`

## Lane A: yield / high hit-rate

1. `"we are hiring" "Saudi Arabia" "send your CV"`
2. `hiring Riyadh hr@`
3. `"وظائف السعودية" hr@`

## Lane B: precision / role-targeted

4. `"[ROLE]" hiring "Saudi Arabia"`
5. `"[ROLE]" "send your CV" Riyadh`
6. `("hiring" OR "looking for") "[ROLE]" [INDUSTRY] ("Saudi Arabia" OR KSA)`

## Arabic precision variants

7. `توظيف [ROLE] السعودية`
8. `"[ROLE]" الرياض السيرة`

## LinkedIn URL form

```text
https://www.linkedin.com/search/results/content/?keywords=<ENCODED_QUERY>&origin=GLOBAL_SEARCH_HEADER&datePosted=%22past-24h%22
```

Then expand date to:

```text
%22past-week%22
```

## Google X-ray fallback

9. `site:linkedin.com/posts ("hiring" OR "we are hiring") ("Saudi Arabia" OR Riyadh) ("send your CV" OR email)`
10. `site:linkedin.com/feed/update "hiring" "Saudi Arabia" "send your CV"`

## Google recency

- Week: add `&tbs=qdr:w`.
- Month: add `&tbs=qdr:m`.

## If query fails

1. Remove email tokens first: `hr@`, `careers@`, `@gmail.com`.
2. Keep role + hiring + geo.
3. Expand 24h to week.
4. Switch English/Arabic mirror query.
5. Use Google X-ray fallback.

