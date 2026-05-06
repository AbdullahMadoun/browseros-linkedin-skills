# Skills Directory

Skills are grouped by use case. Each leaf folder that contains `SKILL.md` is a BrowserOS skill package; supporting files live inside the same skill folder.

## Package Rules

- Keep one skill per leaf folder under the closest group.
- Keep `SKILL.md` at the folder root.
- Match front matter `name` to the folder name exactly.
- Preserve supporting files such as scripts, manifests, templates, and query packs.
- Prefer updating an existing skill when a new workflow is only a narrow variant.
- Keep public examples generic and remove private paths, filenames, account details, and personal identifiers.

## BrowserOS Core

| Skill | Use |
|---|---|
| `browseros-skill-router` | Route complex requests to the right skill, connector action, built-in, local/private source, or unknown-site learning path. |
| `browseros-new-site-learning-protocol` | Give new domains/site families a first-time exploration pass and map controls, fields, state, boundaries, success signals, and recovery paths. |
| `connector-first-action-discovery` | Discover and use connected-app actions before brittle browser UI automation. |
| `application-answer-bank-protocol` | Use a private approved-answer bank without putting personal defaults in public skills. |
| `browseros-skill-evolution-loop` | Capture verified live-run insights and promote them into run notes, private memory, existing-skill patches, or new skills. |

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

## Obsidian Knowledge Base

| Skill | Use |
|---|---|
| `obsidian-long-term-memory-workflow` | Save durable BrowserOS memory in a user-approved Obsidian vault instead of chat or transient run notes. |
| `obsidian-job-search-keyword-intelligence` | Maintain a local Obsidian job-search keyword vault with logs, duplicate exclusions, lead notes, source nodes, and application paths. |

## Outreach Operations

| Skill | Use |
|---|---|
| `linkedin-outreach-sheet-workflow` | Maintain one simple `Outreach` Google Sheet. |
| `linkedin-inbox-preview-backfill` | Backfill recent LinkedIn conversations from inbox previews. |
| `linkedin-row-enrichment` | Enrich selected outreach rows from profiles or message threads. |
| `linkedin-outreach-daily-ops` | Run daily reply/follow-up maintenance without rebuilding the sheet. |
| `google-sheets-connector-reliability` | Recover from flaky, partial, timed-out, or 503 Google Sheets writes. |

## Gmail Mail

| Skill | Use |
|---|---|
| `gmail-connector-reliability-workflow` | Use Gmail connector actions first for search, read, drafts, sends, replies, labels, archive, contacts, and received attachments. |
| `gmail-web-fallback-workflow` | Use Gmail web for outgoing attachments, scheduled send, existing draft edits/sends, label management, and visual settings. |

## Direct LinkedIn Actions

| Skill | Use |
|---|---|
| `linkedin-messaging-workflow` | Send messages from verified LinkedIn threads. |
| `linkedin-attach-document-workflow` | Attach and send local documents in LinkedIn message threads. |
| `linkedin-connection-workflow` | Send profile-based connection requests and verify invite state. |
| `linkedin-poster-workflow` | Prepare LinkedIn posts, media, documents, polls, or schedules and stop before publish. |
| `linkedin-easy-apply-application-workflow` | Prepare LinkedIn Easy Apply applications and stop before final submit. |
| `linkedin-profile-optimizer` | Audit and draft LinkedIn profile improvements while stopping before save. |
| `linkedin-post-engagement-lead-miner` | Mine LinkedIn post engagement for warm leads and follow-up actions. |
| `linkedin-feature-learning-lab` | Safely learn new LinkedIn feature families and promote verified shortcuts into narrower skills. |

## Application Materials

| Skill | Use |
|---|---|
| `job-cv-fit-keyword-review` | Rank jobs or posts against CV/resume evidence and check keyword coverage/stuffing risk. |
| `linkedin-shortlist-resume-batch-tailoring` | Turn a ranked shortlist into one truthful one-page resume per opportunity. |
| `local-latex-resume-tailoring` | Tailor, compile, and format-QA LaTeX resumes locally with alignment and audit artifacts. |
| `grounded-cover-letter-generator` | Draft non-generic cover letter bodies grounded in resume evidence. |
| `resume-hallucination-risk-audit` | Audit application materials for unsupported claims. |
| `resume-applied-draft-review` | Compare original and accepted resume drafts for improvement or regression. |
| `company-interview-prep-brief` | Prepare compact company and interview briefs grounded in resume evidence. |

## Job Portals

| Skill | Use |
|---|---|
| `job-portal-application-workflow` | Prepare external job-portal applications, fill approved fields, upload verified documents, and stop before submit. |

## Research Opportunities

| Skill | Use |
|---|---|
| `research-opportunity-finder` | Find credible AI/CS research opportunities with verified eligibility, deadlines, funding, and application routes. |
| `professor-lab-outreach-workflow` | Map professor/lab fit and prepare grounded outreach without sending until approved. |

## Outlook Mail

| Skill | Use |
|---|---|
| `outlook-mail-connector-reliability` | Use Outlook Mail connector actions first and fall back only for verified gaps. |
| `outlook-connector-draft-attach-send` | Create Outlook drafts, attach local files in Outlook web, verify, and send. |
| `outlook-scheduled-send-workflow` | Schedule Outlook emails and verify the scheduled state. |
