# BrowserOS Skills Live Smoke Test - 2026-05-07 Pass 2

## Scope

Second live automation-only pass. No final submissions, messages, sends, posts,
saves, uploads, or profile edits were completed.

## Easy Apply Deep Test

Target family: LinkedIn Easy Apply.

What was tested:

- LinkedIn Easy Apply search URL with `f_AL=true` and newest sort.
- Several direct apply URLs.
- Background-tab apply attempts.
- Foreground-tab apply attempt.
- Modal opening, contact step, resume step, file-input detection, and draft
  cleanup boundary.

Findings:

- Some LinkedIn Easy Apply buttons/direct apply URLs do nothing in background
  tabs. Foreground focus can matter.
- A real modal appeared for a foreground job apply flow.
- LinkedIn may show a `Save this application?` gate before or while closing a
  draft.
- The modal exposes `role=dialog`, `jobs-easy-apply-modal`, progress percentage,
  `Back`, `Next`, selected/saved resume cards, and a hidden
  `input[type=file]`.
- Resume cards show filename, file size, and last-used date; upload control
  stated DOC/DOCX/PDF and max 2 MB.
- Closing and choosing `Discard` cleaned the draft but may navigate away from the
  job context.

Skill updates:

- Added foreground-tab retry guidance.
- Added modal anatomy signals.
- Added saved-resume-card detection details.
- Added `Save this application?` draft-gate handling and job-URL capture rule.

## LinkedIn Company Jobs Expansion

Target family: LinkedIn company jobs.

What was tested:

- MOZN full company jobs search URL from company-page jobs expansion.

Findings:

- The full search page exposed `27 results`.
- Visible results included Data Scientist I, Data Engineer I, Senior Data
  Scientist - Riyadh, Presales Engineer - FOCAL, Full Stack Software Engineer
  III, Data Scientist, and Senior Software Engineer.
- The company-page carousel is not enough for coverage; use the full jobs search
  link to extract role/location/job URLs.

Skill status:

- Covered by the previous company mapper patch; no new patch needed in pass 2.

## LinkedIn Comment Permalink / Search Result

Target family: LinkedIn post search result comments.

What was tested:

- Search-result cards with comments and control-menu attempts.
- DOM/link extraction for feed permalink URLs.

Findings:

- LinkedIn search cards may not expose stable `/feed/update/` links through page
  links or DOM attributes.
- Inline comment expansion may be the practical path from search results.
- Existing blank-comment-editor guardrail remains useful.

Skill status:

- No additional patch beyond previous inline-comment guardrail.

## Greenhouse First-Time Site Exploration

Target family: Greenhouse ATS.

What was tested:

- `boards.greenhouse.io/<company>` board.
- `job-boards.greenhouse.io/<company>/jobs/<job_id>` detail page.
- Job listing links, search/filter controls, form fields, upload controls,
  combobox mechanics, and final submit boundary.

Findings:

- Greenhouse board pages expose job links well via `get_page_links`.
- Job detail pages can expose the full application form on the same page.
- Resume attach uses a visible `Attach` button plus hidden `input[type=file]`.
- Accepted resume extensions observed: `.pdf`, `.doc`, `.docx`, `.txt`, `.rtf`.
- Cloud/manual alternatives may appear: Dropbox, Google Drive, enter manually.
- Greenhouse uses React-style combobox inputs with hidden required inputs.
- Final `Submit application` can be enabled even with required fields empty, so
  enabled state is not readiness.
- Optional demographic/veteran/disability fields appear after role questions and
  must be skipped or answered only from approved preferences.

Skill/registry updates:

- Added `references/greenhouse-ats.md` under `job-portal-application-workflow`.
- Added Greenhouse known-site entry to the private registry.
- Added generic rule: do not treat enabled final submit as readiness.

## Validation

- Repo validation passed: frontmatter, bundled references, privacy scan.
- Site registry JSON parsed.
- `git diff --check` clean.
- Installed skills synced with `--overwrite --prune`.
- Installed bundled references verified.

## Remaining Useful Tests

- Ashby application form mechanics.
- Lever application form mechanics on a live open role.
- Workday account/login boundary mapping.
- LinkedIn Easy Apply screening-question step on a safe role, stopping before
  final submit.
- LinkedIn post permalink workflow from a direct `/feed/update/` URL.
