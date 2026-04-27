---
name: google-sheets-connector-reliability
description: Keep Google Sheets writes reliable during outreach workflows by using safe batching, explicit placeholders, partial verification, and controlled recovery from timeouts or 503s.
metadata:
  display-name: Google Sheets Connector Reliability
  enabled: "true"
  version: "1.0"
---

# Google Sheets Connector Reliability

## Purpose
Make sheet writes resilient during LinkedIn outreach workflows.

This skill exists because the Google Sheets connector can become:
- slow
- partially successful
- timeout-prone
- intermittently unavailable

A reliable workflow must assume this sometimes happens.

## Core reliability rules
1. **Write in small logical batches**
2. **After failure, test one small write first**
3. **Verify partial success before retrying**
4. **Patch missing cells only**
5. **Never rerun an entire batch blindly**
6. **Use explicit placeholders instead of blank values when needed**

## Best batch design
Group writes by meaning, not by maximum size.

Good batch examples:
- one header block
- one row metadata block
- one import log row
- one group of 5 related cells

Bad batch examples:
- 50 unrelated cells across many tabs
- full-table rewrites
- mixed writes where one failure makes verification messy

## Connector-safe placeholders
Prefer explicit values like:
- `pending_enrichment`
- `TBD`
- `not_run`
- `preview_only`
- `needs_review`

Avoid true blanks when the connector behaves inconsistently.

## Recovery flow after failure
When a write fails or times out:
1. stop the big batch
2. test one tiny write
3. if it succeeds, continue in smaller batches
4. verify the target range
5. patch only missing cells
6. record notes if reliability affected confidence

## 503 handling
A 503 usually means the service is temporarily unavailable, not that the workbook is broken.

Do this:
- reduce write size
- wait briefly or switch tasks
- test a single write
- resume carefully

Do not do this:
- spam the same batch repeatedly
- assume nothing was written
- re-run the entire import

## Timeout handling
Timeouts are especially dangerous because the write may have partially succeeded.

Always:
- read back the affected range
- identify exactly what landed
- write only the missing cells

## Verification pattern
After any non-trivial or flaky batch:
1. read the target range
2. compare expected vs actual
3. patch only missing values

This pattern is mandatory for outreach workflows because duplicate or partial data corrupts trust.

## When to switch to browser fallback
If the connector becomes too unstable for important edits:
- keep the spreadsheet open in a background browser tab
- decide whether direct browser editing is worth it
- prefer waiting for connector recovery for structured updates
- use browser-side editing only as a last resort because it is slower and harder to audit

## Import log discipline
Even under connector instability, still maintain `Import_Log`.
If a run was partial, say so in notes.

Good note examples:
- `partial_write_patched`
- `connector_503_recovered`
- `row_headers_written_after_retry`
- `preview_rows_added_connector_unstable`

## Reliability-aware confidence rules
Do not reduce row confidence just because the connector glitched.
Confidence describes data certainty, not transport certainty.

But do add review notes if:
- some fields may not have landed
- a row may still be incomplete
- the write order was interrupted

## Best outcome
A workflow that survives connector instability without:
- duplicate rows
- missing audit trail
- blind rewrites
- operator confusion
- wasted retries
