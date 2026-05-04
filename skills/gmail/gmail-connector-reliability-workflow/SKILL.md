---
name: gmail-connector-reliability-workflow
description: >-
  Use Gmail connector actions first for reliable Gmail search, thread reading,
  contact lookup, received attachment extraction, drafting, sending, threaded
  replies, label-based cleanup, archiving, marking read/unread, and Trash
  cleanup. Use Gmail web fallback only for connector gaps such as outgoing local
  attachments, scheduled send, existing draft edits/sends, visual formatting,
  label management, filters, settings, or signatures.
metadata:
  display-name: Gmail Connector Reliability Workflow
  enabled: "true"
  version: "1.0"
---

# Gmail Connector Reliability Workflow

## Purpose

Use the Gmail connector first for reliable Gmail operations:

- search
- read messages and threads
- contact lookup
- received attachment extraction
- drafting
- sending
- threaded replies
- label-based cleanup
- archiving and restore
- marking read/unread
- Trash cleanup

Use `gmail-web-fallback-workflow` only when the connector lacks the feature: outgoing local attachments, scheduled send, editing/sending existing drafts, visual compose editing, label creation/rename/delete, forwarding with original formatting, filters, settings, or signatures.

This workflow was learned from live Gmail testing with disposable self-sends, threaded replies, HTML/multipart email, draft creation, label modification, batch modification, archive/restore, contact lookup, failed permanent deletion, and Trash fallback. Keep future public notes generic; do not include account names, personal email addresses, message content, or local machine paths.

## Connector-first rule

Gmail is a connected app. Prefer the Gmail connector for supported operations because it is faster and less brittle than browser automation.

Supported connector actions observed/discovered:

- search emails
- read email/thread
- get received attachments
- search contacts
- create new draft
- send email
- modify labels on one email
- batch modify labels
- delete / batch delete, but tested blocked by insufficient permission

Unsupported/weak connector areas:

- outgoing local attachments
- scheduled send
- edit existing draft
- send existing draft
- delete draft directly
- list/create/rename/delete labels
- visual formatting/settings/signatures/filters

## Core principles

1. Search before read.
2. Read the full thread before replying.
3. Draft before send unless the user gave complete final send instructions.
4. Never guess recipient emails.
5. Verify side effects sequentially: act -> verify -> restore/continue -> verify.
6. Do not verify and rollback in parallel; this can create real races.
7. Prefer exact body markers for test/cleanup searches.
8. Treat Gmail threads carefully; modifying one message can affect thread-level search results.
9. Do not rely on permanent delete; use the `TRASH` label fallback.
10. For Workspace directory contacts, only use directory lookup if the account is known to be Workspace.
11. Treat recipient addresses, subjects, body text, attachments, labels, and thread IDs as sensitive.

## Search workflow

Use `gmail_search_emails` with narrow Gmail syntax.

Good queries:

```text
from:person@example.com
to:me
subject:invoice
has:attachment
newer_than:30d
older_than:90d
is:unread
in:inbox
in:drafts
in:trash
"exact phrase"
```

Best cleanup/test query:

```text
BROWSEROS_UNIQUE_MARKER
```

Avoid broad subject-only cleanup queries after label moves; exact body markers are more reliable.

## Read workflow

```text
gmail_search_emails -> choose messageId -> gmail_read_email
```

`gmail_read_email` returns thread context, including `threadId`, message count, and message bodies. For HTML/multipart messages, inspect `body.html` explicitly; `preferredFormat` may still say text/plain.

## Send new email

Only send directly when the user has provided recipient, subject, body, and explicit send approval.

Plain text:

```json
{
  "to": ["recipient@example.com"],
  "subject": "Subject",
  "body": "Body",
  "mimeType": "text/plain"
}
```

HTML/multipart:

```json
{
  "to": ["recipient@example.com"],
  "subject": "Subject",
  "body": "Plain text fallback",
  "htmlBody": "<p><strong>HTML</strong></p>",
  "mimeType": "multipart/alternative"
}
```

Tested result: HTML/multipart sent correctly; read returned both text and HTML bodies.

## Reply in-thread

```text
search original -> read thread -> send using threadId + inReplyTo -> read thread again -> verify message count increased
```

Payload pattern:

```json
{
  "to": ["recipient@example.com"],
  "subject": "Re: Subject",
  "body": "Reply body",
  "threadId": "THREAD_ID",
  "inReplyTo": "MESSAGE_ID",
  "mimeType": "text/plain"
}
```

Tested result: reply stayed in the original thread and message count increased.

## Draft email

Connector draft creation works:

```json
{
  "to": ["recipient@example.com"],
  "subject": "Subject",
  "body": "Body",
  "mimeType": "text/plain"
}
```

Important limitation:

- connector returns `draftId`
- search/read operate on a separate Gmail `messageId`
- connector does not expose update/send/delete existing draft

If the user needs to edit or send an existing draft, use `gmail-web-fallback-workflow`.

Cleanup workaround for disposable drafts:

```text
search in:drafts UNIQUE_MARKER -> get messageId -> gmail_modify_email addLabelIds:["TRASH"]
```

## Mark read/unread

Mark unread:

```json
{ "messageId": "MESSAGE_ID", "addLabelIds": ["UNREAD"] }
```

Mark read:

```json
{ "messageId": "MESSAGE_ID", "removeLabelIds": ["UNREAD"] }
```

Batch variant:

```json
{ "messageIds": ["id1", "id2"], "addLabelIds": ["UNREAD"], "batchSize": 50 }
```

Correct verification:

```text
modify -> search/verify -> restore if needed -> verify again
```

## Archive and restore

Archive by removing `INBOX`:

```json
{ "messageId": "MESSAGE_ID", "removeLabelIds": ["INBOX"] }
```

Restore by adding `INBOX`:

```json
{ "messageId": "MESSAGE_ID", "addLabelIds": ["INBOX"] }
```

Tested result: removing `INBOX` removed the message from inbox search; adding it restored it.

## Cleanup/delete

Permanent delete can fail with:

```text
Insufficient Permission
```

Do not depend on:

```text
gmail_delete_email
gmail_batch_delete_emails
```

Use Trash fallback:

```json
{ "messageId": "MESSAGE_ID", "addLabelIds": ["TRASH"] }
```

Batch cleanup:

```json
{ "messageIds": ["id1", "id2"], "addLabelIds": ["TRASH"], "batchSize": 50 }
```

Then verify:

```text
in:trash UNIQUE_MARKER
```

## Contact lookup

Recommended order:

```text
personal -> other -> dedupe by lowercased email -> directory only if Workspace is known
```

Avoid default/all when not Workspace; directory lookup can fail with:

```text
Must be a G Suite domain user
```

`other` can return duplicates; dedupe by email address.

## Received attachments

Workflow:

```text
gmail_search_emails query:"has:attachment KEYWORD" -> gmail_read_email -> gmail_get_email_attachments
```

No-attachment messages return a clean zero-attachment result.

## Failure recovery

- Delete permission failure -> use `TRASH` label.
- Directory contact failure -> skip directory and use personal/other.
- Empty verification after rollback -> check for parallel verification race; redo sequentially.
- Broad search gives odd results -> use exact marker.
- Thread search surfaces extra messages -> read thread and collect thread message IDs.

## Tested best default path

```text
1. Search narrowly.
2. Read full thread.
3. Draft unless explicit send approval exists.
4. For replies, use threadId + inReplyTo.
5. For HTML, include body + htmlBody + multipart/alternative.
6. For contacts, personal -> other -> dedupe.
7. For read/unread/archive, use labels.
8. For bulk actions, modify -> verify -> restore/continue sequentially.
9. For cleanup, add TRASH instead of permanent delete.
10. Use Gmail web fallback for attachments, scheduled send, draft editing/sending, and label management.
```
