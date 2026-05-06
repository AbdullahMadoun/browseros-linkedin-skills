# LinkedIn Poster Upload And Composer Details

Load this reference only when uploads, composer exploration, or recovery details are needed.

## Hidden File Input Rule

Do not assume `Upload from computer` is uploadable. LinkedIn often hides the real `input[type=file]` in shadow DOM. BrowserOS `upload_file` must target a fresh snapshot element ID for the real input.

Correct pattern:

1. Open the upload dialog.
2. Click visible upload once only if needed to initialize.
3. Surface hidden file inputs with the script below.
4. Take a fresh snapshot.
5. Use `upload_file` on the surfaced input.
6. Verify the staged file in LinkedIn.

## Shadow DOM Surfacing Script

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

## Media/Video Upload

Path: feed `Photo`/`Video`, or composer -> `Add media`.

Expected after upload: `Manage`, `Edit`, `Tag`, `Alternative text`, `Back`, `Next`. Click `Next` only to stage media into the composer. Stop before `Post`.

Typical accepted media input includes images and video formats, often with `multiple` and a file count limit.

## Document Upload

Path: composer -> `More` -> `Add a document`.

Expected accepted formats: `.doc`, `.docx`, `.pdf`, `.ppt`, `.pptx`. Usually single-file. After upload, LinkedIn requires `Document title *`; `Done` remains disabled until title exists.

Verify `Remove uploaded document file`, document title field, then final document card in composer.

## Polls

Path: composer -> `More` -> `Create a poll`.

Expected fields: question, option 1, option 2, add option, poll duration. Use only approved or experimental text and stop before posting.

## Schedule Post

Path: composer -> `Schedule post`.

Expected controls: date, time, time picker, `View all scheduled posts`, `Back`, `Next`. Scheduling is a publishing side effect; do not confirm without explicit final approval.

## Celebration / Hiring / Expert Request

- Celebration opens themed template options.
- Hiring flow asks for job title, company, location, job type, and may offer AI writing.
- Expert request opens a form.

Fill only explicit user-provided data. Stop before publishing.

## Audience And Comment Settings

Use the composer audience/profile selector. Verify final audience and comment controls before final approval. Changing audience materially affects publication.

## Article Cover Limitation

Article editor cover upload may expose the real input inside a LinkedIn preload iframe. `search_dom` can see it, but `take_snapshot` may not expose it as an uploadable BrowserOS element.

Do not use proxy file-input transfer for real work. It previously caused `Something went wrong`. Require manual/native upload or a lower-level tool that can set files directly on iframe DOM nodes.

## Cleanup

Use visible remove/discard controls. If a proxy input was created during exploration, remove it with:

```js
(() => {
  document.getElementById('browseros-proxy-file-input')?.remove();
  return 'removed BrowserOS proxy input';
})()
```
