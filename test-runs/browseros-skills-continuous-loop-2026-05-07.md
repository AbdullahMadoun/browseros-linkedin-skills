# BrowserOS Skills Continuous Test/Edit Loop - 2026-05-07

## Goal

Make the edited BrowserOS skills faster, clearer, and safer for automation:

- fewer clicks before useful state
- direct URLs/connectors before fragile UI paths
- explicit stop boundaries
- output/verification expectations in every skill
- live learning promoted only when verified and public-safe

## Loop

```text
static audit -> live smoke -> patch narrow skill -> validate -> sync installed skills -> record run
```

## Static Audit

Checks run:

- `scripts/validate-browseros-skills.sh`
- `git diff --check`
- bundled reference existence
- installed bundled reference existence
- workflow/safety/output coverage scan over all 40 `SKILL.md` files
- line-count scan for hot-path bloat

Results:

- 40 skill frontmatters valid.
- Bundled references valid.
- Privacy scan clean.
- Whitespace diff clean.
- All 40 skills now expose workflow/fast path, stop/safety boundary, and
  output/verification language.

## Live Smoke Coverage

Automation-only tests; no submits, sends, uploads, profile edits, posts, or sheet
writes.

### Connector-First

- Google Sheets connector discovery returned spreadsheet, cell, and sheet
  categories.
- Confirmed connector discovery is faster than opening Sheets UI for action
  discovery.

### Greenhouse / Job Portal

- Greenhouse job detail exposed required fields, visible attach controls, hidden
  `input[type=file]`, React-style comboboxes, optional demographic fields, and
  final `Submit application`.
- Confirmed final submit may be enabled before required fields are complete.

### LinkedIn People URL Filtering

- Direct People URL with query, second-degree, and Riyadh geo filters loaded
  directly into People results.
- Confirmed URL-lock mode avoids the mixed `All` results detour.

### LinkedIn KSA Hiring Posts

- Direct Posts URL loaded with Past week filter.
- A strict query returned no results; fastest recovery is reopening a broader
  direct URL, not clicking LinkedIn edit-search UI first.

### LinkedIn Company Mapper

- MOZN company page exposed company details, posts, products, events, jobs, and
  people highlights in one page extraction.
- Full jobs search expansion remains the right path for coverage beyond the
  carousel.

## Skill Patches From This Loop

- `browseros-skill-router`: added fast route decision and direct evidence switch
  after first failed UI path.
- `connector-first-action-discovery`: added read/draft connector fast path.
- `browseros-new-site-learning-protocol`: added least-click discovery order.
- `browseros-skill-evolution-loop`: added continuous test/edit/sync loop and
  default avoidance of scanning all old runs.
- `google-sheets-connector-reliability`: added connector-only fast path.
- `job-portal-application-workflow`: added ATS fast path.
- `linkedin-easy-apply-application-workflow`: added foreground retry and updated
  statuses.
- `linkedin-ksa-recent-hiring-posts`: added direct no-results recovery.
- `linkedin-company-opportunity-mapper`: added content/links-first fast path.
- `linkedin-hiring-post-comment-miner`: added search-card/comment fast path.
- `linkedin-poster-workflow`: added foreground composer fast path.
- `linkedin-attach-document-workflow`: added explicit automation-test/upload/send
  safety boundary.
- `linkedin-messaging-workflow`: added explicit send safety boundary.
- `linkedin-people-url-filtering`: added stop conditions.
- `linkedin-boolean-query-refinement`: added stop conditions.
- `research-opportunity-finder`: added fast workflow and outreach/application
  safety boundary.
- `resume-applied-draft-review`: added stop conditions.

## Installed Runtime

Synced with:

```text
scripts/install-browseros-skills.sh --overwrite --prune
```

Installed checks passed:

- 40 installed custom skills.
- Installed bundled references present.

## Open Follow-Up Tests

- Ashby application form mechanics.
- Lever application form mechanics on a live open role.
- Workday login/account boundary mapping.
- LinkedIn Easy Apply screening-question step on a safe role, stopping before
  final submit.
- Direct LinkedIn `/feed/update/` permalink comment-mining workflow.
