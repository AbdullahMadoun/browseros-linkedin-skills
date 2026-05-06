# BrowserOS LinkedIn And CV Learning Loop

Date: 2026-05-07

## Changes Tested

- Added `linkedin-feature-learning-lab` for safe LinkedIn feature-family mapping.
- Added `cv_format_quality_check.rb` and `cv-format-quality-loop.md` to the
  local LaTeX resume skill.
- Routed unknown LinkedIn branches through the feature lab before promoting
  insights into narrower skills.

## CV Formatter Five-Run Self-Test

Command:

```text
ruby skills/resume-application/local-latex-resume-tailoring/scripts/cv_format_quality_check.rb --self-test test-runs/cv-format-5-run-2026-05-07
```

Result summary:

| Run | Fixture | Expected Behavior | Result |
|---|---|---|---|
| 1 | raw placeholders | fail placeholders, empty sections, thin density | failed as expected |
| 2 | structure fixed but thin | fail density and lost retained bolding | failed as expected |
| 3 | density fixed but bolding lost | fail retained bolding | failed as expected |
| 4 | bolding fixed with escaping warning | pass with warning | passed |
| 5 | final ready fixture using `\cvsection` headings | pass | passed |

Artifacts:

- `test-runs/cv-format-5-run-2026-05-07/summary.md`
- per-run `.quality.json` reports in the same folder
- installed-skill self-test repeated at
  `test-runs/cv-format-installed-selftest-2026-05-07/summary.md`

## LinkedIn Read-Only Probe

Scope: content search branch only.

Entry:

```text
https://www.linkedin.com/search/results/content/?keywords=hiring%20Saudi%20AI
```

Observed public-safe workflow facts:

- `get_page_content` exposes visible search filters, feed-post text, company
  links, job links, hashtag pivots, reaction counts, and comment constraints
  without opening every post.
- `get_page_links` exposes useful direct pivots such as company pages, job
  detail pages, hashtag searches, and profile links.
- DOM button labels expose risky boundaries such as invite, follow, reaction,
  comment, repost, post menu, feedback, and dismiss controls.

Promoted insight:

- Added these extraction shortcuts and boundary rules to
  `linkedin-feature-learning-lab/references/linkedin-feature-map.md`.

No final actions were performed. The temporary LinkedIn tab was closed.

## Reviewer Fixes

- Expanded the LinkedIn feature lab stop list to include comments, replies,
  reactions, reposts, accepts, ignores, joins, registrations, endorsements, and
  similar external actions.
- Fixed duplicate numbering and misplaced safety text in `docs/USAGE_IDEAS.md`.
- Made the CV checker tolerate missing `pdfinfo` by reporting
  `pdf_page_count_unavailable` instead of crashing.
- Fixed placeholder detection for angle-bracket placeholders such as
  `<target role>`.
- Added `summary` to required section checks.
- Added section detection for common preserved resume macros such as
  `\cvsection`, `\resumeSection`, and `\sectionTitle`.
- Changed retained bold detection so a retained anchor still counts when it is
  bolded inside a longer truthful span, such as `\textbf{Python automation}`.
- Changed installers so prune removes only skills previously installed by this
  repo manifest, protecting unrelated custom BrowserOS skills.

## Remaining Live Tests

- Profile edit branch: open edit modals and stop before save.
- Easy Apply regression: open application modal and stop before submit.
- Messaging branch: inspect composer/attachment controls and stop before send or
  sensitive upload.
- Company page branch: verify About, Jobs, Posts, People tab fast paths.
