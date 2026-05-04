# Skill Catalog

This catalog lists every public custom skill in the repository and the main reason to use it.

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

## Outreach Operations

| Skill | Use When | Notes |
|---|---|---|
| `linkedin-outreach-sheet-workflow` | You need a lightweight LinkedIn outreach tracker. | One `Outreach` tab, one row per person, durable stages, connector-first updates. |
| `linkedin-inbox-preview-backfill` | You need to populate outreach rows quickly from LinkedIn inbox previews. | Avoids opening every thread; does not combine rows by name alone when URLs are missing. |
| `linkedin-row-enrichment` | Selected outreach rows need better URL/title/company/context. | Opens only the needed profile or thread and patches changed fields. |
| `linkedin-outreach-daily-ops` | Outreach needs daily maintenance. | Scans deltas, updates replies/follow-ups, skips unchanged rows. |
| `google-sheets-connector-reliability` | Google Sheets writes are slow, flaky, partial, or timing out. | Uses small batches, verification reads, and patch-only recovery. |

## Direct LinkedIn Actions

| Skill | Use When | Notes |
|---|---|---|
| `linkedin-messaging-workflow` | A LinkedIn message must be sent from an existing thread. | Verifies recipient, composer, send action, and outbound message state. |
| `linkedin-attach-document-workflow` | A local file must be attached in a LinkedIn message. | Requires exact file/recipient confirmation for sensitive documents and verifies staged attachment. |
| `linkedin-connection-workflow` | A profile-based connection request must be sent. | Defaults to no-note flow and requires explicit invite-sent state. |
| `linkedin-poster-workflow` | A LinkedIn post, media post, document post, poll, or scheduled post must be prepared. | Maps composer paths, upload fallbacks, audience/comment settings, and stops before final publish. |
| `linkedin-easy-apply-application-workflow` | A LinkedIn Easy Apply application must be prepared. | Opens jobs, attaches the correct resume, fills only known fields, and stops before final submit. |

## Application Materials

| Skill | Use When | Notes |
|---|---|---|
| `linkedin-job-resume-fit-ranking` | LinkedIn jobs or posts need ranking against a resume. | Extracts requirements, maps evidence, applies caps, and gives candid fit verdicts. |
| `linkedin-shortlist-resume-batch-tailoring` | A ranked shortlist should become one resume per opportunity. | Uses role-family presets, one-page checks, truth audits, and mapping guides. |
| `local-latex-resume-tailoring` | A resume should be tailored locally with LaTeX artifacts. | Uses approved master data, deterministic content selection, and optional local PDF compilation. |
| `grounded-cover-letter-generator` | A cover letter body is needed. | Requires a template/structure and uses only resume-supported or user-approved evidence. |
| `ats-keyword-density-review` | A resume needs ATS keyword review. | Finds missing supported terms, weak evidence, overuse, and stuffing risk. |
| `resume-hallucination-risk-audit` | Edited application materials may contain unsupported claims. | Audits tools, employers, titles, dates, degrees, metrics, outcomes, and ownership verbs. |
| `resume-applied-draft-review` | A final accepted resume draft needs review. | Compares original vs accepted draft for wins, regressions, remaining gaps, and readiness. |
| `company-interview-prep-brief` | Interview preparation needs company context and grounded talking points. | Combines compact research, likely questions, red flags, and resume evidence. |

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
