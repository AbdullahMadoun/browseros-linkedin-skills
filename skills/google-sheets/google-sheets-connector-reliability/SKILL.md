---
name: google-sheets-connector-reliability
description: >-
  Keep Google Sheets operations simple: connector first, read headers before
  writing, use small verified row updates, avoid sheet sprawl, and fall back to
  browser editing only for tiny urgent edits.
metadata:
  display-name: Google Sheets Connector Reliability
  enabled: "true"
  version: "1.2"
---

# Google Sheets Connector Reliability

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this only as a lightweight reliability guard for Google Sheets. It should not become a full spreadsheet framework.

## Rules

- Use the Google Sheets connector first.
- Read headers and touched rows before writing.
- Write small logical batches, usually 1-10 rows.
- Re-read changed rows after non-trivial writes.
- Patch only cells that failed to land.
- Keep the existing sheet schema unless the user explicitly asks to change it.
- Prefer blank cells over noisy placeholders.
- Do not create staging, temp, log, backup, or import sheets just because a write is slow.

## Fast Path

```text
list/get spreadsheet -> read header + target range -> write smallest batch -> read back changed cells
```

Never open the Sheets web UI just to inspect headers, append rows, or verify a
small connector write.

## Failure Handling

If a write fails, 503s, or times out:

1. Do not rerun the whole batch blindly.
2. Read back the affected range.
3. Test one small write if state is unclear.
4. Continue with smaller batches only after verification.
5. Stop and report uncertainty if repeated failures make the sheet state ambiguous.

## Browser Fallback

Use browser editing only when the connector is unavailable or unstable, the edit is urgent, and the scope is small enough to verify visually.

When falling back, edit only the urgent cells and avoid schema changes.

## Output

Report:

```text
Sheet/range:
Rows changed:
Verification:
Partial failures:
Fallback used:
```
