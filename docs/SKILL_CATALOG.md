# Skill Catalog

This catalog describes every skill in the merged BrowserOS LinkedIn skills repository.

## Search and Lead Discovery

### `search-state-verification-hygiene`

Use before or during any search workflow where old filters, hidden state, stale tabs, date ranges, or location settings could affect results.

Best for:
- Clean-starting a LinkedIn or Google search.
- Verifying a filter actually applied.
- Switching to URL-lock mode when UI chips are inconsistent.
- Keeping browser-agent actions within a click budget.

Core output:
- Clean base URL.
- Intended vertical.
- Query and filter stack.
- Step verification notes.
- Reliability notes and reset instructions.

### `linkedin-people-url-filtering`

Use when BrowserOS needs repeatable LinkedIn People searches without wasting clicks in mixed search results.

Best for:
- Opening direct `/search/results/people/` URLs.
- Applying second-degree, location, and current-company filters.
- Building reproducible People search URLs.
- Avoiding stale filter carryover between runs.

Supporting files:
- `build_people_search_url.py`
- `presets.md`
- `templates.md`
- `manifest.json`

### `linkedin-boolean-query-refinement`

Use when LinkedIn results are too broad, too noisy, or missing role/title variants.

Best for:
- Building role-family Boolean blocks.
- Adding quoted exact titles.
- Adding NOT exclusions for recurring noise.
- Testing one variable per pass.
- Saving winning query/filter combinations.

Supporting files:
- `templates.md`
- `manifest.json`

### `linkedin-ksa-recent-hiring-posts`

Use when BrowserOS needs to find recent Saudi Arabia hiring posts with direct contact routes.

Best for:
- LinkedIn Posts search with past-24h and past-week freshness.
- English and Arabic hiring queries.
- Mapping a CV/profile into ranked role clusters before searching.
- LinkedIn-native recruiter, company, and jobs validation pivots before Google.
- Email-first and CTA-first lead discovery.
- Google X-ray fallback when LinkedIn ranking is weak.
- Scoring and deduplicating fresh hiring posts.

Supporting files:
- `QUERY_PACK_TEMPLATE.md`
- `config.template.json`
- `templates/results_template.csv`
- `templates/run_log_template.md`
- `manifest.json`

### `lead-scoring-dedup-pivots`

Use after search returns raw posts, people, companies, snippets, recruiters, or contact routes.

Best for:
- Scoring candidates from 0 to 10.
- Removing duplicate posts or profiles.
- Keeping only action-ready leads.
- Pivoting from posts to people, people to posts, posts to companies, and companies to people.

Supporting files:
- `templates.md`
- `manifest.json`

## Outreach Tracking and Operations

### `linkedin-outreach-sheet-workflow`

Use when building or operating a LinkedIn outreach tracker in Google Sheets.

Best for:
- Designing the workbook architecture.
- Creating `Outreach_Table`, `People`, `Threads`, `Activity_Log`, `Queue`, `Import_Log`, and metadata tabs.
- Choosing stable person/thread/event/action keys.
- Separating inbox observation from structured sheet memory.
- Building a traceable, auditable outreach operating system.

### `linkedin-inbox-preview-backfill`

Use for the first bounded import from LinkedIn messages into Google Sheets.

Best for:
- Populating recent outreach quickly.
- Scanning inbox preview rows before opening threads.
- Capturing last-touch direction and likely reply state.
- Writing placeholders for fields that need later enrichment.
- Getting an operational table without solving the whole inbox.

### `linkedin-row-enrichment`

Use after preview backfill when selected rows need better data.

Best for:
- Opening high-priority profiles to confirm URL, title, and company.
- Opening threads to confirm exact outbound/inbound message context.
- Raising confidence from medium to high.
- Patching only missing fields.

### `linkedin-outreach-daily-ops`

Use for ongoing maintenance after the first backfill.

Best for:
- Daily inbox-preview scans.
- Detecting changed/new threads.
- Updating reply, follow-up, enrichment, and queue state.
- Skipping unchanged rows.
- Logging daily runs.

### `google-sheets-connector-reliability`

Use whenever Google Sheets writes become flaky, slow, partial, timeout-prone, or return 503.

Best for:
- Small logical batches.
- Partial-write verification.
- Patch-only recovery.
- Connector-safe placeholders.
- Avoiding duplicate rows and blind rewrites.

## Direct LinkedIn Actions

### `linkedin-messaging-workflow`

Use when BrowserOS needs to send a normal LinkedIn message in an existing thread.

Best for:
- Opening the correct thread from the conversation list.
- Filling the `Write a message...` composer.
- Sending via `Control+Enter` or the Send button.
- Verifying the outbound message appears.

### `linkedin-attach-document-workflow`

Use when BrowserOS needs to send a local document through a LinkedIn message thread.

Best for:
- Locating the exact absolute file path.
- Exposing LinkedIn's hidden document file input.
- Uploading the file through `upload_file`.
- Verifying staged attachment before sending.
- Verifying the document card after sending.

### `linkedin-connection-workflow`

Use when BrowserOS needs to send LinkedIn connection requests.

Best for:
- Profile-based Connect/Invite flow.
- Send without a note.
- Avoiding unreliable suggestion-card invite buttons.
- Verifying that Connect disappeared or Pending/Message/More remains.

## Job Application Support

### `local-latex-cv-tailoring`

Use when BrowserOS needs to tailor Abdullah Madoun's CV to a role while keeping the workflow local and auditable.

Best for:
- Turning a job description or hiring post into a tailored CV target.
- Selecting approved master-CV bullets deterministically.
- Preserving the existing LaTeX layout.
- Saving per-role `.tex`, report, job snapshot, and optional PDF outputs.
- Avoiding invented achievements, dates, technologies, or metrics.
