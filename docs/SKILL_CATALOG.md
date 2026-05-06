# Skill Catalog

This catalog lists every public custom skill in the repository and the main reason to use it.

## BrowserOS Core

| Skill | Use When | Notes |
|---|---|---|
| `browseros-skill-router` | A request is complex, multi-app, unfamiliar, or likely to repeat failed browser actions. | Chooses custom skill, built-in, connector action, local/private source, or unknown-site protocol. |
| `browseros-new-site-learning-protocol` | No existing skill fits a site/workflow, or the domain/site family is being handled for the first time. | Performs first-time exploration, then maps controls, fields, state changes, final-action boundaries, success signals, and recovery paths. |
| `connector-first-action-discovery` | A connected app may support the task. | Discovers structured actions before falling back to brittle browser UI. |
| `application-answer-bank-protocol` | A form needs personal, application, or document-choice answers. | Uses private approved defaults; never guesses sensitive application fields. |
| `browseros-skill-evolution-loop` | A live run teaches a reusable BrowserOS workflow insight. | Classifies insights as run note, private memory, existing-skill patch, new-skill candidate, or do-not-store. |

## Search And Lead Intelligence

| Skill | Use When | Notes |
|---|---|---|
| `search-state-verification-hygiene` | Search state may be stale, filtered, or inconsistent. | Start clean, change one variable at a time, verify URL/UI/result deltas. |
| `linkedin-people-url-filtering` | You need reproducible LinkedIn People searches. | Includes `build_people_search_url.py`, presets, templates, and URL-lock fallback. |
| `linkedin-boolean-query-refinement` | LinkedIn results are noisy or missing title variants. | Uses role blocks, quoted titles, NOT exclusions, and top-result checks. |
| `linkedin-ksa-recent-hiring-posts` | You need recent Saudi Arabia hiring posts. | Uses LinkedIn-first search, English/Arabic ladders, contact-route scoring, and Google X-ray only after native recovery. |
| `linkedin-company-opportunity-mapper` | A LinkedIn company page needs opportunity analysis. | Maps About, Jobs, Posts, People, recruiters, managers, hooks, and next actions. |
| `linkedin-hiring-post-comment-miner` | A hiring post may hide useful signals in comments. | Extracts recruiters, referral offers, clarifications, contact routes, and company pivots. |
| `lead-scoring-dedup-pivots` | Raw leads need triage. | Scores posts/profiles/companies, deduplicates conservatively, and suggests pivots. |

## Obsidian Knowledge Base

| Skill | Use When | Notes |
|---|---|---|
| `obsidian-job-search-keyword-intelligence` | A job-search Obsidian vault should be updated after search or outreach work. | Maintains keyword maturity, search logs, duplicate exclusions, lead notes, source nodes, application paths, and fit-ranked review queues. |

## Outreach Operations

| Skill | Use When | Notes |
|---|---|---|
| `linkedin-outreach-sheet-workflow` | You need a lightweight LinkedIn outreach tracker. | One `Outreach` tab, one row per person, durable stages, connector-first updates. |
| `linkedin-inbox-preview-backfill` | You need to populate outreach rows quickly from LinkedIn inbox previews. | Avoids opening every thread; does not combine rows by name alone when URLs are missing. |
| `linkedin-row-enrichment` | Selected outreach rows need better URL/title/company/context. | Opens only the needed profile or thread and patches changed fields. |
| `linkedin-outreach-daily-ops` | Outreach needs daily maintenance. | Scans deltas, updates replies/follow-ups, skips unchanged rows. |
| `google-sheets-connector-reliability` | Google Sheets writes are slow, flaky, partial, or timing out. | Uses small batches, verification reads, and patch-only recovery. |

## Gmail Mail

| Skill | Use When | Notes |
|---|---|---|
| `gmail-connector-reliability-workflow` | Gmail work can be done through connector actions. | Search/read first, draft before send, threaded replies, labels, archive/restore, Trash cleanup, contacts, and received attachments. |
| `gmail-web-fallback-workflow` | Gmail connector lacks the needed capability. | Handles outgoing local attachments, scheduled send/cancel, existing draft edits/sends, label create/rename/delete, and visual settings. |

## Direct LinkedIn Actions

| Skill | Use When | Notes |
|---|---|---|
| `linkedin-messaging-workflow` | A LinkedIn message must be sent from an existing thread. | Verifies recipient, composer, send action, and outbound message state. |
| `linkedin-attach-document-workflow` | A local file must be attached in a LinkedIn message. | Requires exact file/recipient confirmation for sensitive documents and verifies staged attachment. |
| `linkedin-connection-workflow` | A profile-based connection request must be sent. | Defaults to no-note flow and requires explicit invite-sent state. |
| `linkedin-poster-workflow` | A LinkedIn post, media post, document post, poll, or scheduled post must be prepared. | Maps composer paths, upload fallbacks, audience/comment settings, and stops before final publish. |
| `linkedin-easy-apply-application-workflow` | A LinkedIn Easy Apply application must be prepared. | Opens jobs, attaches the correct resume, fills only known fields, and stops before final submit. |
| `linkedin-profile-optimizer` | A LinkedIn profile should be audited or improved for target roles. | Drafts headline/About/section changes and stops before saving profile edits. |
| `linkedin-post-engagement-lead-miner` | A LinkedIn post has reactions, comments, or reposts worth mining. | Finds warm leads and follow-up hooks; stops before messaging, connecting, or commenting. |
| `linkedin-feature-learning-lab` | A new LinkedIn feature family or UI branch needs safe exploration. | Maps direct URLs, controls, modals, final-action boundaries, fast paths, and candidate patches for narrower skills. |

## Application Materials

| Skill | Use When | Notes |
|---|---|---|
| `job-cv-fit-keyword-review` | Jobs, LinkedIn posts, recruiter posts, or job descriptions need CV/resume fit and keyword review. | Extracts requirements, maps evidence, scores fit, applies caps, checks keyword coverage, and flags stuffing/unsupported terms. |
| `linkedin-shortlist-resume-batch-tailoring` | A ranked shortlist should become one resume per opportunity. | Uses role-family presets, strict one-page checks, word-count floors, truth audits, and mapping guides. |
| `local-latex-resume-tailoring` | A resume should be tailored locally with LaTeX artifacts. | Uses approved master data, alignment analysis, exact-substring rewrite plans, local PDF compilation, compile recovery, and format QA. |
| `grounded-cover-letter-generator` | A cover letter body is needed. | Requires a template/structure and uses only resume-supported or user-approved evidence. |
| `resume-hallucination-risk-audit` | Edited application materials may contain unsupported claims. | Audits tools, employers, titles, dates, degrees, metrics, outcomes, and ownership verbs. |
| `resume-applied-draft-review` | A final accepted resume draft needs review. | Compares original vs accepted draft for wins, regressions, remaining gaps, and readiness. |
| `company-interview-prep-brief` | Interview preparation needs company context and grounded talking points. | Combines compact research, likely questions, red flags, and resume evidence. |

## Job Portals

| Skill | Use When | Notes |
|---|---|---|
| `job-portal-application-workflow` | A non-LinkedIn portal or company career page application must be prepared. | Learns unknown forms, uses approved answers, verifies documents, and stops before submit. |

## Research Opportunities

| Skill | Use When | Notes |
|---|---|---|
| `research-opportunity-finder` | Credible AI/CS research opportunities, RA roles, visiting programs, or funded summer options are needed. | Verifies eligibility, deadlines, funding, location, and application routes against sources. |
| `professor-lab-outreach-workflow` | A professor or lab should be contacted for a grounded research opportunity. | Maps fit, checks duplicate outreach, drafts concise email, and stops before send. |

## Outlook Mail

| Skill | Use When | Notes |
|---|---|---|
| `outlook-mail-connector-reliability` | Outlook mail should use connector actions first. | Drafts, updates, sends, verifies, and falls back to browser only for verified gaps. |
| `outlook-connector-draft-attach-send` | Outlook email needs a local attachment. | Creates connector drafts, attaches files in Outlook web, verifies staging, and sends. |
| `outlook-scheduled-send-workflow` | Outlook email must be sent later. | Handles exact date/time/timezone and verifies scheduled state with `Cancel send`. |

## Skill Development

| Document | Use |
|---|---|
| `docs/SKILL_IMPROVEMENT_WORKFLOW.md` | Exploration-first process for creating or improving reusable browser skills. |
| `docs/PUBLICATION_AUDIT.md` | Public-release checklist for metadata, privacy, docs, and safety checks. |
