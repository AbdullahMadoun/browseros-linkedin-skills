# LinkedIn Feature Map

Load this reference when running `linkedin-feature-learning-lab`.

The goal is to learn feature families safely and turn observations into shorter
future workflows. Each branch should finish with a fast path, a stop boundary,
and a candidate skill patch decision.

## Feature Families

| Family | Safe Entry Ideas | Safe Probes | Stop Boundary | Candidate Skill |
|---|---|---|---|---|
| Global search | `/search/results/all/`, search box, top nav search | Query, switch verticals, inspect result filters | Message, connect, follow, save, apply | `linkedin-boolean-query-refinement` |
| People search | `/search/results/people/` | Connections, location, current company, title terms, profile preview | Connect, message, follow | `linkedin-people-url-filtering` |
| Jobs search | `/jobs/search/` | Keyword/location filters, date posted, experience, Easy Apply toggle, sort | Apply, save job | `linkedin-easy-apply-application-workflow` |
| Easy Apply | Job detail page with Easy Apply | Open modal, inspect steps, required fields, resume cards, upload control | `Submit application` | `linkedin-easy-apply-application-workflow` |
| Company page | `/company/<slug>/` | About, Posts, Jobs, People, Life tabs, employee search link | Follow, message, apply | `linkedin-company-opportunity-mapper` |
| Posts feed | `/feed/`, company posts, profile activity | Search posts, sort, inspect post menu, copy link, open comments | Post, comment, repost, react | `linkedin-ksa-recent-hiring-posts`, `linkedin-poster-workflow` |
| Comments | Post detail modal/page | Sort comments, expand replies, inspect profiles from comments | Reply, react, message, connect | `linkedin-hiring-post-comment-miner` |
| Reactions/reposts | Post social counts | Open reactions/reposts list, filter visible profiles, capture role/company hints | Message, connect, follow | `linkedin-post-engagement-lead-miner` |
| Messaging | `/messaging/` | Thread search, preview, composer detection, attachment menu | Send, upload sensitive file | `linkedin-messaging-workflow`, `linkedin-attach-document-workflow` |
| Network | `/mynetwork/` | Invitations, suggestions, search contacts, profile card controls | Accept, ignore, invite | `linkedin-connection-workflow` |
| Profile view | Own or public profile URL | Section navigation, contact info modal, activity, skills, featured | Message, connect, endorse | `linkedin-profile-optimizer` |
| Profile edit | Own profile edit controls | Open edit modal, inspect fields, draft text offline | Save, Done | `linkedin-profile-optimizer` |
| Post composer | `Start a post`, `/feed/` composer | Open composer, audience, media/document/poll/schedule controls | Post, schedule final confirm | `linkedin-poster-workflow` |
| Saved items | Saved jobs/posts pages | Open list, filters, remove-menu visibility | Unsave/remove/apply | existing narrow skill or run note |
| Notifications | `/notifications/` | Filter unread/mentions, open safe notification in new tab | React, reply, message | existing narrow skill or run note |
| Services/events/groups | Direct tab/search result | Inspect tab layout, public info, join/register controls | Join, register, message | new-skill candidate only if repeated |

## Learning Depth

Use three depths:

- `quick_map`: one feature family, one or two safe branches, no account writes.
- `capability_map`: multiple branches in one family, direct URLs and fallbacks.
- `regression_map`: verify an existing skill still matches current LinkedIn UI.

Default to `quick_map` unless the user asks for deeper learning.

## Direct URL Pattern Notes

Treat URL patterns as hypotheses until verified in the active account:

- People search: `/search/results/people/?keywords=<query>`
- Posts search: `/search/results/content/?keywords=<query>`
- Jobs search: `/jobs/search/?keywords=<role>&location=<place>`
- Company jobs: `/jobs/search/?currentJobId=&f_C=<company-id>` when company ID is available
- Messaging: `/messaging/`
- Notifications: `/notifications/`
- My Network: `/mynetwork/`

When a URL parameter works, capture the exact parameter and whether LinkedIn
rewrote it after load.

## Observed Extraction Shortcuts

For LinkedIn content search, `get_page_content` can expose the visible filter
groups, feed-post text, company links, job links, hashtag pivots, reaction
counts, comment constraints, and footer state without opening every result.
Use this before clicking post cards.

For post result pages, DOM button labels often expose risky controls such as
invite, follow, reaction, comment, repost, post menu, and feedback buttons. Treat
these labels as boundary evidence unless the user explicitly asked for that
action.

## Skill Patch Decision

Patch a narrower skill only when the branch is:

- verified in the current UI
- generic and public-safe
- useful for reducing clicks or avoiding a known failure
- not dependent on private account data
- consistent with that skill's safety boundary

If the branch is useful but uncertain, save it as a run note with
`candidate_for_skill_patch`.

## Regression Checklist

For each existing LinkedIn skill touched by a feature-learning run, check:

- Did the trigger still route to the same skill?
- Did the fast path still work?
- Did safety stop before the same final action?
- Did a new modal, disabled state, or account prompt appear?
- Did verification require a new success signal?
- Did the skill avoid repeating a failed click after two attempts?

Do not weaken safety or remove output requirements while optimizing speed.
