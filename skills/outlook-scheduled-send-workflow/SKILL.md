---
name: outlook-scheduled-send-workflow
description: >-
  Schedule Outlook emails reliably, especially when drafts were created with the
  Outlook Mail connector and may include local attachments staged in Outlook web.
metadata:
  display-name: Outlook Scheduled Send Workflow
  enabled: "true"
  version: "1.1"
---

# Outlook Scheduled Send Workflow

## Purpose
Use this when the user asks to schedule, delay delivery, or send later from Outlook.

This skill is especially relevant when:
- Outlook Mail is connected
- draft content can be created quickly through the connector
- the final action must be Outlook web schedule-send
- local attachments must be preserved and verified

## Action discovery rule
The source Outlook Mail connector action set did not expose schedule-send / delayed-delivery.

Before assuming that limitation still applies, inspect the currently exposed Outlook Mail actions when tools are available. If a native schedule-send action exists, use it only after verifying the parameters and scheduled state. Otherwise:
- use connector actions for draft creation, updates, reading, deleting obsolete drafts, and verification
- use Outlook web for the final schedule-send UI action

## Privacy and safety
- Treat recipients, subjects, body text, attachment filenames, email addresses, and message IDs as sensitive.
- Use redacted labels in chat summaries unless the user asks for exact details.
- Do not paste full email bodies or private attachment names into logs.
- Confirm absolute date, time, and timezone before scheduling if the request is relative or ambiguous.
- For sensitive attachments, confirm the exact file path and recipient before upload or scheduling.

## Reliable flow
1. Resolve recipients, subject, body, schedule time, timezone, and attachment path if any.
2. Create or update the draft through the Outlook Mail connector.
3. If a local attachment is needed, open the exact draft in Outlook web and attach the file there.
4. Verify the exact attachment filename is visible before scheduling.
5. Prefer pop-out compose for schedule-send, especially after any embedded compose error.
6. Use Outlook web's `More send options` -> `Schedule send`.
7. Choose the target time.
8. Confirm the schedule by clicking `Send` in the schedule-send dialog.
9. Verify the scheduled state from Outlook web.

## Time handling
- Outlook web displays the mailbox/browser-local schedule UI.
- If the user specifies a timezone, convert only when the Outlook UI is showing a different timezone.
- If the user says today, tomorrow, or another relative date, resolve it to an exact calendar date before scheduling.
- Always report the scheduled time back with timezone wording.

## Dialog behavior learned
Outlook's schedule dialog can behave in two phases:
1. Select `Custom time`, set date/time, then click `Send`.
2. Outlook may return to suggested times and add a row like `Last chosen time`.

If that happens:
- select the `Last chosen time` row
- then click `Send` again

Do not assume the first click completed the schedule until verification shows the message is scheduled.

## Embedded compose failure recovery
If Outlook shows:

`There was a problem sending this message. Please try again later.`

Then:
1. Dismiss the error.
2. Use `Pop Out` to open the draft in its own compose tab/window.
3. Retry `More send options` -> `Schedule send` there.
4. Use the `Last chosen time` shortcut if it appears.
5. Verify success by looking for `Cancel send`.

Pop-out compose was more reliable than the embedded compose pane for schedule-send with attachments in the source environment.

## Success verification
A scheduled Outlook message should show:
- a `Cancel send` button in the message view
- the correct recipient
- the correct subject
- the exact attachment filename if attached

For attachment-bearing scheduled emails, do not stop at `hasAttachments: true` alone. Also verify the UI shows the exact filename.

## Wrong attachment recovery
If the wrong attachment is already staged and the message is not sent/scheduled:
- Prefer creating a clean replacement draft via connector.
- Attach the correct file to the replacement draft.
- Verify the exact filename.
- Delete the wrong obsolete draft with `outlookMail_delete_draft`.

This is safer than relying on Outlook attachment removal when the attachment preview/UI appears sticky or cached.

## Do not do
- Do not use connector `send_draft` for scheduled send; it sends immediately.
- Do not schedule until attachment staging is visibly verified.
- Do not assume a schedule succeeded just because the modal disappeared.
- Do not retry many times in embedded compose after the same Outlook error; pop out instead.
