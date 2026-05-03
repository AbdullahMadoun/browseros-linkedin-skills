---
name: linkedin-attach-document-workflow
description: Attach and send a local document in a LinkedIn message thread by locating the absolute file path, exposing LinkedIn's hidden file input when needed, uploading the file, sending the message, and verifying the attachment card.
metadata:
  display-name: LinkedIn Attach Document Workflow
  enabled: "true"
  version: "1.1"
---

# LinkedIn Attach Document Workflow

## Purpose
Send a document through an existing LinkedIn message thread using BrowserOS tools.

Use this when the user asks to send a CV, resume, PDF, DOC, DOCX, or other document through LinkedIn Messaging.

## Preconditions
- The correct LinkedIn message thread is open, or the target thread can be opened first.
- The user has provided the message and document intent, or the message is obvious from context.
- The absolute local file path is known, or can be found safely before upload.

## Sensitive document rule
For resumes, CVs, offer letters, contracts, IDs, financial documents, or other private files, require explicit confirmation of both the exact absolute file path and the exact recipient/thread before uploading. If the file was discovered by search instead of supplied directly by the user, re-confirm before sending.

## Core rule
Do not assume the visible paperclip button is the upload target.

LinkedIn often hides the real `input[type=file]`. If `upload_file` fails against the visible attachment control, expose the real file input with `evaluate_script`, then take a fresh snapshot and upload to the surfaced input.

## Workflow

1. **Verify the target thread.**
   - Use `take_snapshot`.
   - Confirm the active conversation is the intended recipient.
   - Identify the composer labeled like `Write a message...`, the attach-file control, and the Send button.

2. **Resolve the document path.**
   - Use an absolute path.
   - If the path is unknown, search likely folders such as Downloads, Documents, Desktop, and any user-named project folder.
   - Prefer the most recent matching PDF/DOC/DOCX only when that matches the user's request.
   - If the document is sensitive or multiple plausible documents exist, ask the user to confirm the exact file before attaching.

3. **Click the visible attach-file control once.**
   - This can cause LinkedIn to initialize the hidden document upload input.
   - Do not treat this click as proof that upload is ready.

4. **Expose the real file input if needed.**
   - Use `evaluate_script` to reveal a hidden `input[type=file]`.
   - Prefer the document input over image-only upload inputs when multiple inputs exist.

   ```javascript
   (() => {
     const inputs = [...document.querySelectorAll('input[type="file"]')];
     const el = inputs.find(input => {
       const accept = (input.getAttribute('accept') || '').toLowerCase();
       const label = [
         input.getAttribute('aria-label') || '',
         input.getAttribute('title') || '',
         input.id || '',
         input.name || ''
       ].join(' ').toLowerCase();
       const acceptsDocument = accept.includes('pdf') || accept.includes('doc') || accept.includes('msword') || accept.includes('officedocument');
       const looksLikeDocument = label.includes('document') || label.includes('file') || label.includes('attachment');
       const imageOnly = accept && accept.split(',').every(part => part.toLowerCase().includes('image'));
       return !imageOnly && (acceptsDocument || looksLikeDocument);
     });
     if (!el) return 'no file input';
     el.className = '';
     el.removeAttribute('hidden');
     el.setAttribute('tabindex', '0');
     el.setAttribute('aria-label', 'Attach document file input');
     el.setAttribute('title', 'Attach document file input');
     Object.assign(el.style, {
       display: 'block',
       visibility: 'visible',
       opacity: '1',
       position: 'fixed',
       left: '280px',
       top: '700px',
       width: '260px',
       height: '40px',
       zIndex: '999999',
       pointerEvents: 'auto',
       background: 'white',
       border: '2px solid red'
     });
     return 'document file input surfaced';
   })()
   ```

5. **Take a fresh snapshot.**
   - Find the surfaced element labeled `Attach document file input`.
   - Use the snapshot element ID, not a raw DOM node ID.

6. **Upload the document.**
   - Use `upload_file` on the surfaced file input.
   - Wait for LinkedIn to stage the attachment.

7. **Verify staging before sending.**
   - Take another snapshot.
   - Confirm a staged attachment is visible, usually through a `Remove attachment <filename>` control or visible filename.
   - For sensitive documents, confirm the staged filename and recipient still match the user's approved file and thread.
   - If no staged attachment appears, do not send.

8. **Fill the composer.**
   - Use `fill` on the `Write a message...` composer.
   - If the user did not provide wording, use a short direct message only when the context makes it safe.

9. **Send once.**
   - Click Send or use the verified send method for the current LinkedIn page.
   - Do not repeatedly click Send if the UI is slow.

10. **Verify final delivery.**
    - Take a fresh snapshot.
    - Confirm the sent message appears in the thread.
    - Confirm the document card appears in the thread with the filename or file type.

## Recovery

### `upload_file` says the target is not a file input
- The visible attach button was targeted instead of the real input.
- Surface the hidden `input[type=file]`, re-snapshot, and upload to the surfaced snapshot element.

### A DOM node ID does not work with `upload_file`
- `upload_file` needs a BrowserOS snapshot element ID.
- Surface the input, then take a snapshot and use that element.

### The path was typed but nothing attached
- Typing a path is not upload.
- Use `upload_file` against a real file input.

### Attachment staged but not sent
- Confirm message text exists and Send is enabled.
- Click Send once.
- Verify the document card appears in the thread.

## Reusable rules
- Always resolve the absolute file path first.
- Reuse the workflow, not old transient element IDs.
- Verify the staged attachment before sending.
- Verify the document card after sending.
- Ask before uploading or sending sensitive documents unless the exact file and recipient were already confirmed.
- Ask before attaching when multiple plausible files match.
