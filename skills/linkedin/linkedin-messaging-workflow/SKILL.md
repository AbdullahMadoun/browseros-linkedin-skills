---
name: linkedin-messaging-workflow
description: Send LinkedIn messages from existing threads by opening the right conversation, filling the composer, using the reliable send path, and verifying the new outbound message appears.
metadata:
  display-name: LinkedIn Messaging Workflow
  enabled: "true"
  version: "1.0"
---

# LinkedIn Messaging Workflow

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Send a message in an existing LinkedIn thread reliably with BrowserOS.

This skill covers the mechanics of opening a thread, composing a message, sending it, and verifying success. It does not decide the message strategy unless the user already provided enough context.

## Trusted behavior
- Click the conversation row body to open an existing thread.
- Use the `Write a message...` composer.
- `Control+Enter` can send reliably on LinkedIn Messaging.
- Clicking Send is a reliable fallback.
- Plain Enter may insert a newline instead of sending.

## Safety boundary

Do not send unless the exact recipient/thread and message text are approved by
the user. For tests, stop after opening the thread and locating the composer.

## Workflow

1. **Open LinkedIn Messaging.**
   - If already on the correct thread, skip thread selection.
   - Otherwise, use the conversation list to find the target person.

2. **Open the target thread.**
   - Click the conversation row body, not a nested incidental control.
   - Use `take_snapshot` after opening.
   - Confirm the active conversation is the intended person.

3. **Focus the composer.**
   - Find the `Write a message...` textbox.
   - Click or focus it before typing.

4. **Fill the message.**
   - Use the user's approved message when provided.
   - If the message is not clear, ask before sending.

5. **Send.**
   - Preferred: `Control+Enter`.
   - Fallback: click Send.
   - Do not rely on plain Enter as a send action.

6. **Verify success.**
   - Take a fresh snapshot.
   - Confirm the new outbound message appears at the bottom of the thread.
   - Confirm the composer cleared or the Send button returned to disabled state.

## Fallback order
1. `Control+Enter`.
2. Send button.
3. Re-focus composer and retry once if the first action clearly did not fire.

## Failure indicators
- Message remains in the composer.
- Plain Enter only adds line breaks.
- No new outbound message appears in the thread.

## Operational notes
- If focus is odd, click back into the composer before sending.
- Verify the recipient before sending.
- Reuse workflow logic, not old transient element IDs.
- For existing-thread messaging, `Control+Enter` is usually the fastest reliable path.
