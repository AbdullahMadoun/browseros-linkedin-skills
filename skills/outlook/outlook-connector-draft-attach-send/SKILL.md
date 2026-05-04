---
name: outlook-connector-draft-attach-send
description: >-
  Create Outlook draft emails through the Outlook Mail connector for speed, then
  open the exact draft in Outlook web, attach local files reliably, and send
  only after verifying the staged attachment.
metadata:
  display-name: Outlook Connector Draft Attach Send
  enabled: "true"
  version: "1.1"
---

# Outlook Connector Draft Attach Send

## Purpose
Use the Outlook Mail connector for fast draft creation and draft updates, then use Outlook web only for the part the connector may not expose: true local file attachments.

Use this skill when the user wants Outlook emails prepared quickly but also wants one or more local files attached.

## Default rule
Because Outlook Mail is connected, use the connector first for message creation.

Use browser automation only for the attachment step and final send when a true file attachment is required and no native connector attachment action is available.

## Action discovery rule
Before assuming attachment or schedule-send is unsupported, inspect the currently exposed Outlook Mail actions when tools are available.

Connector actions commonly used by this workflow include:
- `outlookMail_create_draft`
- `outlookMail_update_draft`
- `outlookMail_send_draft`
- `outlookMail_list_messages`
- `outlookMail_list_messages_from_folder`
- `outlookMail_read_message`
- `outlookMail_list_folders`

Known connector gaps to verify during action discovery:
- No attachment upload or add-attachment action was exposed.
- No schedule-send / delayed-delivery connector action was exposed.
- Therefore, if a real file must be attached and no native attachment action is discovered, do not finish the send through the connector alone.
- Therefore, if schedule-send is required and no native schedule action is discovered, use Outlook web for the final schedule action and verify the scheduled state in the UI.

## Privacy and safety
- Treat recipients, subjects, message body text, attachment filenames, email addresses, and message IDs as sensitive.
- Use redacted labels in chat summaries unless the user asks for exact details.
- Do not paste full email bodies or private attachment names into logs.
- For sensitive files such as resumes, contracts, IDs, offer letters, or financial documents, confirm the exact absolute file path and exact recipient before upload or send.

## Connector-first rules
- Prefer connector draft creation over browser composition.
- Prefer connector draft updates for subject, body, and recipients before opening the draft in the browser.
- If no attachment is needed, finish entirely through the connector with `outlookMail_send_draft`.
- If an attachment is needed, do not send with the connector first.
- Open the draft in Outlook web, attach the file there, verify it staged, then send from the browser.

## Preconditions
- Outlook Mail is connected.
- The user has given the recipient, subject or clear intent, and the file to attach or enough guidance to find it.
- Outlook web is already open or can be used safely.
- The absolute local file path is known or can be resolved safely.

## Recommended flow

### 1. Resolve the attachment path first
- Use an absolute path for every file.
- Check the workspace, Downloads, Desktop, Documents, or any user-provided location.
- If the file is sensitive or multiple plausible files match, ask before attaching.
- If a synthetic test file is acceptable, write it into the workspace and attach that.

### 2. Create the draft through the connector
- Use `outlookMail_create_draft` with:
  - `subject`
  - `body_content`
  - `to_recipients`
  - optional `cc_recipients`
  - optional `bcc_recipients`
- Capture at least:
  - message ID
  - `webLink`
  - subject
  - recipient list
  - `hasAttachments`
  - `isDraft`

### 3. Update the draft through the connector if needed
- Use `outlookMail_update_draft` for any body or recipient adjustments before opening the browser draft.
- Re-verify the draft metadata after the update when helpful.
- Prefer finishing all content edits here before moving into the browser.

### 4. Open the exact draft in Outlook web
- Prefer the connector-returned `webLink` for the draft.
- If the `webLink` fails, open Drafts and locate the draft by exact subject and recipient.
- Once the draft is visible, use `take_snapshot` or `take_enhanced_snapshot`.

### 5. Use the local-file attachment path
Outlook may show several attachment choices such as local file upload, recent files, or cloud providers.

Prefer the local-device option.

Typical labels may include:
- Attach
- Insert
- Browse this computer
- Upload from this device
- File
- This device

Do not assume the first paperclip-like button is the actual upload target.

### 6. Reveal a hidden file input if needed
If the visible attachment controls do not expose a directly usable file input, surface a real `input[type=file]` and then upload to that surfaced input.

```javascript
(() => {
  const inputs = [...document.querySelectorAll('input[type="file"]')];

  inputs.forEach(input => {
    input.removeAttribute('aria-label');
    input.style.display = 'none';
  });

  const preferred = inputs.find(input => {
    const accept = (input.getAttribute('accept') || '').toLowerCase();
    const label = [
      input.getAttribute('aria-label') || '',
      input.getAttribute('title') || '',
      input.id || '',
      input.name || ''
    ].join(' ').toLowerCase();
    const acceptsDocument = accept.includes('pdf') || accept.includes('doc') || accept.includes('msword') || accept.includes('officedocument');
    const looksLikeFile = label.includes('file') || label.includes('attachment') || label.includes('document');
    const imageOnly = accept && accept.split(',').every(part => part.toLowerCase().includes('image'));
    return !input.disabled && !imageOnly && (acceptsDocument || looksLikeFile || !accept);
  });

  if (!preferred) return 'no document file input found';
  preferred.className = '';
  preferred.removeAttribute('hidden');
  preferred.removeAttribute('aria-hidden');
  preferred.setAttribute('tabindex', '0');
  preferred.setAttribute('aria-label', 'Outlook document attachment file input');
  preferred.setAttribute('title', 'Outlook document attachment file input');
  Object.assign(preferred.style, {
    display: 'block',
    visibility: 'visible',
    opacity: '1',
    position: 'fixed',
    left: '260px',
    top: '280px',
    width: '360px',
    height: '42px',
    zIndex: '999999',
    pointerEvents: 'auto',
    background: 'white',
    border: '2px solid blue'
  });
  return `outlook document attachment input surfaced; accept=${preferred.accept || '(empty)'}`;
})()
```

### 7. Upload the file
- Take a fresh snapshot after exposing the input.
- Target the surfaced snapshot element, not a raw DOM node reference.
- Use `upload_file` with the absolute file path.
- Wait for Outlook to finish staging the attachment.

### 8. Verify staging before sending or scheduling
Do not send or schedule until one of these is visible:
- the exact filename appears in the composer
- an attachment chip or card appears
- a remove-attachment control appears
- a snapshot or DOM state clearly shows the file is attached
- a connector read of the same draft shows `hasAttachments: true`

For high-stakes emails, verify both the browser-visible filename and `hasAttachments: true` through `outlookMail_read_message`.

For sensitive files, confirm the staged filename, recipient, and subject still match the user's approved email before sending or scheduling.

If the filename does not appear, do not send or schedule.
Retry the upload path once.

### 9. Send from the browser
- Use the browser UI Send button once.
- Do not call `outlookMail_send_draft` after browser-side attachment staging unless the browser send path clearly fails and attachment persistence is verified.
- Prefer browser send for attached drafts because it preserves the exact browser-side staged state.

### 10. Verify delivery
- Confirm the compose window closes or the draft exits edit mode.
- Verify in Sent Items when practical.
- Confirm the sent message shows `hasAttachments` through connector read/list when possible, or that the Sent Items UI clearly shows the file was attached.

## Verification pattern after browser send
1. Use the browser UI or connector to confirm the draft is no longer open.
2. Use `outlookMail_list_folders` to identify the Sent Items folder, noting the name may be localized.
3. Use `outlookMail_list_messages_from_folder` with a small `top` value and a narrow `select` list.
4. Match by recent subject, recipient, and send time.
5. Use `outlookMail_read_message` if deeper confirmation is needed.

## Recovery

### Draft exists in connector but not easy to find in browser
- Open the connector-returned `webLink`.
- If that fails, use Drafts and search by exact subject.

### Visible attach button is not uploadable
- Surface the real `input[type=file]` with `evaluate_script`.
- Take a new snapshot and upload to that input.

### A file picker menu opens with several choices
- Choose the local-device upload path, not OneDrive or recent cloud files, unless the user asked for those.

### Upload appears stuck
- Wait briefly, re-snapshot, and verify whether the filename already staged.
- Retry once with the same surfaced input or re-open the local file upload path.

### Browser send works but connector verification is awkward
- Prefer recent-message inspection over heavy filters.
- Some complex filter and sort combinations can trigger `InefficientFilter`.
- Use `top` plus a narrow `select`, then inspect the most recent results.

### Wrong attachment already staged
If the wrong local file is attached and the email is not sent/scheduled yet:
- Prefer creating a clean replacement draft through the connector, attaching the correct file, verifying it, then deleting the old wrong draft with `outlookMail_delete_draft`.
- Do this especially when Outlook's attachment preview/removal UI appears sticky, cached, localized, or unreliable.
- Only use the remove-attachment UI when it is clearly available and the filename disappears afterward.

### Scheduled send with attachments
- Use Outlook web for schedule-send after browser-side attachment staging unless a native schedule-send action is discovered and verified.
- If embedded compose gives `There was a problem sending this message. Please try again later.`, pop out the draft into its own compose window and retry schedule-send there.
- In the schedule dialog, selecting a custom time may return to suggested times with a `Last chosen time` option; select that suggested `Last chosen time` row, then click `Send`.
- Verify success by opening the scheduled message: Outlook should show `Cancel send` instead of ordinary draft-only controls, and the attachment list should still show the exact filename.

### Connector send vs browser send
- No attachment: connector send is preferred.
- With attachment: browser send is preferred after staging and verification.
- With attachment plus scheduled send: browser schedule-send is required unless native schedule-send support is discovered and verified.

## Reusable rules
- Connector for speed, browser for true local attachments and schedule-send gaps.
- Always resolve absolute file paths before upload.
- Always verify staged attachment before sending or scheduling.
- Use the draft `webLink` when available.
- Prefer browser send once the attachment has been added in Outlook web.
- Prefer pop-out compose for Outlook schedule-send if embedded compose errors or behaves inconsistently.
- Use connector verification after send when it adds confidence without redoing the work.
