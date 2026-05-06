# LinkedIn Comment Mining Details

Load this reference for real comment mining, lead scoring, Outreach sheet
tracking, or detailed output.

Sections: inputs, post pre-check score, expansion tactics, extraction, lead
scoring, profile validation, outreach recommendations, Outreach sheet fields,
output schema, and anti-patterns.

## Inputs

- `POST_URL`
- optional `POST_TEXT`
- `TARGET_ROLE`
- `GEO_SCOPE`, default Saudi Arabia/KSA when relevant
- optional redacted candidate profile
- `COMMENT_SCAN_LIMIT`, default 80 visible comments or fewer if LinkedIn blocks
  expansion
- `MODE`: `quick-mine`, `deep-mine`, `referral-route`, `contact-route`, or
  `pivot-discovery`
- optional Outreach tracking request

## Post Pre-Check Score

Score 0-10:

- hiring intent: direct hiring/open role = 3, adjacent opportunity = 2, vague = 0
- role relevance: exact/adjacent = 2, weak = 1
- geography relevance: target country/city/remote clear = 2, unclear = 0
- recency: this week = 2, this month = 1, old/unclear = 0
- existing contact route: email/DM/apply link = 1

Deep mine if `>=7`, the user asks anyway, or the post is strategically important.

## Expansion Tactics

1. Dismiss popups/cookie banners if needed.
2. Expand `See more` in the post text.
3. Open comments.
4. Sort by relevance/recent if the UI allows; prefer recent for live hiring.
5. Click `Load more comments`, `Show more comments`, or `View replies` until
   signal plateaus, scan limit is reached, UI is unstable, or comments are mostly
   irrelevant candidate spam.
6. Expand comment `See more` only for promising comments.

Do not exhaust tool calls expanding low-value comments.

LinkedIn may focus a blank comment editor when the comment count or `Comment`
control is used to expose the thread. Treat that editor as a read-only side
effect: do not type, paste, submit, or react. Continue extraction from visible
comments/replies, or move focus away if the editor obstructs the thread.

## Extraction

Contact routes:

- emails
- `DM me` / `send me your resume` / `reach out`
- apply links or career links
- WhatsApp/contact instructions
- recruiter names tagged by poster
- hiring manager names tagged by employees
- referral offers

Capture:

```text
Route type: email / DM / apply link / referral / tagged person / WhatsApp / unclear
Exact visible route:
Who provided it:
Comment URL if available:
Confidence:
Notes:
```

Classify useful people:

- `poster`
- `recruiter`
- `hiring_manager`
- `employee_referral`
- `team_member`
- `founder_exec`
- `company_page`
- `candidate`
- `irrelevant`

For each useful person:

```text
Name:
Profile URL:
Visible title/company:
Comment role/classification:
Evidence from comment:
Relationship to post/company:
Connection degree if visible:
Recommended action:
```

Clarifications to capture:

- location requirements
- remote/hybrid/onsite
- visa/nationality/language requirements
- seniority
- deadline
- required skills
- whether role is still open
- whether role is Saudi/KSA-specific

Pivot leads:

- recruiter posting similar roles
- repeatedly mentioned company
- tagged team lead
- employee offering referrals
- competitor/sector commenter
- application email domain revealing employer identity

## Lead Scoring

Score comment leads 0-10:

- role/contact relevance: direct recruiter/hiring manager/referral = 3,
  adjacent = 2
- company relationship: current employee/company/poster = 2
- actionability: clear email/DM/apply/referral = 2, vague = 1
- geography/seniority clarification improves fit = 1
- outreach warmth/context = 1
- profile confidence/URL available = 1

Decision:

- `8-10`: priority lead; shortlist and optionally Outreach sheet
- `6-7`: secondary lead or validation target
- `4-5`: keep only if few leads exist
- `<=3`: discard

Discard or down-rank applicant comments, generic congratulations,
training/course spam, unrelated recruiters, comments with no route/evidence, and
duplicates of the same person/email/CTA. Do not treat `interested` as a hiring
signal.

## Profile Validation

Open or inspect a profile only when needed to verify title/company. Prefer
profile URL and current headline visible from LinkedIn. Avoid deep profile
browsing for weak leads. Mark second-degree/mutual-rich profiles as warmer.
Reduce confidence for stale profiles or company mismatch.

## Outreach Recommendations

Allowed recommendations:

- `apply_first_then_message`
- `connect_no_note`
- `message_existing_connection`
- `comment_publicly`
- `save_for_company_mapping`
- `pivot_to_profile`
- `pivot_to_company`
- `ignore`

Do not send without explicit instruction. Suggested message angle:

```text
Saw your comment on <post/company/role>. You mentioned <specific route/clarification>. My background in <grounded candidate evidence> fits <role/team>. Would it be appropriate to apply via <route> or share my resume with you?
```

Keep messages short and non-generic.

## Outreach Sheet

If tracking is requested:

1. Use `linkedin-outreach-sheet-workflow`.
2. Use `google-sheets-connector-reliability`.
3. Add only comment leads with score `>=7` unless user asks broader tracking.
4. Deduplicate by profile URL, email, company + name, or post URL.

Minimum row fields:

```text
Name:
LinkedIn URL:
Type: recruiter / hiring_manager / employee_referral / team_member / company
Company:
Title:
Source: LinkedIn hiring-post comment miner
Source post URL:
Signal:
Next action:
Status:
Notes:
```

## Output Schema

```text
# LinkedIn Hiring Post Comment Mine

Post URL:
Post author:
Post date:
Target role:
Geo scope:
Post score:
Mining depth: quick / deep

## Original post signal
- Hiring intent:
- Role/geography evidence:
- Existing application/contact route:

## Contact routes found
| Route type | Route | Provided by | Evidence | Confidence | Action |

## Useful people found
| Name | Classification | Title/company | Evidence | URL | Score | Recommended action |

## Clarifications from comments
| Topic | Clarification | Who said it | Impact |

## Discarded noise patterns
-

## Pivot plan
| Pivot source | Why useful | Next vertical | Query/URL | Stop condition |

## Suggested next actions
1.
2.
3.

## Reliability notes
-
```

## Anti-Patterns

- Mining every commenter equally.
- Confusing applicant comments with useful leads.
- Sending connection requests or messages without explicit instruction.
- Ignoring replies where real contact routes are often hidden.
- Failing to capture source post URL.
- Adding weak unverified commenters to Outreach.
- Treating `interested` comments as hiring evidence.
