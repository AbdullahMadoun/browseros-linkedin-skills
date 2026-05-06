# BrowserOS Skills Live Smoke Test - 2026-05-07

## Scope

Read-only/live-boundary tests for the newest and recently compressed BrowserOS
skills. No messages, submissions, profile edits, sheet writes, email sends, or
job applications were completed.

## Local Integrity

- Repo validation passed: frontmatter, bundled references, privacy scan, and
  whitespace diff checks.
- Installed skill validation passed for 40 custom skills.
- Installed bundled-reference check passed.
- Installed runtime was synced with `scripts/install-browseros-skills.sh
  --overwrite --prune`.

## Live Tests

### Connector-First Discovery

Tested BrowserOS connector discovery for Google Sheets and Gmail without
executing actions.

Observed categories:

- Google Sheets: spreadsheet, cell, sheet.
- Gmail: email, batch email, contacts.

Observed next action discovery:

- Sheets: create/get/list spreadsheet and list sheets actions.
- Gmail: send, draft, read, search, modify, delete, attachments.

Result: passed. Connector-first routing can discover actions before browser UI.

### Unknown/Form Workflow Boundary

Target: `https://httpbin.org/forms/post`

Actions:

- Detected fields for name, phone, email, size, toppings, time, instructions,
  and final submit.
- Filled harmless test values.
- Stopped before `Submit order`.

Result: passed. The workflow can identify fields and preserve the final-action
boundary.

### LinkedIn Company Opportunity Mapper

Target: MOZN LinkedIn company page.

Observed evidence:

- Company identity, industry, Riyadh location, size, followers, posts, products,
  people highlights, and jobs surfaced in one company page pass.
- Visible jobs included Data Scientist / Data Scientist I from the initial page
  snapshot.
- Jobs tab/page exposed a total opening count and a `Click to See all jobs at
  MOZN` link rather than always listing full job cards.

Result: passed with one learning. Skill now notes that company pages may expose
only a carousel/count and should open the full company jobs/search link before
calling job coverage weak.

### LinkedIn KSA Recent Hiring Posts

Target query:

`"we are hiring" "Saudi Arabia" "AI"` with LinkedIn Posts and Past week filter.

Observed evidence:

- Search URL opened directly with Posts and Past week filters visible.
- Results included Saudi/Riyadh AI-related hiring signals and job links.
- Some cards exposed useful roles/companies/contact routes, but exact individual
  post timestamps were not always visible in extracted content.

Result: passed with one important guardrail. Skill now explicitly says Past week
filter alone is not enough; open candidate post/job detail and verify visible
LinkedIn-side timestamp before counting a result as recent.

### LinkedIn Comment Miner

Target: a KSA hiring search result with visible comment count.

Observed evidence:

- Clicking a comment count exposed visible comments and a comment composer.
- No comment was typed or submitted.
- Visible comments included recruiter/service-provider signals and candidate/noise
  patterns, which the skill is designed to classify and filter.

Result: passed with one learning. Skill now explicitly says a focused blank
comment editor is a read-only side effect and must not be typed into or
submitted.

### LinkedIn Easy Apply Workflow

Target: real LinkedIn job page for `Senior Agentic AI & LLM Engineer` at
`imkan.ai`.

Observed evidence:

- Direct job page loaded and exposed role, company, Riyadh, hybrid/full-time,
  posting age, applicant count, and Easy Apply control.
- Direct apply URL and visible Easy Apply button did not open a modal in this
  run.
- Enhanced snapshot and DOM showed no dialog or file input after attempts.
- Job description contained an alternate visible contact route.

Result: partially passed. Safety boundary held: no upload, fill, or submit. Skill
now has an explicit `easy_apply_modal_unavailable` status and says to inspect for
alternate contact/apply routes instead of repeatedly clicking.

## Live-Learned Skill Updates

- `linkedin-easy-apply-application-workflow`: added no-op/direct-URL fallback
  handling and new statuses.
- `linkedin-hiring-post-comment-miner`: added blank-comment-editor guardrail.
- `linkedin-company-opportunity-mapper`: added company jobs carousel/count
  handling.
- `linkedin-ksa-recent-hiring-posts`: added visible timestamp verification when
  search filters hide exact post dates.

## Remaining Gaps

- Need a controlled LinkedIn Easy Apply modal that actually opens to test resume
  upload detection and final-review stopping.
- Need one safe LinkedIn post URL with comments/replies expanded from the post
  permalink, not only search-result inline comments.
- Need a real external job portal application form test up to, but not through,
  the final submit boundary.
