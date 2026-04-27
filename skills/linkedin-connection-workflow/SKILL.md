---
name: linkedin-connection-workflow
description: Send LinkedIn connection requests from profile pages with the reliable no-note flow, avoid flaky suggestion-card invite buttons, and verify success from profile state.
metadata:
  display-name: LinkedIn Connection Workflow
  enabled: "true"
  version: "1.0"
---

# LinkedIn Connection Workflow

## Purpose
Send LinkedIn connection requests efficiently and verify that the invite was actually sent.

This skill covers the mechanics of connection invites. It does not decide who should be contacted or what the outreach strategy should be.

## Trusted default
Use the profile-based Connect or Invite path and send without a note unless the user explicitly asks for a note and the note composer is verified live.

## Workflow: connect without a note

1. **Open the target profile.**
   - Prefer the full profile page over search cards, feed cards, or My Network suggestion cards.
   - Confirm the profile is the intended person before sending.

2. **Find the Connect or Invite action.**
   - Use `take_snapshot`.
   - Click the visible profile-level Connect or Invite action.
   - If Connect is hidden under More, open More and choose the connection action.

3. **Wait for the custom-invite modal.**
   - Confirm the modal belongs to the target person.
   - Do not reuse old element IDs.

4. **Send without a note.**
   - Click `Send without a note`.
   - Wait for the modal to close or the page state to update.

5. **Verify from profile state.**
   - Return to or re-check the profile page.
   - Success indicators:
     - Connect is no longer available.
     - Message, More, Pending, or an equivalent post-invite state remains.

## Fallback order
1. Profile Connect or Invite.
2. Connect or Invite from the profile More menu.
3. Suggestion-card Invite only if it is re-verified in the current session.

## Connect with a note
Treat this as conditional.

Use only when:
- The user explicitly wants a note.
- The Add a note path opens a real note composer in the current session.
- The send path can be verified after filling the note.

If Add a note does not transition to a note composer, stop and report that the note branch is not reliable in the current UI.

## Verification rules

### Success indicators
- Profile loses the Connect action.
- Profile shows Pending, Message, More, or another post-invite state.
- The custom-invite modal closes after sending.

### Failure indicators
- The modal remains unchanged.
- Clicking does not create a visible state transition.
- A suggestion-card Invite button behaves like a no-op.

## Operational rules
- Prefer profile pages over cards.
- Use Send without a note as the fastest trusted path when speed matters.
- Re-verify LinkedIn UI behavior when the layout changes.
- Reuse workflow logic, not old transient element IDs.
