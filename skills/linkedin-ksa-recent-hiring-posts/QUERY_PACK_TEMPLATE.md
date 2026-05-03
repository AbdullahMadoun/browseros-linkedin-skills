# Query Pack: LinkedIn KSA Recent Hiring Posts

Replace placeholders:

- `[ROLE]`
- `[ROLE_VARIANT]`
- `[INDUSTRY]`
- `[CITY]`
- `[COMPANY]`

## Stage 0: candidate-fit role mapping

If the user provides a CV, profile, or experience summary, map it into 3 to 5 role clusters before searching. Search the top 2 or 3 clusters first.

Common clusters:

1. Applied AI and ML
2. Computer Vision
3. Data Science and Analytics
4. Software Engineering with AI/Data bias

Use level modifiers such as `intern`, `trainee`, `fresh graduate`, `graduate program`, `junior`, and `entry level` when the user is a student or recent graduate.

## Stage 1: prove live hiring activity

1. `"we are hiring" "Saudi Arabia" "send your CV"`
2. `hiring Riyadh hr@`
3. `"وظائف السعودية" hr@`
4. `urgent hiring Saudi Arabia`
5. `send your CV Saudi Arabia`
6. `فرصة وظيفية الرياض`

## Stage 2: add role signal

7. `"[ROLE]" hiring "Saudi Arabia"`
8. `"[ROLE]" "send your CV" Riyadh`
9. `("hiring" OR "looking for") "[ROLE]" [INDUSTRY] ("Saudi Arabia" OR KSA)`
10. `[ROLE_VARIANT] hiring [CITY]`
11. `[ROLE] intern Riyadh`
12. `[ROLE] fresh graduate Saudi Arabia`

## Stage 3: add contact or poster signal

13. `[ROLE] hr@ OR careers@ OR talent@`
14. `[ROLE] WhatsApp OR apply now`
15. `recruiter [ROLE] Riyadh`
16. `talent acquisition [ROLE] Saudi Arabia`
17. `توظيف [ROLE] السعودية`
18. `نبحث عن [ROLE] الرياض`

## Stage 4: add company or industry context

19. `[ROLE] [INDUSTRY] Saudi Arabia`
20. `hiring [ROLE] fintech Riyadh`
21. `hiring [ROLE] healthcare Saudi Arabia`
22. `[COMPANY] hiring [ROLE]`

## LinkedIn URL form

```text
https://www.linkedin.com/search/results/content/?keywords=<ENCODED_QUERY>&origin=GLOBAL_SEARCH_HEADER&datePosted=%22past-24h%22
```

Then expand date to:

```text
%22past-week%22
```

## Google X-ray fallback

Use only after LinkedIn-native recovery paths are exhausted:

23. `site:linkedin.com/posts ("hiring" OR "we are hiring") ("Saudi Arabia" OR Riyadh) ("send your CV" OR email)`
24. `site:linkedin.com/posts [ROLE] hiring Riyadh`
25. `site:linkedin.com/feed/update recruiter Saudi Arabia hiring`

## Google recency

- Week: add `&tbs=qdr:w`.
- Month: add `&tbs=qdr:m`.

## If query fails

1. Remove email tokens first: `hr@`, `careers@`, `@gmail.com`.
2. Keep role + hiring + geo.
3. Expand exact role into adjacent role variants.
4. Switch city-level to Saudi-level geography.
5. Expand 24h to week.
6. Switch English/Arabic mirror query.
7. Pivot to LinkedIn People for recruiters and hiring managers.
8. Check company pages, company posts, and LinkedIn Jobs for active employers.
9. Return to Posts with discovered poster or employer terms.
10. Use Google X-ray fallback only after those steps.
