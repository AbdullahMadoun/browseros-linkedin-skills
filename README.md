# BrowserOS LinkedIn Skills

Reusable BrowserOS skills for LinkedIn search, lead discovery, outreach tracking, messaging, document attachment, and Google Sheets reliability.

This repository merges two BrowserOS skill sets:

- LinkedIn outreach and Google Sheets operating skills created from local BrowserOS sessions.
- Search-agent skills from `D:\downloads\browseros-search-agent-skills.rar`.

No source skill was intentionally removed during the merge. The archived search skills were kept with their supporting files and normalized by adding BrowserOS-style `SKILL.md` front matter.

## Repository Layout

```text
browseros-linkedin-skills/
├── skills/
│   ├── google-sheets-connector-reliability/
│   ├── lead-scoring-dedup-pivots/
│   ├── linkedin-attach-document-workflow/
│   ├── linkedin-boolean-query-refinement/
│   ├── linkedin-connection-workflow/
│   ├── linkedin-inbox-preview-backfill/
│   ├── linkedin-ksa-recent-hiring-posts/
│   ├── linkedin-messaging-workflow/
│   ├── linkedin-outreach-daily-ops/
│   ├── linkedin-outreach-sheet-workflow/
│   ├── linkedin-people-url-filtering/
│   ├── linkedin-row-enrichment/
│   └── search-state-verification-hygiene/
├── docs/
│   ├── MERGE_NOTES.md
│   ├── SEARCH_AGENT_SOURCE_COVERAGE.md
│   ├── SKILL_CATALOG.md
│   └── USAGE_IDEAS.md
└── scripts/
    └── install-browseros-skills.ps1
```

## Skill Groups

### Search and Lead Discovery

Use these when BrowserOS needs to find relevant people, posts, hiring signals, or lead candidates.

- `search-state-verification-hygiene`  
  Starts every search from a clean state, verifies URL/UI/result changes, prevents stale filters, and keeps click budgets controlled.

- `linkedin-people-url-filtering`  
  Builds fast repeatable LinkedIn People searches using direct People URLs, clean query baselines, second-degree filters, location filters, company filters, and URL-lock fallback.

- `linkedin-boolean-query-refinement`  
  Improves noisy LinkedIn search results with Boolean title families, quoted exact phrases, NOT exclusions, and top-result relevance checks.

- `linkedin-ksa-recent-hiring-posts`  
  Finds recent Saudi Arabia hiring posts on LinkedIn using English/Arabic query lanes, freshness filters, direct-contact scoring, and Google X-ray fallback.

- `lead-scoring-dedup-pivots`  
  Scores raw posts/profiles/companies, removes duplicates, decides what to keep, and creates pivot plans from strong signals.

### Outreach Tracking and Operations

Use these when BrowserOS is managing LinkedIn outreach in a Google Sheet.

- `linkedin-outreach-sheet-workflow`  
  Master architecture for a traceable LinkedIn outreach system using LinkedIn browser automation plus Google Sheets as memory, queue, and audit trail.

- `linkedin-inbox-preview-backfill`  
  Fast first-pass import from LinkedIn inbox preview rows into a Google Sheet without opening every thread.

- `linkedin-row-enrichment`  
  Opens only selected high-value threads or profiles to fill LinkedIn URL, title, company, exact message context, and higher-confidence fields.

- `linkedin-outreach-daily-ops`  
  Daily delta loop for scanning changed threads, updating reply/follow-up state, maintaining queue actions, and logging runs.

- `google-sheets-connector-reliability`  
  Recovery and batching rules for flaky Google Sheets connector behavior, including partial-write verification and timeout/503 handling.

### Direct LinkedIn Actions

Use these for concrete LinkedIn UI actions.

- `linkedin-messaging-workflow`  
  Opens the correct LinkedIn thread, fills the message composer, sends with a reliable method, and verifies the outbound message appears.

- `linkedin-attach-document-workflow`  
  Attaches and sends a local document in a LinkedIn message thread by exposing LinkedIn's real file input when needed, uploading, sending, and verifying the document card.

- `linkedin-connection-workflow`  
  Sends LinkedIn connection requests from profile pages using the reliable no-note flow and verifies success from profile state.

## Recommended Usage Chains

### Search for LinkedIn people

1. `search-state-verification-hygiene`
2. `linkedin-people-url-filtering`
3. `linkedin-boolean-query-refinement`
4. `lead-scoring-dedup-pivots`

### Find recent KSA hiring posts

1. `search-state-verification-hygiene`
2. `linkedin-ksa-recent-hiring-posts`
3. `lead-scoring-dedup-pivots`

### Build an outreach tracker from LinkedIn messages

1. `linkedin-outreach-sheet-workflow`
2. `linkedin-inbox-preview-backfill`
3. `linkedin-row-enrichment`
4. `linkedin-outreach-daily-ops`
5. `google-sheets-connector-reliability` whenever Sheets writes are slow, flaky, partial, or returning 503/timeouts.

### Send messages and attachments

1. `linkedin-messaging-workflow`
2. `linkedin-attach-document-workflow` when a file must be sent
3. `google-sheets-connector-reliability` if the action also updates the outreach sheet

More detailed chain ideas are in [docs/USAGE_IDEAS.md](docs/USAGE_IDEAS.md).

## Installing into BrowserOS

From this repo:

```powershell
.\scripts\install-browseros-skills.ps1
```

By default the script copies only missing skills into:

```text
$env:USERPROFILE\.browseros\skills
```

It does not delete existing BrowserOS skills and does not overwrite existing skill directories unless you explicitly pass:

```powershell
.\scripts\install-browseros-skills.ps1 -Overwrite
```

## Pushing to GitHub

The repo is configured for:

```text
https://github.com/AbdullahMadoun/browseros-linkedin-skills
```

Typical first push:

```powershell
git add .
git commit -m "Add BrowserOS LinkedIn skills suite"
git branch -M main
git push -u origin main
```

## Notes for Future Merges

- Add new skills under `skills/<skill-name>/`.
- Keep `SKILL.md` as the primary BrowserOS entry point.
- Preserve supporting files such as `manifest.json`, templates, scripts, and query packs.
- Do not delete or replace an existing skill without reviewing it and documenting the decision in `docs/MERGE_NOTES.md`.
