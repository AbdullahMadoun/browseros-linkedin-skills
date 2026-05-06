---
name: resume-applied-draft-review
description: >-
  Review whether a user's accepted resume edits materially improved the draft versus
  the original for a specific job, identifying wins, regressions, remaining gaps,
  and readiness to submit.
metadata:
  display-name: Resume Applied Draft Review
  enabled: 'true'
  version: '1.0'
---

# Resume Applied Draft Review

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this skill to judge whether an edited or accepted resume draft is actually better than the original for a target job. This is not a rewriting skill. It is a final-draft review and decision-support skill.

## When to use

Activate when the user asks to:

- review the final resume version
- check whether accepted edits improved the resume
- compare original vs tailored draft
- decide if a resume is ready to submit
- interpret alignment score movement
- identify regressions after editing
- review a resume after the user accepted/rejected suggested changes

## Inputs

Minimum useful inputs:

- target job description or parsed job requirements
- original resume
- accepted or edited resume draft

Optional inputs:

- original alignment analysis
- accepted-draft alignment analysis
- original/suggested/accepted metrics
- list of accepted, rejected, and pending changes
- run context such as role, company, constraints, or rewrite coverage target

## Hard rules

1. Do not rewrite the resume unless the user explicitly asks.
2. Compare the original and accepted draft directly.
3. Use metrics as evidence, but do not blindly trust score movement.
4. If wording quality regressed despite a higher keyword score, say so.
5. Do not invent new improvements, missing skills, or requirements.
6. Base every claim on the provided resumes, job requirements, metrics, and user-choice summaries.
7. Be candid about missed opportunities from rejected or pending edits.

## Stop Conditions

Stop at a verdict and concrete next actions. Do not submit applications, edit the
resume file, or compile new variants unless the user asks to move from review
into implementation.

## Output schema

Recommended output:

```json
{
  "verdict": "improved | mixed | unchanged | worse",
  "headline": "short candid summary",
  "summary": "2-3 sentence explanation of the current state",
  "metric_interpretation": "plain-English explanation of score movement",
  "wins": ["specific improvements caused by accepted edits"],
  "regressions": ["specific things that became weaker, riskier, or less clear"],
  "still_missing": ["important job requirements still underrepresented"],
  "next_actions": ["max 4 concrete follow-up actions"],
  "review_readiness": {
    "status": "ready | review_first | revise_again",
    "reason": "why this is the right next step"
  }
}
```

## Review method

1. Parse the target job's critical requirements.
2. Compare original resume vs accepted draft section by section.
3. Identify concrete wins:
   - stronger keyword coverage
   - clearer evidence
   - better role emphasis
   - improved ownership/scope/outcome framing
   - better ATS readability without stuffing
4. Identify regressions:
   - unsupported or risky claims
   - weaker wording
   - lost high-value evidence
   - reduced specificity or metrics
   - over-compression
   - keyword stuffing
   - layout/content thinning
5. Compare remaining gaps against the job requirements.
6. Decide readiness:
   - `ready` — materially improved and safe to review/submit
   - `review_first` — usable, but a few areas need manual inspection
   - `revise_again` — not enough improvement or meaningful regression

## Metric interpretation rules

- A higher score is meaningful only if evidence quality and truthfulness are preserved.
- A lower score may still be acceptable if the user intentionally optimized for clarity, one-page fit, or a different role angle.
- If keyword score improved but relevance or evidence quality weakened, label the result `mixed`.
- If accepted edits mostly skipped critical suggestions, say the draft improved less than it could have.

## Good feedback examples

Good:

- `Improved: the accepted draft surfaces SQL reporting and stakeholder-facing dashboard work more clearly, which maps to two core job requirements.`
- `Mixed: keyword coverage improved, but the accepted draft removed a quantified outcome that made the original stronger.`
- `Review first: the draft is stronger overall, but the cloud-platform requirement remains underrepresented and should not be implied.`

Bad:

- `Looks great` without evidence.
- `Score went up, so submit it` without checking wording quality.
- `Add the missing certification` when it is not evidenced.
