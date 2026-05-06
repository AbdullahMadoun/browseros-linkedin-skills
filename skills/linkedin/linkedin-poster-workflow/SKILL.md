---
name: linkedin-poster-workflow
description: >-
  Prepare LinkedIn posts, media/document uploads, polls, scheduled posts, hiring
  posts, expert requests, audience/comment settings, and composer exploration
  safely. Default posture is prepare, verify, and stop before posting or
  scheduling unless the user explicitly confirms.
metadata:
  display-name: LinkedIn Poster Workflow
  enabled: "true"
  version: "1.1"
---

# LinkedIn Poster Workflow

## Purpose

Operate LinkedIn's post composer safely without rediscovering upload and posting mechanics.

Use for:

- text posts
- media/photo/video posts
- document posts
- polls
- scheduled posts
- celebration, hiring, and expert-request composers
- audience/comment settings
- composer exploration and workflow documentation

Do not use for LinkedIn message-thread attachments; use `linkedin-attach-document-workflow`.

For hidden file inputs, media/document upload mechanics, article-cover limitations, and the shadow DOM surfacing script, read `references/upload-and-composer-details.md`.

## Safety

- Never click `Post`, confirm scheduling, or publish an expert/hiring request without explicit final confirmation for the exact content.
- For learning/tests, use harmless labels, stage only, verify the path, then remove/discard.
- Verify final text, attachments, audience, comment settings, and schedule state before asking for final confirmation.
- Do not use proxy `FileList` transfer for production uploads; it caused LinkedIn errors during exploration.

## Entry Points

From `https://www.linkedin.com/feed/`:

- `Start a post`: normal composer
- `Photo` or `Video`: media editor shortcut
- `Write article`: `/article/new/`, separate article editor

Inside composer:

- `Add media`: photo/video upload
- `More` -> `Add a document`
- `More` -> `Create a poll`
- `More` -> `Find an expert`
- `Schedule post`
- audience/profile selector for visibility and comment controls

Take a fresh snapshot before each click; element IDs are session-specific.

## Fast Path

Use a foreground feed tab for composer work:

```text
feed -> correct composer entry -> stage text/attachment/settings -> verify -> stop before Post/Schedule
```

For tests, use harmless draft text, verify the path, then discard. Do not use the
article editor to test normal post/media/document uploads.

## Normal Posting Flow

1. Open feed and launch the correct composer path.
2. Fill only user-approved final text or obvious experimental text.
3. Add requested attachment:
   - media/video: open media editor, surface real input if needed, upload, verify staged media, click `Next`
   - document: `More` -> `Add a document`, upload, fill title, click `Done`
4. Set/verify audience, comments, schedule, and attachment card.
5. Stop before `Post` or final schedule confirmation unless explicitly approved.

## Verification Signals

Before final confirmation, verify:

- visible post text
- attachment/media/document card and exact staged filename/title when available
- audience and comment settings
- schedule date/time if scheduling
- final button text and enabled state

If verification is partial, report the uncertainty and stop.

## Cleanup

For tests:

- remove staged media/document with visible remove controls
- discard drafts when prompted
- navigate back to feed after cleanup

If cleanup fails, report the staged state rather than trying risky clicks.
