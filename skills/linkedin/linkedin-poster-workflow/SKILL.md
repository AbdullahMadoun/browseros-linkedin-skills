---
name: linkedin-poster-workflow
description: >-
  Prepare, test, and document LinkedIn post-composer workflows safely, including
  text posts, media/photo/video uploads, document uploads, polls, scheduling UI,
  celebrations, hiring posts, expert requests, audience/comment settings, and the
  hidden/shadow DOM file-input trick. Use when the user asks to create, learn,
  test, automate, or draft a LinkedIn post workflow. Default posture is prepare,
  verify, and stop before final posting unless the user explicitly confirms.
metadata:
  display-name: LinkedIn Poster Workflow
  enabled: 'true'
---

# LinkedIn Poster Workflow

## Purpose

Use this skill to operate or study LinkedIn's post composer safely.

It covers:

- Normal text-post composer
- Photo/media/video attachment workflow
- Document attachment workflow
- Polls
- Schedule-post UI
- Celebration posts
- Hiring posts
- Expert request posts
- Audience and comment settings
- Emoji/text editor behavior
- Article editor cover upload limitation

Primary safety rule: **do not click the final `Post` button unless the user explicitly confirms the exact final content and publishing intent.**

For experimental or learning tasks, never post. Stage only test content/files, verify the workflow, then remove/discard.

## When to use

Use this skill when the user asks for any of these:

- "Create a LinkedIn poster workflow"
- "Draft a LinkedIn post"
- "Attach media/document to a LinkedIn post"
- "Learn the LinkedIn post buttons/clicks"
- "Test LinkedIn attachment upload"
- "Use the hidden input trick for LinkedIn attachments"
- "Prepare a LinkedIn post but don't post"

Do not use this skill for LinkedIn messaging attachments; use `linkedin-attach-document-workflow` for message threads.

## Safety posture

1. Treat LinkedIn posting as an external side effect.
2. Never click `Post` during exploration.
3. If the user asks to publish, prepare the composer, verify visible final content, and ask for final confirmation before clicking `Post`.
4. If the user says "do not post," "experimental," "learning," or similar, stop with the composer either cleaned up or clearly staged but unpublished per their request.
5. Avoid generating real public content during tests. Use obvious labels such as `BrowserOS experimental test` if text is needed.
6. Remove staged test media/documents before ending an experiment.
7. Do not use fake/proxy FileList transfer for real uploads; it can trigger LinkedIn errors.

## Entry points

From `https://www.linkedin.com/feed/`:

- `Start a post` opens the normal post composer.
- `Photo` opens the media editor directly.
- `Video` opens the same media editor directly.
- `Write article` opens `/article/new/` with a separate article editor.

Use `take_snapshot` before clicking; IDs are session-specific.

## Normal composer controls

After clicking `Start a post`, expect controls similar to:

- Audience/profile selector, e.g. `Profile Name ... Post to Connections only`
- Text editor: `Text editor for creating content`
- `Open Emoji Keyboard`
- `Add media`
- `Celebrate an occasion`
- `Share that you're hiring`
- `More`
- `Schedule post`
- `Post`

`Post` is disabled until text/media/content exists. Once content is staged, it may become enabled. Do not click it unless final publishing is explicitly confirmed.

## More menu

Click `More` in the composer to expose:

- `Create a poll`
- `Add a document`
- `Find an expert`

## Core attachment rule

Do not assume the visible `Upload from computer` button/label is uploadable.

LinkedIn commonly hides the actual `input[type=file]` in a shadow root. BrowserOS `upload_file` must target the real file input from a fresh snapshot, not the visible button and not a DOM search node ID.

Correct pattern:

1. Open the relevant LinkedIn upload dialog.
2. Click the visible upload button once only if needed to initialize the uploader.
3. Surface the real hidden file input with `evaluate_script`.
4. Take a fresh `take_snapshot`.
5. Use `upload_file` on the surfaced input's snapshot element ID.
6. Verify staging before proceeding.
7. Remove/discard if experimental.

## Shadow DOM file-input surfacing script

Run this with `evaluate_script` after the upload dialog is open.

```js
(() => {
  const inputs = [];
  const seen = new Set();

  function walk(root, path) {
    if (!root || seen.has(root)) return;
    seen.add(root);

    let nodes = [];
    try { nodes = [...root.querySelectorAll('*')]; } catch (e) {}

    for (const el of nodes) {
      if (el.tagName === 'INPUT' && (el.type || '').toLowerCase() === 'file') {
        inputs.push({ el, path });
      }
      if (el.shadowRoot) {
        walk(el.shadowRoot, path + ' > shadow:' + (el.tagName || '').toLowerCase());
      }
    }
  }

  walk(document, 'document');

  inputs.forEach(({ el, path }, i) => {
    el.className = '';
    el.removeAttribute('hidden');
    el.removeAttribute('aria-hidden');
    el.setAttribute('tabindex', '0');
    el.setAttribute('aria-label', `LinkedIn surfaced file input ${i} ${el.accept || ''}`);
    el.setAttribute('title', `LinkedIn surfaced file input ${i}`);
    Object.assign(el.style, {
      display: 'block',
      visibility: 'visible',
      opacity: '1',
      position: 'fixed',
      left: '24px',
      top: `${120 + i * 52}px`,
      width: '460px',
      height: '42px',
      zIndex: '2147483647',
      pointerEvents: 'auto',
      background: 'white',
      color: 'black',
      border: '3px solid red'
    });
    el.dataset.browserosSurfaced = 'true';
    el.dataset.browserosPath = path;
  });

  return inputs.map(({ el, path }, i) => ({
    i,
    path,
    id: el.id,
    accept: el.accept,
    multiple: el.multiple,
    label: el.getAttribute('aria-label')
  }));
})()
```

Then:

1. Run `take_snapshot`.
2. Find the surfaced input by label, usually `LinkedIn surfaced file input ...`.
3. Call `upload_file` on that snapshot element ID.
4. Verify the upload staged in LinkedIn.

## Media/photo/video upload workflow

Use for `Photo`, `Video`, or composer -> `Add media`.

Steps:

1. Open feed.
2. Click `Start a post`, then `Add media`; or click the feed-level `Photo`/`Video` shortcut.
3. Media editor opens with `Upload from computer`, `Back`, and `Next`.
4. If no file input exists yet, click visible `Upload from computer` once to initialize.
5. Surface the hidden input with the script above.
6. Expected input resembles:

```html
<input id="media-editor-file-selector__file-input"
       name="file"
       multiple
       filecountlimit="20"
       accept="image/gif,image/jpeg,image/jpg,image/png,image/webp,video/*,video/mp4,video/avi,video/webm,video/x-ms-wmv,video/x-flv,video/mpeg,video/quicktime,video/x-m4v"
       type="file">
```

7. `take_snapshot`.
8. `upload_file` to the surfaced input.
9. Verify staged-media controls appear:
   - `Manage (1)` or similar
   - `Edit`
   - `Tag`
   - `Alternative text`
   - `Back`
   - `Next`
10. Optional exploration:
   - `Manage` can duplicate/reorder media.
   - `Edit` exposes crop/filter/adjust paths.
   - `Tag` opens person-tag search.
   - `Alternative text` opens alt-text entry.
11. Click `Next` only to stage the media into the composer.
12. Once composer appears, `Post` may be enabled. Stop before `Post` unless confirmed.
13. For experiments, remove media or dismiss/discard.

## Document upload workflow

Use composer -> `More` -> `Add a document`.

Steps:

1. Open feed.
2. Click `Start a post`.
3. Click `More`.
4. Click `Add a document`.
5. Document upload dialog opens.
6. Surface the hidden input with the script above.
7. Expected input resembles:

```html
<input id="ember...-upload-element"
       class="cloud-filepicker-visually-hidden"
       name="file"
       accept=".doc,.docx,.pdf,.ppt,.pptx"
       type="file">
```

Observed constraints:

- Accepts `.doc`, `.docx`, `.pdf`, `.ppt`, `.pptx`
- Single file only
- Requires `Document title *` after upload
- `Done` is disabled until a title exists

Steps after surfacing:

1. `take_snapshot`.
2. `upload_file` to the surfaced document input.
3. Verify `Document title *` and `Remove uploaded document file` appear.
4. Fill a document title.
5. Click `Done`.
6. Verify the document card is staged in the composer.
7. Stop before `Post` unless confirmed.
8. For experiments, click `Remove media` to remove the staged document.

## Poll workflow

Path: composer -> `More` -> `Create a poll`.

Expected fields:

- Question
- Option 1
- Option 2
- Add option
- Poll duration

Use only experimental text unless the user provides final content. Back/discard before posting in learning mode.

## Schedule-post workflow

Path: composer -> `Schedule post`.

Expected controls:

- Date input
- Time input/dropdown
- Time picker, observed in 15-minute increments
- `View all scheduled posts`
- `Back`
- `Next`

Scheduling is a publishing side effect. Do not confirm/schedule without explicit final confirmation.

## Celebration workflow

Path: composer -> `Celebrate an occasion`.

Observed behavior:

- Opens occasion/template options.
- Selecting a template opens a themed composer.
- Back/discard before posting in experimental mode.

## Hiring workflow

Path: composer -> `Share that you're hiring`.

Observed fields:

- Job title
- Company
- Location
- Job type

Observed buttons:

- `Write on my own`
- `Write with AI`

Buttons may remain disabled until required fields are valid. Do not create a real hiring post in experimental mode.

## Expert request workflow

Path: composer -> `More` -> `Find an expert`.

This opens an expert-request form. Fill only with explicit user-provided data, and stop before publishing unless confirmed.

## Audience/comment settings

Click the composer's audience/profile selector to inspect or change visibility.

Observed settings include:

- Audience selection, such as connections/global variants depending on account state
- Comment control
- Brand partnership switch

Changing audience can materially affect publication. For real posts, verify final audience before asking for post confirmation.

## Emoji and text editor

The emoji picker includes:

- Search
- Skin tone selector
- Category tabs
- Individual emoji buttons

The text editor supports normal text and LinkedIn autocomplete behavior for mentions/hashtags.

Use harmless labels during experiments and clear them before closing.

## Article editor cover upload limitation

Path: feed -> `Write article` -> `/article/new/`.

The article editor has an `Upload from computer` button for a cover image/video.

Observed after clicking it:

```html
<input id="media-editor-file-selector__file-input"
       name="file"
       filecountlimit="1"
       accept="image/jpeg,image/jpg,image/png,image/webp,video/*,video/mp4,video/avi,video/webm,video/x-ms-wmv,video/x-flv,video/mpeg,video/quicktime,video/x-m4v"
       type="file">
```

Important limitation:

- The real article-cover input was observed inside LinkedIn's preload iframe (`https://www.linkedin.com/preload/`).
- `search_dom` may see it, but `take_snapshot` may not expose it as an uploadable snapshot element.
- `upload_file` requires a BrowserOS snapshot element ID, not a `search_dom` node ID.
- Uploading to the visible button fails because it is not a file input.

Brute-force result:

- Creating a proxy file input in the main page, uploading to it, transferring its `FileList` to LinkedIn's iframe input, and dispatching `input/change` caused LinkedIn to react but ended in `Something went wrong`.

Rule:

- Do **not** use proxy FileList transfer for production.
- For article cover upload, either require manual/native user upload or a lower-level tool that can set files directly on iframe DOM nodes.

## Cleanup patterns

For staged media/document:

- Prefer `Remove media` or `Remove uploaded document file` when visible.
- If backing out from an editor prompts to save/discard draft, choose discard for experiments.
- If testing article editor, remove any BrowserOS-created proxy inputs with:

```js
(() => {
  document.getElementById('browseros-proxy-file-input')?.remove();
  return 'removed BrowserOS proxy input';
})()
```

Then navigate back to feed if needed.

## Final real-post preparation pattern

When the user wants a real post prepared:

1. Open feed.
2. Click `Start a post`.
3. Fill exact user-approved text.
4. Add requested attachment:
   - Media: `Add media` -> initialize -> surface shadow input -> upload -> verify -> `Next`.
   - Document: `More` -> `Add a document` -> surface shadow input -> upload -> title -> `Done`.
5. Set/verify audience and comment settings if requested.
6. Verify final visible composer state:
   - Text
   - Attachment/document/media card
   - Audience
   - Any schedule settings
7. Ask the user for final confirmation before clicking `Post` or scheduling.
8. If no confirmation, leave prepared or discard according to user preference.

## Experimental test-file pattern

If the user asks to learn/explore without supplying a file, create harmless local test files in the workspace, for example:

- `test-image.png`
- `test-document.pdf`
- `test-slides.pptx` only when a presentation document path needs testing

Use them only to validate staging. Remove/discard from LinkedIn before ending.
