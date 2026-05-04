---
name: search-state-verification-hygiene
description: Keep browser search workflows reliable by starting from clean state, applying one variable at a time, verifying URL/UI/result changes, and recording reliability notes.
metadata:
  display-name: Search State Verification Hygiene
  enabled: "true"
  version: "1.0"
---

# Skill: Search State Verification Hygiene

## Trigger

Use this skill before or during any browser-based search workflow where filters, tabs, date ranges, location settings, or hidden UI state can persist across runs.

## Purpose

Prevent stale filters and silent UI drift from corrupting search results. The agent must verify state after each change, keep runs reproducible, and avoid guessing whether a filter applied.

## Inputs

- `BASE_URL`: clean search URL or vertical URL.
- `QUERY`: intended search text.
- `INTENDED_FILTERS`: filter stack to apply.
- `EXPECTED_VERTICAL`: People, Posts, All, Companies, Google, or another target view.
- `RUN_MODE`: broad, precision, fallback, or validation.

## Outputs

- Clean-start confirmation.
- Step-by-step state verification.
- Final URL and filter stack.
- Reliability notes.
- Next-run reset instructions.

## Golden rules

1. Never trust carried-over filter state.
2. Start from a clean URL or visible reset action.
3. Apply one variable at a time.
4. Verify URL, visible UI state, and result delta after each change.
5. If UI chips behave inconsistently, switch to URL-lock mode.
6. Record reliability notes when state cannot be fully verified.

## Clean-start protocol

Before each run:

1. Open the clean base URL for the intended vertical.
2. Remove unrelated query parameters.
3. Click `Reset` if visible.
4. Confirm the query text matches the intended query.
5. Confirm the active vertical matches the intended vertical.
6. Confirm no old chips, date filters, company filters, or locations remain.

## Verification protocol

After each query edit or filter click:

1. Name the expected state change.
2. Check for a visible UI indicator such as a chip, tab, or selected filter.
3. Check whether the URL changed as expected.
4. Check whether the result set visibly changed.
5. Continue only if at least two of those signals confirm the change.
6. If confirmation fails, retry once, then use URL-lock mode or reset.

## URL-lock mode

Use URL-lock mode when UI chips are inconsistent, slow, or unclear.

1. Build the intended URL directly.
2. Open it in the browser.
3. Confirm the page loads into the correct vertical.
4. Confirm the expected filters are visible or reflected in the URL.
5. Continue from that state instead of relying on clicks.

## Filter layering model

Use light-to-heavy layering:

1. Base query.
2. High-signal vertical, such as People or Posts.
3. Recency or connection filter.
4. Location filter.
5. Company or domain filter.
6. Full filters or advanced modal only at the end.

## Click-budget discipline

- Fast run: 3-5 actions after page load.
- Targeted run: 5-8 actions.
- Strict shortlist: 8-12 actions.
- If a run exceeds the budget, stop and assess whether the workflow is over-filtered or using the wrong entry mode.

## Failure handling

- No visible result change: retry once, then URL-lock or reset.
- Result volume collapses: remove the last filter first.
- Old chips reappear: restart from clean URL.
- Wrong vertical appears: switch vertical immediately or use direct vertical URL.
- Multiple changes were made at once: roll back and rerun one variable at a time.

## Output schema

```text
Run intent:
Clean base URL:
Expected vertical:
Query:
Filter stack:
Step verification notes:
Final URL:
Reliability notes:
Reset needed before next run:
```

## Anti-patterns

- Reusing a browser session without checking old filters.
- Treating a click as successful without visible or URL confirmation.
- Debugging relevance while hidden filters are active.
- Changing query, date, location, and company in one step.
- Trusting Google recency or LinkedIn date filters without checking visible date evidence.
