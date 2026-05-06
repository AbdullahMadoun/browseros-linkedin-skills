# Usage Ideas And Skill Chains

These chains show how to combine skills without loading the whole repository at once. Use the smallest set that covers the current phase.

## 1. Clean LinkedIn People Search

Use when building a targeted people shortlist.

1. `search-state-verification-hygiene`
2. `linkedin-people-url-filtering`
3. `linkedin-boolean-query-refinement`
4. `lead-scoring-dedup-pivots`

Output:
- verified search URL
- filter stack
- shortlist
- dedupe notes
- next pivots

## 2. Recent KSA Hiring Posts

Use when looking for fresh Saudi Arabia hiring posts and contact routes.

1. `search-state-verification-hygiene`
2. `linkedin-ksa-recent-hiring-posts`
3. `lead-scoring-dedup-pivots`

Rules:
- stay LinkedIn-first
- use redacted resume/profile summaries if candidate fit matters
- use Arabic variants when English results are sparse
- use Google X-ray only after LinkedIn-native recovery paths are exhausted

## 3. Company Opportunity Map

Use when a company page looks promising but needs structured review.

1. `linkedin-company-opportunity-mapper`
2. `linkedin-people-url-filtering` when people search needs validation
3. `linkedin-hiring-post-comment-miner` when relevant posts have useful comments
4. `lead-scoring-dedup-pivots`
5. `linkedin-outreach-sheet-workflow` if tracking is requested

Output:
- company verdict
- visible jobs
- relevant posts
- best contacts
- outreach hooks
- next actions

## 4. Hiring Post Comment Mining

Use when a hiring post may have recruiter replies, referral offers, clarifications, or hidden application routes in comments.

1. `linkedin-hiring-post-comment-miner`
2. `linkedin-company-opportunity-mapper` for company pivots
3. `linkedin-people-url-filtering` for profile validation
4. `lead-scoring-dedup-pivots`

Stop before messaging, connecting, or commenting unless the user explicitly asks.

## 5. Obsidian Job-Search Knowledge Base

Use when search or outreach findings should become a durable Obsidian knowledge base.

1. `obsidian-job-search-keyword-intelligence`
2. `lead-scoring-dedup-pivots` for scoring consistency
3. `gmail-connector-reliability-workflow` or `outlook-mail-connector-reliability` when email status needs verification

Rules:
- check duplicate exclusions before accepting leads
- update keyword maturity after each serious search pass
- create graph-friendly lead, source, recruiter, and application-path notes
- avoid exposing raw contact details or vault paths in chat summaries

## 6. Outreach Tracker From LinkedIn Messages

Use when building or maintaining a lightweight outreach system.

1. `linkedin-outreach-sheet-workflow`
2. `linkedin-inbox-preview-backfill`
3. `linkedin-row-enrichment`
4. `linkedin-outreach-daily-ops`
5. `google-sheets-connector-reliability` whenever writes are flaky

Rules:
- keep one `Outreach` tab
- one row per person
- update only changed rows
- use row numbers or redacted labels in summaries

## 7. Message Or Connect With A Shortlist

Use after a shortlist has been scored and deduplicated.

1. `lead-scoring-dedup-pivots`
2. `linkedin-connection-workflow` for connection requests
3. `linkedin-messaging-workflow` for existing threads
4. `linkedin-attach-document-workflow` when a file must be sent
5. `linkedin-outreach-sheet-workflow` if the action should be tracked

Safety:
- verify recipient before sending
- confirm sensitive files before upload
- verify send or invite state afterward

## 8. LinkedIn Post Preparation

Use when drafting or staging a LinkedIn post without publishing immediately.

1. `linkedin-poster-workflow`
2. `resume-hallucination-risk-audit` if the post mentions credentials, outcomes, metrics, or application claims

Safety:
- verify final text, attachments, audience, comment settings, and schedule state
- never click `Post` or confirm scheduling without explicit final confirmation
- remove staged test files before ending exploration

## 9. Rank Jobs By CV Fit And Keywords

Use when deciding which LinkedIn jobs or posts are worth applying to.

1. `job-cv-fit-keyword-review`
2. `lead-scoring-dedup-pivots` if raw posts need cleanup
3. `local-latex-resume-tailoring` for the chosen role

Output:
- fit score
- verdict
- hard caps or blockers
- strongest evidence
- missing requirements
- keyword coverage and stuffing risks
- recommended next action

## 10. Tailor A Ranked Shortlist

Use when a scored shortlist should become one resume per opportunity.

1. `lead-scoring-dedup-pivots`
2. `linkedin-shortlist-resume-batch-tailoring`
3. `resume-hallucination-risk-audit`
4. `resume-applied-draft-review`
5. `local-latex-resume-tailoring` for individual high-priority roles

Rules:
- keep rank-specific folders
- produce a job-to-resume mapping guide
- enforce page-count and word-count checks
- audit unsupported facts before use

## 11. Single Resume Tailoring And Review

Use when one role is important enough for careful tailoring.

1. `local-latex-resume-tailoring`
2. `job-cv-fit-keyword-review`
3. `resume-hallucination-risk-audit`
4. `resume-applied-draft-review`

Rules:
- use approved source material only
- do not add unsupported tools, credentials, metrics, or outcomes
- preserve layout unless redesign is explicitly requested
- compile locally when possible

## 12. Cover Letter Or Application Note

Use when a grounded cover letter body or fit note is needed.

1. `job-cv-fit-keyword-review` if role fit is not yet clear
2. `grounded-cover-letter-generator`
3. `resume-hallucination-risk-audit`

Rules:
- require a template or confirmed structure
- avoid generic filler
- use only resume-supported and user-approved evidence

## 13. LinkedIn Easy Apply Preparation

Use when preparing an Easy Apply application.

1. `job-cv-fit-keyword-review`
2. `local-latex-resume-tailoring`
3. `linkedin-easy-apply-application-workflow`
4. `resume-hallucination-risk-audit` if new application text is created

Safety:
- fill only known fields
- stop at review/final screen
- never click `Submit application` without explicit confirmation for that job

## 14. Interview Preparation

Use after a role or interview target is known.

1. `company-interview-prep-brief`
2. `linkedin-company-opportunity-mapper` if company LinkedIn context matters
3. `job-cv-fit-keyword-review` if role requirements need mapping

Output:
- compact company brief
- talking points grounded in resume evidence
- likely questions
- red flags
- final prep actions

## 15. Gmail Connector And Web Fallback

Use when Gmail mail work needs search, reading, drafting, sending, replies, attachments, scheduled send, or label management.

1. `gmail-connector-reliability-workflow` for connector-supported search, read, drafts, sends, replies, labels on messages, archive, contacts, and received attachments
2. `gmail-web-fallback-workflow` only for outgoing local attachments, scheduled send/cancel, existing draft edits/sends, label create/rename/delete, and visual settings

Safety:
- draft before sending unless the user already provided complete final send approval
- verify recipients, subject, body, attachments, and scheduled state before any send or schedule action
- use exact test markers for cleanup
- use Trash-label fallback when permanent delete is blocked

## 16. Outlook Draft, Attachment, And Schedule Send

Use when Outlook mail needs drafting, attachments, sending, or scheduling.

1. `outlook-mail-connector-reliability`
2. `outlook-connector-draft-attach-send` when a local file must be attached
3. `outlook-scheduled-send-workflow` when the email must be sent later

Safety:
- connector first for drafts and updates
- confirm exact recipients and sensitive file paths
- verify staged attachment before sending or scheduling
- verify scheduled state with `Cancel send`

## 17. Create Or Improve A Skill

Use when a browser workflow should become reusable.

1. Follow `docs/SKILL_IMPROVEMENT_WORKFLOW.md`
2. Check overlap with existing skills
3. Add or update the skill
4. Update docs and indexes
5. Run `docs/PUBLICATION_AUDIT.md`

Do not push until the complete skill batch is ready and approved.

## 18. Route A Complex BrowserOS Task

Use when the request spans multiple apps, unfamiliar pages, connectors, local files, or final-action safety.

1. `browseros-skill-router`
2. the selected specific skill, built-in skill, connector workflow, or unknown-site protocol

Output:
- chosen route
- skills used
- final state or artifact
- any reusable skill gap

## 19. Learn An Unfamiliar Website

Use when no existing skill covers the site or workflow, or when the domain/site family has not had a first-time exploration pass.

1. `browseros-skill-router`
2. `connector-first-action-discovery` if the target app may be connected
3. `browseros-new-site-learning-protocol`
4. `browseros-skill-evolution-loop`
5. create or improve a specific skill only if the workflow is repeatable and verified

Safety:
- map first
- treat absent registry entries as new-site state
- change one state at a time
- stop before submit, send, publish, payment, delete, invite, or permission change
- save a workflow artifact for substantial learning
- update the private known-site registry after exploration

## 19a. Improve Skills From Live Runs

Use after BrowserOS discovers a better path, hidden control, connector gap, success signal, failure mode, or recovery path during real work.

1. `browseros-skill-evolution-loop`
2. patch the narrowest existing skill when the insight is verified and public-safe
3. write private memory for personal paths, defaults, recipients, documents, or duplicate state
4. create a new skill only for a distinct repeatable workflow

Rules:
- capture every useful insight
- promote only verified reusable insights
- keep public skills generic
- sync installed skills after validation

## 20. Connected App Before Browser UI

Use when a task targets Gmail, Outlook, Sheets, Drive, GitHub, Slack, Notion, Linear, Jira, Vercel, Supabase, Cloudflare, Stripe, YouTube, or another connected app.

1. `connector-first-action-discovery`
2. app-specific reliability skill when available
3. web fallback only for proven connector gaps

Rules:
- read first when state is uncertain
- draft before send where possible
- verify write actions by reading back or checking visible state

## 21. External Job Portal Application

Use when applying through a company career site, Gulf portal, ATS, or LinkedIn external redirect.

1. `job-portal-application-workflow`
2. `browseros-new-site-learning-protocol` for unknown portals
3. `application-answer-bank-protocol`
4. `resume-hallucination-risk-audit` if new free-text application content is created

Safety:
- use approved answer-bank fields only
- verify exact uploaded documents
- stop before final submit
- record portal-specific learning for future reuse

## 22. Research Opportunity Search

Use when finding credible AI/CS research opportunities, RA roles, visiting programs, funded summer options, or lab routes.

1. `research-opportunity-finder`
2. `lead-scoring-dedup-pivots` if many leads need triage
3. `professor-lab-outreach-workflow` for promising professor/lab routes
4. `obsidian-job-search-keyword-intelligence` when durable tracking is needed

Output:
- apply-now list
- monitor list
- professor outreach list
- rejected or weak leads
- source-backed eligibility and deadlines

## 23. Professor Or Lab Outreach

Use after a professor, lab, or project looks like a credible fit.

1. `professor-lab-outreach-workflow`
2. `grounded-cover-letter-generator` only if a longer note is specifically needed
3. `gmail-connector-reliability-workflow` or `outlook-mail-connector-reliability` for drafts/sends
4. `obsidian-job-search-keyword-intelligence` for tracking

Safety:
- verify official contact route
- check duplicate outreach memory
- keep the email short and grounded
- stop before send unless explicitly approved

## 24. LinkedIn Profile Optimization

Use when improving the user's own LinkedIn profile for target roles.

1. `linkedin-profile-optimizer`
2. `resume-hallucination-risk-audit` if drafted text adds new claims

Safety:
- draft changes before opening edit dialogs
- use only approved evidence
- stop before saving profile edits unless explicitly confirmed

## 25. LinkedIn Feature Learning

Use when LinkedIn has a new feature family, changed UI branch, or repeated
automation confusion that is not covered by a narrower skill.

1. `browseros-skill-router`
2. `linkedin-feature-learning-lab`
3. `browseros-skill-evolution-loop`

Safety:
- explore read-only or draft-only paths
- stop before sends, posts, comments, replies, reactions, reposts, invites, accepts, ignores, joins, registrations, saves, applications, profile edits, follows, and sensitive uploads
- capture direct URLs, controls, final-action boundaries, success signals, failure signals, and recovery paths
- patch the narrowest LinkedIn skill only after the insight is verified and public-safe

## 26. Mine LinkedIn Post Engagement

Use after reviewing a LinkedIn post with comments, reactions, or reposts.

1. `linkedin-post-engagement-lead-miner`
2. `lead-scoring-dedup-pivots`
3. `linkedin-outreach-sheet-workflow` or `obsidian-job-search-keyword-intelligence` if tracking is requested
4. `linkedin-messaging-workflow` or `linkedin-connection-workflow` only after approval

Safety:
- deduplicate by profile URL
- do not merge by name alone
- stop before messaging, connecting, or commenting
