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
- Mapping a resume/profile into ranked role clusters before searching.
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
- Keeping outreach in one simple `Outreach` sheet.
- Using one row per person with normalized LinkedIn URL as the preferred key.
- Managing relationship state with durable stage values.
- Managing work state with `next_action_on` and `next_action`.
- Improving rows iteratively without creating helper tabs.

### `linkedin-inbox-preview-backfill`

Use for the first bounded import from LinkedIn messages into Google Sheets.

Best for:
- Populating recent outreach quickly.
- Scanning inbox preview rows before opening threads.
- Capturing last-touch direction and likely reply state.
- Creating minimal useful rows in the `Outreach` sheet.
- Getting an operational table without solving the whole inbox.

### `linkedin-row-enrichment`

Use after preview backfill when selected rows need better data.

Best for:
- Opening high-priority profiles to confirm URL, title, and company.
- Opening threads to confirm exact outbound/inbound message context.
- Improving only the existing `Outreach` row.
- Patching only missing or corrected fields.

### `linkedin-outreach-daily-ops`

Use for ongoing maintenance after the first backfill.

Best for:
- Daily inbox-preview scans.
- Detecting changed/new threads.
- Updating reply, follow-up, enrichment, and queue state.
- Skipping unchanged rows.
- Maintaining `next_action_on`, `next_action`, and short durable notes.

### `google-sheets-connector-reliability`

Use whenever Google Sheets writes become flaky, slow, partial, timeout-prone, or return 503.

Best for:
- Small logical batches.
- Partial-write verification.
- Patch-only recovery.
- Connector-first one-sheet updates.
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
- Verifying an explicit invite-sent state such as Pending, Invitation sent, or Withdraw.

## Outlook Mail Actions

### `outlook-mail-connector-reliability`

Use when BrowserOS needs to draft, update, send, or verify Outlook email through the Outlook Mail connector.

Best for:
- Connector-first draft creation and updates.
- Plain no-attachment sends through the connector.
- Sent Items verification with narrow reads.
- Knowing when browser fallback is justified.
- Avoiding duplicate sends and heavy mailbox queries.

### `outlook-connector-draft-attach-send`

Use when BrowserOS needs to create an Outlook draft through the connector, attach a local file in Outlook web, then send safely.

Best for:
- Resolving exact local attachment paths.
- Opening the connector-created draft by `webLink`.
- Exposing Outlook's hidden file input when needed.
- Verifying staged attachments before send.
- Verifying delivery and attachment state after send.

### `outlook-scheduled-send-workflow`

Use when BrowserOS needs to schedule, delay delivery, or send later from Outlook.

Best for:
- Connector-created draft content.
- Outlook web schedule-send fallback.
- Explicit date, time, and timezone handling.
- Pop-out compose recovery when embedded compose fails.
- Verifying scheduled state through `Cancel send`.

## Job Application Support

### `local-latex-resume-tailoring`

Use when BrowserOS needs to tailor a resume to a role while keeping the workflow local and auditable.

Best for:
- Turning a job description or hiring post into a tailored resume target.
- Selecting approved master-resume bullets deterministically.
- Preserving the existing LaTeX layout.
- Saving per-role `.tex`, report, job snapshot, and optional PDF outputs.
- Avoiding invented achievements, dates, technologies, or metrics.

### `linkedin-shortlist-resume-batch-tailoring`

Use when BrowserOS needs to turn a ranked opportunity shortlist into one tailored resume per opportunity.

Best for:
- Ingesting ranked LinkedIn or similar opportunity shortlists.
- Creating one target file per opportunity.
- Applying role-family presets before tailoring.
- Enforcing one-page output with compile/page-count checks.
- Running unsupported-fact audits across the batch.
- Producing job-to-resume mapping guides.
