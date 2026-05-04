---
name: gmail-web-fallback-workflow
description: >-
  Use Gmail web only for Gmail workflows the connector does not support or
  handles weakly, including outgoing local attachments, scheduled send,
  cancel scheduled send, editing/sending existing drafts, discarding drafts,
  label creation/rename/delete, visual formatting, signatures, filters, and
  settings. Prefer Gmail connector actions first for search, read, simple
  drafts/sends, replies, labels on messages, archive, read/unread, contacts,
  and received attachments.
metadata:
  display-name: Gmail Web Fallback Workflow
  enabled: "true"
  version: "1.0"
---

# Gmail Web Fallback Workflow

## Purpose

Use Gmail web only for Gmail workflows the connector does not support or handles weakly:

- outgoing local attachments
- scheduled send
- cancel scheduled send
- editing/sending existing drafts
- discard/delete existing drafts from UI
- label creation/rename/delete
- visual formatting, signatures, filters, and settings

This workflow was learned from live Gmail web testing after connector limitations were confirmed. Tested paths include local attachment self-send, connector-created draft editing/sending, scheduled self-email creation/verification/cancel/discard, and label create/rename/delete through Gmail settings. Keep public notes generic; do not include account names, personal email addresses, message content, or local machine paths.

## Safety posture

- Connector first for supported operations; use `gmail-connector-reliability-workflow` before web fallback.
- Web fallback only for unsupported connector areas.
- For any real external recipient, prepare and verify; stop before final send unless the user explicitly approved sending.
- For tests, use a user-approved test account and unique BrowserOS markers.
- For cleanup, only touch messages, labels, and drafts with BrowserOS test markers.
- Never type credentials into pages navigated to by yourself; use the existing logged-in Gmail tab/session.
- Treat recipients, subjects, body text, attachments, labels, thread IDs, and draft contents as sensitive.

## Known connector gaps requiring web fallback

- outgoing local file attachments
- scheduled send
- cancel scheduled send
- edit existing draft
- send existing draft
- discard/delete existing draft from UI
- create labels
- rename labels
- delete labels
- visual formatting, signatures, filters, settings

## General Gmail web reliability rules

1. Always start from a loaded Gmail tab.
2. Take a snapshot before clicking/filling.
3. If Gmail search text is stale, clear it before using compose/search.
4. Prefer visible element IDs from snapshots; use click coordinates only for Gmail controls that snapshots miss.
5. After opening Compose, verify the compose dialog exists before filling.
6. After filling recipient, ensure Gmail converts it into a recipient chip; raw combobox text may not count as a recipient.
7. For self-tests, click the autocomplete suggestion if Gmail shows it.
8. Verify attachment cards/chips before sending.
9. For scheduled send, verify the message appears in Scheduled, then cancel if it is a test.
10. For labels, Manage labels settings page is more reliable than the sidebar three-dot menu.

## Outgoing attachment workflow

Use when the user needs to send a local file from Gmail.

Use a user-provided file path or a harmless workspace test file, for example:

```text
<workspace>/browseros-gmail-web-test.txt
```

Workflow:

```text
1. Open Gmail web in the existing logged-in tab.
2. Click Compose.
3. Fill recipient.
4. If Gmail autocomplete appears, click the correct recipient suggestion.
5. Fill subject.
6. Fill body.
7. Click Attach files.
8. Upload the local file path with upload_file if the file input is exposed.
9. If the file input is hidden, expose/use the hidden input only when explicitly needed for upload.
10. Wait until the attachment chip/card is visible and no upload progress remains.
11. Verify filename in compose.
12. Send only if user approved, otherwise stop at verified draft.
13. After sending a self-test, verify the email appears with `has:attachment` in Inbox/Sent/search.
```

Observed result:

- Gmail web attachment self-send worked.
- The received self-email showed `has:attachment` in Inbox.
- The filename marker was visible in the test message context.

Failure recovery:

- If recipient error appears, recipient was not converted to a chip. Re-enter recipient and select autocomplete.
- If upload does not start, click Attach files again or locate hidden file input.
- If upload card remains in progress, do not send.
- If send button is disabled, verify recipient chip, subject/body, and attachment upload completion.

## Scheduled send workflow

Use for Gmail scheduled send because the connector does not support scheduling.

Workflow:

```text
1. Compose the message.
2. Verify recipient chip exists.
3. Fill subject and body.
4. Click the small More send options arrow next to Send.
5. Click Schedule send.
6. Choose a preset time or Pick date & time.
7. Verify the Scheduled label count increases or the message appears under Scheduled.
8. For test messages, open Scheduled and cancel before send time.
```

Tested path:

```text
Compose self-email -> More send options -> Schedule send -> choose preset -> verify Scheduled shows the message -> open message -> Cancel send -> discard draft -> verify Scheduled is empty
```

Important detail:

- If Gmail says "Please specify at least one recipient," the address text is not enough; select the contact/autocomplete so it becomes a recipient chip.

Cancel scheduled send:

```text
1. Open Scheduled.
2. Open the scheduled message.
3. Click Cancel send.
4. Gmail returns it to a draft compose window.
5. For disposable tests, click Discard draft.
6. Verify Scheduled is empty or the specific marker is gone.
```

## Existing draft edit/send workflow

Use when a draft was created by the Gmail connector or already exists in Gmail.

Why web fallback is required:

- Connector can create drafts but cannot update, send, or delete existing drafts.

Workflow:

```text
1. Use connector to create a draft when possible.
2. Add a unique marker to body/subject.
3. In Gmail web, open Drafts.
4. Find the draft by subject/marker.
5. Open it.
6. Edit subject/body as needed.
7. Verify Gmail autosaves or the edited content remains visible.
8. If approved, click Send.
9. Verify the message appears in Inbox/Sent/search if sent to self, or Sent for external recipients.
10. If not sending, close/save as draft or discard only when user approves.
```

Tested result:

- A connector-created draft was opened in Gmail web.
- Subject/body were edited in Gmail web.
- The edited draft was sent to self.
- The resulting self-email appeared in Inbox with edited marker.

Failure recovery:

- If Drafts count does not update immediately, refresh or search `in:drafts UNIQUE_MARKER`.
- If clicking a draft does not open compose, use search result open or Gmail URL state.
- If the compose closes unexpectedly, reopen Drafts and verify autosave.

## Label management workflow

Use Gmail web settings for label create/rename/delete. The settings page is more reliable than the sidebar label three-dot menu.

Create label:

```text
1. In the left sidebar, click More/Less as needed.
2. Click Create new label, or go to Manage labels -> Labels tab -> Create new label.
3. Enter unique label name.
4. Confirm Create.
5. Verify the label appears in the left Labels section and in Settings -> Labels.
```

Rename label:

```text
1. Click Manage labels.
2. On the Labels tab, find the exact custom test label row.
3. In that row, click edit.
4. Enter new label name.
5. Click Save or press Enter if the Save click does not immediately commit.
6. Verify the renamed label appears in sidebar/settings.
```

Delete label:

```text
1. Click Manage labels.
2. Find the exact custom label row.
3. Click remove in that row.
4. Confirm Delete in the Remove label dialog.
5. If the Delete click appears not to commit, press Enter while the dialog is focused.
6. Verify the label disappears from sidebar/settings.
```

Important label UI notes:

- Sidebar three-dot menu may be hard to activate via accessibility snapshots.
- `Manage labels` -> `Labels` tab exposes reliable `edit` and `remove` links with row context.
- Removing a label does not delete messages with that label.

## Recommended test markers

Use exact body markers, not only subject prefixes:

```text
BROWSEROS_GMAIL_WEB_ATTACHMENT_TEST_YYYYMMDD
BROWSEROS_GMAIL_WEB_SCHEDULE_TEST_YYYYMMDD
BROWSEROS_GMAIL_WEB_DRAFT_EDIT_TEST_YYYYMMDD
BrowserOS_Gmail_Web_Label_Test_YYYYMMDD
```

## Cleanup checklist

After web tests:

```text
1. Scheduled: verify no BrowserOS scheduled messages remain.
2. Drafts: discard disposable BrowserOS drafts.
3. Labels: remove BrowserOS test labels.
4. Emails: use Gmail connector TRASH label fallback for BrowserOS test messages.
5. Verify with exact marker search.
```

## Final web fallback decision tree

```text
Need search/read/send simple email/reply/mark/archive/Trash cleanup/contact lookup/received attachment extraction?
  -> Gmail connector reliability workflow.
Need outgoing local attachment?
  -> Gmail web fallback attachment workflow.
Need scheduled send/cancel scheduled send?
  -> Gmail web fallback scheduled send workflow.
Need edit/send an existing draft?
  -> Gmail web fallback draft workflow.
Need create/rename/delete labels?
  -> Gmail web fallback label workflow.
```
