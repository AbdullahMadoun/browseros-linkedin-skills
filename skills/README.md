# Skills Directory

Skills are grouped by use case. Each leaf folder that contains `SKILL.md` is a BrowserOS skill package; supporting files live inside the same skill folder.

## Package Rules

- Keep one skill per leaf folder under the closest group.
- Keep `SKILL.md` at the folder root.
- Match front matter `name` to the folder name exactly.
- Preserve supporting files such as scripts, manifests, templates, and query packs.
- Prefer updating an existing skill when a new workflow is only a narrow variant.
- Keep public examples generic and remove private paths, filenames, account details, and personal identifiers.

## Search And Lead Intelligence

| Skill | Use |
|---|---|
| `search-state-verification-hygiene` | Start searches cleanly, verify filter changes, and avoid stale browser state. |
| `linkedin-people-url-filtering` | Build repeatable LinkedIn People searches with direct URLs and filters. |
| `linkedin-boolean-query-refinement` | Improve noisy LinkedIn searches with Boolean title and role patterns. |
| `linkedin-ksa-recent-hiring-posts` | Find recent Saudi Arabia hiring posts with bilingual LinkedIn-first search. |
| `linkedin-company-opportunity-mapper` | Map company pages into jobs, posts, people, contacts, and opportunity signals. |
| `linkedin-hiring-post-comment-miner` | Mine hiring-post comments for recruiters, referrals, clarifications, and pivots. |
| `lead-scoring-dedup-pivots` | Score raw leads, deduplicate, and choose the next search or outreach pivot. |

## Outreach Operations

| Skill | Use |
|---|---|
| `linkedin-outreach-sheet-workflow` | Maintain one simple `Outreach` Google Sheet. |
| `linkedin-inbox-preview-backfill` | Backfill recent LinkedIn conversations from inbox previews. |
| `linkedin-row-enrichment` | Enrich selected outreach rows from profiles or message threads. |
| `linkedin-outreach-daily-ops` | Run daily reply/follow-up maintenance without rebuilding the sheet. |
| `google-sheets-connector-reliability` | Recover from flaky, partial, timed-out, or 503 Google Sheets writes. |

## Direct LinkedIn Actions

| Skill | Use |
|---|---|
| `linkedin-messaging-workflow` | Send messages from verified LinkedIn threads. |
| `linkedin-attach-document-workflow` | Attach and send local documents in LinkedIn message threads. |
| `linkedin-connection-workflow` | Send profile-based connection requests and verify invite state. |
| `linkedin-poster-workflow` | Prepare LinkedIn posts, media, documents, polls, or schedules and stop before publish. |
| `linkedin-easy-apply-application-workflow` | Prepare LinkedIn Easy Apply applications and stop before final submit. |

## Application Materials

| Skill | Use |
|---|---|
| `linkedin-job-resume-fit-ranking` | Rank LinkedIn jobs or posts against evidence in a resume. |
| `linkedin-shortlist-resume-batch-tailoring` | Turn a ranked shortlist into one truthful one-page resume per opportunity. |
| `local-latex-resume-tailoring` | Tailor and compile LaTeX resumes locally with alignment and audit artifacts. |
| `grounded-cover-letter-generator` | Draft non-generic cover letter bodies grounded in resume evidence. |
| `ats-keyword-density-review` | Review ATS keyword coverage and stuffing risk. |
| `resume-hallucination-risk-audit` | Audit application materials for unsupported claims. |
| `resume-applied-draft-review` | Compare original and accepted resume drafts for improvement or regression. |
| `company-interview-prep-brief` | Prepare compact company and interview briefs grounded in resume evidence. |

## Outlook Mail

| Skill | Use |
|---|---|
| `outlook-mail-connector-reliability` | Use Outlook Mail connector actions first and fall back only for verified gaps. |
| `outlook-connector-draft-attach-send` | Create Outlook drafts, attach local files in Outlook web, verify, and send. |
| `outlook-scheduled-send-workflow` | Schedule Outlook emails and verify the scheduled state. |
