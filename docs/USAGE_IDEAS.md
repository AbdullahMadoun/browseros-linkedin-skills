# Usage Ideas and Skill Chains

These are practical ways to combine the skills. The point is to load only the skill needed for the current phase, not every skill at once.

## 1. Best Order for Outreach Sheet Operations

Use this when the user wants to backfill LinkedIn messages, manage replies, and keep a Google Sheet as the operating table.

1. `linkedin-outreach-sheet-workflow`
2. `linkedin-inbox-preview-backfill`
3. `linkedin-row-enrichment`
4. `linkedin-outreach-daily-ops`
5. `google-sheets-connector-reliability` whenever needed

How to use:
- Start with the master workflow to create or inspect the workbook structure.
- Use preview backfill to populate rows quickly from the inbox list.
- Enrich only the highest-priority rows after the table is usable.
- Switch to daily ops after the first import.
- Apply Sheets reliability rules any time writes are partial, slow, timing out, or returning service errors.

## 2. Fast People Shortlist

Use this when the user says something like "find product managers in Riyadh" or "make me a shortlist of second-degree recruiters."

1. `search-state-verification-hygiene`
2. `linkedin-people-url-filtering`
3. `linkedin-boolean-query-refinement`
4. `lead-scoring-dedup-pivots`

How to use:
- Clean the search state first so old chips and filters do not poison results.
- Open a direct People URL instead of starting in mixed results.
- Apply second-degree and location filters before advanced filters.
- If results are noisy, refine the query with Boolean role/title variants.
- Score and deduplicate the final shortlist.

## 3. KSA Hiring Posts With Direct Contact Routes

Use this when the user wants fresh Saudi hiring posts, preferably with email or a clear CTA.

1. `search-state-verification-hygiene`
2. `linkedin-ksa-recent-hiring-posts`
3. `lead-scoring-dedup-pivots`

How to use:
- Start clean in LinkedIn Posts search.
- Run broad high-yield KSA hiring queries first.
- Run role-targeted queries after signal is proven.
- Mirror with Arabic queries if English results are sparse.
- Use Google X-ray only when LinkedIn ranking or UI quality is weak.
- Score posts by freshness, role match, KSA evidence, contact clarity, and poster credibility.

## 4. Noisy LinkedIn Search Rescue

Use this when search results are irrelevant, stale, over-filtered, or clearly affected by hidden state.

1. `search-state-verification-hygiene`
2. `linkedin-boolean-query-refinement`
3. `linkedin-people-url-filtering` or `linkedin-ksa-recent-hiring-posts`
4. `lead-scoring-dedup-pivots`

How to use:
- Reset to a clean URL or visible reset state.
- Change one thing per pass.
- Confirm URL, UI chip, and result-set changes.
- Add OR title variants before adding many filters.
- Add NOT exclusions for repeated irrelevant personas.

## 5. Message a Shortlist

Use this after a shortlist already exists and the user wants to send messages.

1. `linkedin-messaging-workflow`
2. `linkedin-attach-document-workflow` only if a file is needed
3. `google-sheets-connector-reliability` if the outreach sheet must be updated
4. `linkedin-outreach-daily-ops` for next-day follow-up tracking

How to use:
- Open the correct thread and verify the recipient.
- Fill the approved message.
- Send via the verified send path.
- Verify the message appears in the thread.
- If attaching a document, verify the attachment is staged before sending and the document card appears after sending.
- Update the sheet in small verified batches.

## 6. Connect With Target People First

Use this when the user wants to build a warmer LinkedIn network before messaging.

1. `linkedin-people-url-filtering`
2. `linkedin-boolean-query-refinement`
3. `lead-scoring-dedup-pivots`
4. `linkedin-connection-workflow`

How to use:
- Build a targeted People shortlist.
- Score and deduplicate before sending requests.
- Open each profile directly.
- Use profile Connect/Invite, then Send without a note unless the note flow is verified live.
- Verify profile state after sending.

## 7. Backfill First, Then Search for New Leads

Use this when the user already has LinkedIn conversations and wants both historical cleanup and future lead discovery.

1. `linkedin-outreach-sheet-workflow`
2. `linkedin-inbox-preview-backfill`
3. `linkedin-row-enrichment`
4. `search-state-verification-hygiene`
5. `linkedin-people-url-filtering`
6. `linkedin-boolean-query-refinement`
7. `lead-scoring-dedup-pivots`
8. `linkedin-outreach-daily-ops`

How to use:
- Build the sheet from existing conversations first.
- Enrich strategic rows.
- Then search for new people using clean search workflows.
- Add new leads to the same operating table.
- Move to a daily delta loop.

## 8. When to Stop

Stop a run when:
- Search state cannot be verified after one retry.
- Result volume collapses after a new filter.
- LinkedIn UI becomes inconsistent and URL-lock mode does not stabilize it.
- Google Sheets writes become partial and patching is cheaper than expanding.
- A thread/profile was already handled successfully in the same run.
- Lead quality drops below the scoring threshold.

## 9. What to Record After Each Run

For search runs:
- Query.
- Entry mode.
- Filter stack.
- Final URL.
- Top-result relevance.
- Reliability notes.
- Scored shortlist and dedupe decisions.

For outreach runs:
- Import run ID.
- Rows added.
- Rows updated.
- Rows skipped.
- Confidence summary.
- Follow-up queue changes.
- Connector reliability notes.
