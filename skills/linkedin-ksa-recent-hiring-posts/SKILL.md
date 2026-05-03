---
name: linkedin-ksa-recent-hiring-posts
description: >-
  Find recent Saudi Arabia LinkedIn hiring posts with a LinkedIn-first search
  ladder, smart bilingual keyword generation, disciplined query iteration,
  candidate-to-role mapping, recruiter and company pivots, and Google X-ray only
  after LinkedIn-native recovery paths are exhausted.
metadata:
  display-name: LinkedIn KSA Recent Hiring Posts
  enabled: "true"
  version: "1.1"
---

# LinkedIn KSA Recent Hiring Posts

## Trigger
Use this skill when BrowserOS needs to find recent hiring posts on LinkedIn in Saudi Arabia, especially when the goal is to find live post-based hiring signals, direct recruiter contact routes, or fresh opportunities around a target role.

## Core operating rule
Stay inside LinkedIn as long as possible.
The default path is:
1. LinkedIn Posts
2. LinkedIn People pivots
3. LinkedIn Company and Jobs validation pivots
4. Google X-ray only as last resort

Do not start with Google. Do not assume Google recency is trustworthy. Do not treat LinkedIn All results as equivalent to LinkedIn Posts.

## Purpose
Find fresh KSA hiring signals by searching LinkedIn posts first, using structured LinkedIn-native query ladders, smart bilingual keyword packs, disciplined query mutation, candidate-to-role mapping, role-family expansion, recruiter and company pivots, and controlled fallbacks.

## New candidate-fit rule
When the user provides a CV, profile, or experience summary, derive role families before searching.
Do not search for one literal title only.
Map the profile into 3 to 5 ranked role clusters, then search the highest-fit clusters first.

## Candidate-to-role mapping
Infer role clusters from evidence in the profile.

### Cluster A: Applied AI and ML
Use when the profile shows model building, experimentation, Python ML stack, LLMs, model optimization, or deployed inference work.
Common titles:
- Machine Learning Engineer
- AI Engineer
- Applied AI Engineer
- Applied Scientist Intern
- ML Research Engineer
- AI Solutions Engineer

### Cluster B: Computer Vision
Use when the profile shows detection, segmentation, image classification, video understanding, VLMs, or vision pipelines.
Common titles:
- Computer Vision Engineer
- CV Engineer
- Vision ML Engineer
- AI Research Intern
- Imaging AI Engineer
- Perception Engineer

### Cluster C: Data Science and Analytics
Use when the profile shows metrics, fraud analysis, forecasting, BI, experimentation, tabular ML, analytics, or dashboards.
Common titles:
- Data Scientist
- Data Analyst
- Product Analyst
- Analytics Engineer
- BI Analyst
- Operations Analyst

### Cluster D: Software Engineering with AI/Data bias
Use when the profile shows APIs, backend systems, Docker, SQL, FastAPI, integration work, or productization of ML.
Common titles:
- Software Engineer
- Backend Engineer
- AI Platform Engineer
- ML Platform Intern
- Data Engineer Intern

## Candidate-fit scoring for clusters
Score each cluster from 0 to 5 using profile evidence:
- direct project/work evidence = up to 2
- toolchain evidence = up to 1
- measurable results or shipping evidence = up to 1
- market plausibility for current seniority = up to 1

Search the top 2 or 3 clusters first.
If the user is a student or expected graduate, bias toward:
- intern
- trainee
- fresh graduate
- graduate program
- junior
- entry level

## Seniority normalization
When the user is still in university or recently graduated, search with these level modifiers before mid-senior titles:
- intern
- internship
- trainee
- graduate
- fresh graduate
- junior
- entry level

Only broaden beyond this if the market is sparse and the profile is unusually strong.

## Success target
The goal is not just to find job-related content. The goal is to find posts that contain one or more of the following:
- a clear hiring intent
- a relevant role signal
- Saudi geography evidence
- a direct contact route or apply path
- a credible poster such as a recruiter, hiring manager, founder, or company page

## Search modes
Choose one mode at the start.

### Mode A: market scan
Use when the role is broad or the market signal is unknown.
Goal: prove that fresh hiring activity exists before narrowing.

### Mode B: target-role hunt
Use when the user gave a specific role.
Goal: find role-relevant hiring posts without over-constraining too early.

### Mode C: recruiter-source discovery
Use when direct role queries are weak.
Goal: find repeat recruiters, talent acquisition people, founders, or company posters who repeatedly publish relevant hiring posts.

### Mode D: employer-thread discovery
Use when the user cares about a known company, domain, or city cluster.
Goal: find employer posting patterns, then return to broader post search using the discovered terms.

## Inputs
- ROLE_KEYWORDS: required target role terms.
- ROLE_VARIANTS: optional adjacent or alternate titles.
- INDUSTRY_KEYWORDS: optional industry or domain terms.
- GEO_SCOPE: Saudi Arabia, Riyadh, Jeddah, Dammam, Khobar, Medina, Makkah, or another KSA city.
- FRESHNESS_SEQUENCE: default past-24h, then past-week.
- MIN_SIGNAL_SCORE: default 7.
- STRICTNESS: broad, balanced, or precision.
- CANDIDATE_PROFILE: optional CV, LinkedIn summary, or project history.

## LinkedIn-first source order
Always search in this order unless the user explicitly asks otherwise:
1. LinkedIn Posts search
2. LinkedIn People search for recruiters and hiring managers
3. LinkedIn company pages and company post patterns
4. LinkedIn Jobs only as supporting validation or employer discovery
5. Google X-ray over LinkedIn URLs only when LinkedIn-native retrieval is weak

This keeps the workflow post-led instead of search-engine-led.

## Required starting workflow
Before running this skill:
1. Use search-state-verification-hygiene.
2. Start from a clean LinkedIn Posts URL or visible reset state.
3. Confirm the active vertical is Posts, not All.
4. Apply one change at a time.
5. Verify URL, visible UI state, and result-set change after each step.

If titles are noisy or ambiguous, apply linkedin-boolean-query-refinement logic inside the query before adding more UI filters.

## Query-building framework
Build queries from reusable blocks instead of writing plain one-off searches.
Each query should combine up to four blocks:
1. hiring-intent block
2. role block
3. geography block
4. contact or poster block

Start with 2 blocks. Move to 3. Use 4 only when the earlier steps proved there is volume.

## Smart keyword packs
Use these as interchangeable blocks, not all at once.

### Hiring-intent pack
English:
- we are hiring
- hiring
- urgent hiring
- looking for
- join our team
- open position
- job opening
- actively hiring

Arabic:
- توظيف
- مطلوب
- فرصة وظيفية
- شاغر
- نبحث عن
- وظيفة شاغرة

### Contact-route pack
English:
- send your CV
- share your CV
- resume
- email
- hr@
- careers@
- talent@
- recruitment@
- apply now
- WhatsApp
- DM me

Arabic:
- ارسل السيرة
- السيرة الذاتية
- التقديم
- واتساب
- راسلني
- التقديم المباشر

### Geography pack
English:
- Saudi Arabia
- KSA
- Riyadh
- Jeddah
- Dammam
- Khobar
- Makkah
- Medina

Arabic:
- السعودية
- الرياض
- جدة
- الدمام
- الخبر
- مكة
- المدينة

### Poster-persona pack
- recruiter
- talent acquisition
- hiring manager
- HR
- founder
- people operations
- technical recruiter
- recruiter Saudi Arabia

### KSA-specific hiring-signal pack
Use when appropriate to local hiring patterns:
- immediate joiner
- transferable iqama
- Saudi national
- Arabic speaker
- based in Riyadh
- relocation to Riyadh
- on-site Riyadh
- KSA market

## Smart keyword generation rules
When the user gives a role, generate a search family instead of a single search term.
Build the family from:
1. exact role
2. adjacent local-market titles
3. seniority variants if common
4. domain qualifiers if useful
5. poster-persona cues if direct role queries are weak
6. Arabic mirror where possible

Example pattern:
ROLE core + hiring-intent + GEO
then ROLE variant + hiring-intent + GEO
then ROLE core + contact-route + GEO
then poster-persona + ROLE + GEO

## Role expansion rules
If the user gives one role, expand it before concluding the market is weak.
Rules:
1. Start with the exact role.
2. Add 2 to 4 realistic adjacent titles.
3. Add seniority variants only if they are common in the market.
4. Add domain variants only if they preserve intent.
5. Prefer title families over one brittle exact title.

Examples:
- Account Manager becomes Sales Account Manager, Key Account Manager, Business Development Manager.
- Software Engineer becomes Backend Engineer, Full Stack Engineer, Frontend Engineer, Developer.
- HR becomes Talent Acquisition, Recruiter, People Operations, HR Specialist.
- Data Analyst becomes Business Analyst, BI Analyst, Reporting Analyst, Analytics Specialist.

## Query ladder
Run these progressively.

### Stage 1: prove live hiring activity
Use broad posting phrases first.
1. we are hiring Saudi Arabia
2. hiring Riyadh
3. urgent hiring Saudi Arabia
4. send your CV Saudi Arabia
5. توظيف السعودية
6. وظائف الرياض
7. مطلوب السعودية
8. فرص وظيفية الرياض

### Stage 2: add role signal
9. ROLE hiring Saudi Arabia
10. ROLE Riyadh hiring
11. ROLE send your CV
12. hiring ROLE Riyadh
13. وظائف ROLE السعودية
14. مطلوب ROLE الرياض
15. ROLE intern Riyadh
16. ROLE fresh graduate Saudi Arabia

### Stage 3: add poster or contact signal
17. ROLE hr@ OR careers@ OR talent@
18. ROLE WhatsApp OR apply now
19. hiring ROLE email OR CV OR resume
20. recruiter ROLE Riyadh
21. talent acquisition ROLE Saudi Arabia
22. نبحث عن ROLE الرياض

### Stage 4: add company or industry context
23. ROLE INDUSTRY_KEYWORDS Saudi Arabia
24. hiring ROLE fintech Riyadh
25. hiring ROLE healthcare Saudi Arabia
26. company_name hiring ROLE
27. ROLE KSA market

### Stage 5: recover weak searches with pivots
If direct role-post queries are weak:
1. search recruiter or talent-acquisition personas in People
2. open the strongest posters
3. return to Posts using those names plus hiring phrases
4. inspect company pages for repeated post patterns
5. use LinkedIn Jobs only to discover active employers, then pivot back to Posts

## Query mutation discipline
Change only one variable per pass.
A pass may change exactly one of these:
- hiring phrase
- role variant
- geography scope
- contact-route token
- poster-persona token
- freshness window
- domain qualifier
- seniority modifier

After each pass:
1. inspect the top results
2. label the change as better, worse, or neutral
3. keep the change only if relevance improved without collapsing volume
4. record the winning pattern

Do not change role, city, contact token, and industry all at once.

## Relevance check protocol
For every pass, review the top 5 to 10 visible posts and judge:
- how many are clearly hiring posts
- how many match the target role or adjacent role family
- how many show KSA evidence
- how many contain a direct CTA or contact route
- how many are noise

If fewer than 2 out of the top 10 are genuinely useful, the query needs refinement or a pivot.

## LinkedIn filter strategy
Apply in this order:
1. switch to Posts
2. set Date posted to Past 24 hours
3. keep geography in the query first
4. add location filter at country level only if needed
5. narrow to city only if volume is still too high
6. expand to Past week only after exhausting 24h runs

Prefer query-level geography first because aggressive UI filtering can hide recruiter posts that still matter.

## LinkedIn-native recovery path before Google
If results are weak, do this in order:
1. remove strict contact tokens
2. keep hiring intent plus role plus geography
3. expand exact role into variants
4. switch from city-level to Saudi-level geography
5. widen from 24h to week
6. mirror the query in Arabic or English
7. try poster-persona queries
8. pivot to People for recruiters and hiring managers
9. inspect company pages or company posts
10. use LinkedIn Jobs to discover active employers
11. return to Posts with the new employer or poster terms
12. only then use Google X-ray

## Google X-ray policy
Google is not the normal search path.
Use it only when:
- LinkedIn Posts search is unstable
- LinkedIn retrieval quality is poor after LinkedIn-native pivots
- or a pattern is likely real but not surfacing reliably in LinkedIn search

Use Google only for LinkedIn URLs.
Fallback patterns:
- site:linkedin.com/posts hiring Saudi Arabia send your CV
- site:linkedin.com/posts ROLE hiring Riyadh
- site:linkedin.com/feed/update recruiter Saudi Arabia hiring

Never treat a Google result as fresh until the LinkedIn post itself confirms acceptable date evidence.

## Result validation rules
Do not count a post as strong unless you validate as many of these as possible:
- visible post recency
- role signal in the post body or surrounding context
- Saudi or city evidence
- contact route or apply instruction
- credible poster identity
- non-duplicate status

Do not confuse these with real hiring leads:
- employer-branding posts with no open role
- motivational recruitment content with no CTA
- reposted stale hiring posts
- generic job-board spam
- irrelevant internship, bootcamp, visa, or course posts unless requested

## Signal scoring
Score each candidate from 0 to 10:
- Recency: 24h = 2, week = 1.
- Role match: exact fit = 2, adjacent fit = 1.
- Geography match: Saudi or city evidence = up to 2.
- Contact clarity: direct email or WhatsApp = 3, strong apply CTA = 2, vague CTA = 1.
- Poster credibility: recruiter, hiring manager, founder, or company page = 1.

Action thresholds:
- 8 to 10: immediate priority
- 7: keep and review
- 6 or below: discard unless niche-critical

## Stop conditions
Stop the current branch of search when:
- 3 consecutive query mutations are neutral or worse
- result quality collapses after a new filter
- LinkedIn state cannot be verified after one retry
- the top results drift out of Posts relevance
- enough high-signal leads have already been collected

When stopping, pivot instead of brute-forcing more keywords.

## Output schema
Post URL:
Posted time:
Role:
Company or poster:
KSA evidence:
Contact route:
Language:
Signal score:
Candidate-fit cluster:
Duplicate group:
Next pivot:
Notes:

Run summary:
Winning query:
Winning mode:
Best signal observed:
Noise observed:
Next query or pivot:
