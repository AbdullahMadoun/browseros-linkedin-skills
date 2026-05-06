---
name: outlook-mail-connector-reliability
description: >-
  Use the Outlook Mail connector first for draft creation, updates, sending, and
  verification, with action discovery and narrow browser fallback only when true
  attachments or schedule-send behavior require Outlook web.
metadata:
  display-name: Outlook Mail Connector Reliability
  enabled: "true"
  version: "1.1"
---

# Outlook Mail Connector Reliability

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Provide a simple reliable pattern for Outlook email work using the Outlook Mail connector.

Use this skill whenever Outlook Mail is connected and the user wants fast, low-friction email drafting, sending, or verification.

## Default rule
Because Outlook Mail is connected, use the connector first.

Do not default to browser composition unless:
- a real local file attachment is required
- the connector is missing the needed action
- browser state must be inspected for final verification

## Action discovery rule
Before relying on a limitation, inspect the currently exposed Outlook Mail actions when tools are available.

Connector actions commonly used by this workflow include:
- `outlookMail_create_draft`
- `outlookMail_update_draft`
- `outlookMail_send_draft`
- `outlookMail_list_messages`
- `outlookMail_list_messages_from_folder`
- `outlookMail_read_message`
- `outlookMail_list_folders`
- `outlookMail_delete_draft`
- `outlookMail_create_forward_draft`
- `outlookMail_create_reply_draft`
- `outlookMail_create_reply_all_draft`
- `outlookMail_move_message`

If discovery exposes a native attachment or schedule-send action, prefer the native action only after verifying its parameters and result state. If discovery still shows no such action, use the browser fallback rules below.

## Privacy and safety
- Treat recipients, subjects, body text, attachment filenames, email addresses, and message IDs as sensitive.
- In chat summaries, use short redacted labels unless the user asks for exact details.
- Do not paste full email bodies or private attachment names into logs.
- For sensitive files such as resumes, contracts, IDs, offer letters, or financial documents, confirm the exact absolute file path and recipient before upload or send.
- If the user asks for scheduling, report the final date, time, and timezone explicitly.

## Known limitations
Attachment upload or add-attachment support may not be exposed in the current Outlook Mail connector action set.

Schedule-send / delayed-delivery support may not be exposed in the current Outlook Mail connector action set.

That means:
- plain immediate-send emails can stay fully connector-based
- emails requiring true local file attachments need browser help for the attachment step unless a native attachment action is discovered
- scheduled emails need Outlook web for the final schedule-send step unless a native schedule action is discovered

## Simple reliable flow
1. Create draft with connector.
2. Update draft with connector until subject, body, and recipients are correct.
3. If no attachment or schedule-send gap applies, send with connector.
4. Verify the sent message using connector reads.
5. Fall back to browser only when the connector cannot complete the required behavior.

## Draft creation rule
Prefer draft-first over direct composition in the browser.

When creating a draft, capture at least:
- message ID
- subject
- recipients
- `isDraft`
- `hasAttachments`
- `webLink` when present

## Update rule
Use `outlookMail_update_draft` for:
- subject edits
- body edits
- recipient corrections
- final cleanup before send

Do not bounce between browser and connector unnecessarily.
Finish as much of the content work as possible in the connector first.

## Send rule
If the email has no local attachment requirement and no schedule-send requirement:
- use `outlookMail_send_draft`
- verify success from the returned result
- then verify presence in Sent Items

If the email has a true local attachment requirement:
- stop before connector send
- switch to the hybrid Outlook attachment workflow
- send from the browser after staging and verifying the attachment

If the email has a schedule-send requirement:
- stop before connector send
- switch to the Outlook scheduled-send workflow
- verify the scheduled state in Outlook web

## Sent Items verification rule
Folder names may be localized, so do not hardcode the English folder label.

Use this pattern:
1. `outlookMail_list_folders`
2. Identify the Sent Items folder by meaning, not only by English text
3. `outlookMail_list_messages_from_folder` on that folder
4. Narrow output fields to message ID, subject, recipient, send time, draft state, and attachment state
5. Confirm the expected message appears

## Filter discipline
Avoid overcomplicated folder queries.

Known issue from testing:
- combining some exact filters with sort options can produce `InefficientFilter`

Reliable fallback:
- request a small recent slice with `top`
- use a narrow `select`
- inspect the newest results for subject, recipient, and send time
- then use `outlookMail_read_message` if deeper confirmation is needed

## Output discipline
Prefer small targeted responses.

When executing connector actions:
- use narrow `include_output_fields`
- keep `maximum_output_characters` modest
- fetch more only if verification actually needs it

## Scheduled send rule
If the user wants scheduled send / delayed delivery:
- use the connector for draft creation and content edits first
- use Outlook web for the schedule-send UI unless a native schedule action is discovered and verified
- verify the scheduled state in Outlook web when browser scheduling is used
- success indicator: the scheduled message view shows `Cancel send`
- if embedded compose errors with `There was a problem sending this message. Please try again later.`, pop out the draft and retry schedule-send in the dedicated compose window

## Attachment correction rule
If a wrong file is already attached and the message is not sent/scheduled:
- safest recovery is often to create a clean replacement draft, attach the right file, verify it, then delete the old wrong draft with `outlookMail_delete_draft`
- this avoids Outlook attachment preview/removal caching issues

## Good connector use
Good:
- create draft
- update draft
- send draft when no attachment/schedule gap applies
- delete wrong obsolete drafts after clean replacements
- verify sent or scheduled message state
- read specific message

Bad:
- using browser compose for ordinary no-attachment mail
- re-sending because verification was weak
- relying on giant unfiltered mailbox reads
- assuming attachment support exists without action discovery
- assuming schedule-send support exists without action discovery

## When browser fallback is justified
Use browser fallback only when all of these are true:
- the required outcome cannot be completed by the connector alone
- the scope is narrow and easy to verify
- the browser step adds real capability, not just habit

Typical justified cases:
- local file attachment inside Outlook web
- scheduled send / delayed delivery inside Outlook web
- final verification of a scheduled message showing `Cancel send`

## Best outcome
A workflow that:
- drafts quickly through the connector
- sends cleanly through the connector when possible
- switches to browser only for true attachment or schedule-send gaps
- verifies sent or scheduled results without heavy mailbox querying
- avoids duplicated sends and noisy retries
