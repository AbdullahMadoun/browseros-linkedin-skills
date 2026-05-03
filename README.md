# BrowserOS LinkedIn Skills

Reusable BrowserOS skills for LinkedIn search, lead discovery, outreach tracking, messaging, Outlook mail actions, document attachment, Google Sheets reliability, and local resume tailoring.

This repository merges several BrowserOS skill sources:

- LinkedIn outreach and Google Sheets operating skills created from local BrowserOS sessions.
- Search-agent skills from an archived BrowserOS search-agent package.
- Local BrowserOS refinements, including a candidate-fit KSA hiring search update, Outlook mail workflows, and local resume tailoring.

No source skill was intentionally removed during the merge. The archived search skills were kept with their supporting files and normalized by adding BrowserOS-style `SKILL.md` front matter.

This repo tracks the custom top-level BrowserOS skills. Nested BrowserOS default skills under `builtin/` are not vendored here.

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
│   ├── linkedin-shortlist-resume-batch-tailoring/
│   ├── local-latex-resume-tailoring/
│   ├── outlook-connector-draft-attach-send/
│   ├── outlook-mail-connector-reliability/
│   ├── outlook-scheduled-send-workflow/
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
  Finds recent Saudi Arabia hiring posts on LinkedIn using LinkedIn-first post search, candidate-to-role cluster mapping, English/Arabic query ladders, freshness filters, direct-contact scoring, and Google X-ray fallback only after LinkedIn-native recovery.

- `lead-scoring-dedup-pivots`  
  Scores raw posts/profiles/companies, removes duplicates, decides what to keep, and creates pivot plans from strong signals.

### Outreach Tracking and Operations

Use these when BrowserOS is managing LinkedIn outreach in a Google Sheet.

- `linkedin-outreach-sheet-workflow`  
  Simple one-sheet operating model for LinkedIn outreach using one `Outreach` tab, one row per person, stable stages, next actions, and connector-first updates.

- `linkedin-inbox-preview-backfill`  
  Fast first-pass import from LinkedIn inbox preview rows into a Google Sheet without opening every thread.

- `linkedin-row-enrichment`  
  Opens only selected high-value threads or profiles to fill LinkedIn URL, title, company, action context, and more reliable fields without storing message transcripts.

- `linkedin-outreach-daily-ops`  
  Daily delta loop for scanning changed threads, updating reply/follow-up state, and maintaining queue actions.

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

### Outlook Mail Actions

Use these when BrowserOS is drafting, attaching, sending, scheduling, or verifying Outlook emails.

- `outlook-mail-connector-reliability`
  Connector-first rules for Outlook draft creation, updates, sending, and verification, with browser fallback only for verified connector gaps.

- `outlook-connector-draft-attach-send`
  Creates Outlook drafts through the connector, attaches local files in Outlook web, verifies staged attachments, and sends safely.

- `outlook-scheduled-send-workflow`
  Schedules Outlook emails through the web UI when connector schedule-send support is unavailable, with explicit time and attachment verification.

### Job Application Support

Use these after a promising role, recruiter post, or company target is found.

- `local-latex-resume-tailoring`
  Tailors a resume fully locally using approved master resume data, deterministic content selection, local LaTeX output, and optional local PDF compilation.

- `linkedin-shortlist-resume-batch-tailoring`
  Turns a ranked shortlist of opportunities into one truthful resume per opportunity, with one-page checks, unsupported-fact audits, and mapping guides.

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

### Turn a lead into a tailored resume

1. `linkedin-ksa-recent-hiring-posts` or `linkedin-people-url-filtering`
2. `lead-scoring-dedup-pivots`
3. `local-latex-resume-tailoring`

### Tailor a ranked shortlist into resumes

1. `lead-scoring-dedup-pivots`
2. `linkedin-shortlist-resume-batch-tailoring`
3. `local-latex-resume-tailoring` for individual high-priority roles that need deeper local tailoring

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

### Draft, attach, send, or schedule Outlook email

1. `outlook-mail-connector-reliability`
2. `outlook-connector-draft-attach-send` when a local file must be attached
3. `outlook-scheduled-send-workflow` when the email must be sent later

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
https://github.com/<your-github-user>/browseros-linkedin-skills
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
