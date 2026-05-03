# Skills Directory

Each subdirectory is a BrowserOS skill package. The primary entry point is always `SKILL.md`.

## Included Skills

| Skill | Category | Use |
|---|---|---|
| `search-state-verification-hygiene` | Search hygiene | Clean start, verify filters, avoid stale search state |
| `linkedin-people-url-filtering` | Search | Direct LinkedIn People URL workflows |
| `linkedin-boolean-query-refinement` | Search | Boolean role/title query refinement |
| `linkedin-ksa-recent-hiring-posts` | Search | Fresh KSA hiring-post discovery |
| `lead-scoring-dedup-pivots` | Lead processing | Score, dedupe, and pivot from raw leads |
| `local-latex-resume-tailoring` | Job application support | Tailor a resume locally with LaTeX outputs |
| `linkedin-shortlist-resume-batch-tailoring` | Job application support | Batch-tailor one resume per ranked opportunity |
| `linkedin-outreach-sheet-workflow` | Outreach ops | Master LinkedIn + Google Sheets workflow |
| `linkedin-inbox-preview-backfill` | Outreach ops | Fast inbox-preview sheet import |
| `linkedin-row-enrichment` | Outreach ops | Enrich selected rows from profiles/threads |
| `linkedin-outreach-daily-ops` | Outreach ops | Daily delta monitoring and queue updates |
| `google-sheets-connector-reliability` | Reliability | Recover from partial, flaky, or timed-out Sheets writes |
| `linkedin-messaging-workflow` | Direct action | Send LinkedIn messages and verify delivery |
| `linkedin-attach-document-workflow` | Direct action | Attach and send local documents in LinkedIn threads |
| `linkedin-connection-workflow` | Direct action | Send profile-based connection invites |
| `outlook-mail-connector-reliability` | Outlook mail | Connector-first Outlook mail drafting, sending, and verification |
| `outlook-connector-draft-attach-send` | Outlook mail | Attach local files to connector-created Outlook drafts |
| `outlook-scheduled-send-workflow` | Outlook mail | Schedule Outlook emails and verify scheduled state |

## Package Rules

- Keep one skill per folder.
- Keep `SKILL.md` at the folder root.
- Preserve supporting files when they exist.
- Do not delete or overwrite another skill without documenting the merge decision.
