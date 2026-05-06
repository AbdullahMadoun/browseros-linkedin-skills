---
name: linkedin-connection-workflow
description: Send LinkedIn connection requests from profile pages using the reliable no-note flow, verify success from profile state, and update the simple Outreach sheet when tracking is needed.
metadata:
  display-name: LinkedIn Connection Workflow
  enabled: "true"
  version: "1.2"
---

# LinkedIn Connection Workflow

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Send LinkedIn connection requests efficiently and verify that the invite was actually sent.

This skill covers the invite mechanics first. If the user also wants tracking, hand the result into the simple `Outreach` sheet schema.

## One-sheet handoff rule
If tracking is needed, update the existing `Outreach` sheet row.
Do not create an invite-tracking sheet, sent sheet, or follow-up sheet.

## Trusted default
Use the profile-based Connect or Invite path and send without a note unless the user explicitly asks for a note and the note composer is verified live.

## Workflow: connect without a note
1. **Open the target profile.**
   - Prefer the full profile page over cards or suggestions.
   - Confirm it is the intended person before sending.
2. **Find the Connect or Invite action.**
   - Use `take_snapshot`.
   - Click the visible profile-level Connect or Invite action.
   - If Connect is under More, open More and choose it there.
3. **Wait for the invite modal.**
   - Confirm it belongs to the target person.
   - Do not reuse old element IDs.
4. **Send without a note.**
   - Click `Send without a note`.
   - Wait for the modal to close or the page state to change.
5. **Verify from profile state.**
   - Re-check the profile page.
   - Success requires an explicit invite-sent state such as Pending, Invitation sent, Withdraw, or another clearly equivalent state.
   - Do not treat generic Message or More buttons, or Connect disappearing by itself, as proof that the invite was sent.

## Fallback order
1. Profile Connect or Invite.
2. Connect or Invite from the profile More menu.
3. Suggestion-card Invite only if it is re-verified in the current session.

## Connect with a note
Use only when:
- the user explicitly wants a note
- the Add a note path opens a real composer in the current session
- the send path can be verified after filling the note

If Add a note is not reliable in the live UI, stop and report that clearly.

## Tracking handoff
If invite tracking is part of the task, update or create one `Outreach` row using the single-sheet schema:
- `full_name`
- `profile_url`
- `stage = Invited`
- `last_contact_on = today` if invite date is being tracked
- `last_contact_direction = outbound`
- `next_action_on` and `next_action` only if the user wants a follow-up queued
- short `notes` only when useful

Do not invent a separate tracking structure.

## Verification rules

### Success indicators
- Profile shows Pending, Invitation sent, Withdraw, or another explicit post-invite state.
- The custom-invite modal closes after sending.

### Failure indicators
- The modal remains unchanged.
- Clicking does not create a visible state transition.
- A suggestion-card Invite button behaves like a no-op.
- Only generic Message or More buttons are visible, with no explicit invite-sent state.

## Operational rules
- prefer profile pages over cards
- use Send without a note as the default trusted path when speed matters
- re-verify UI behavior when LinkedIn layout changes
- reuse workflow logic, not old transient element IDs
