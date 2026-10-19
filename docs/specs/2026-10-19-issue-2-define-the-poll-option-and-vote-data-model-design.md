# Poll, option, and vote data model

## Purpose and current state

Issue #2 defines the shared model for Team Lunch Poll.
Future forms, voting, and results need consistent names and a single source for vote totals.
The model must remain small enough for local browser state.

The app currently uses Vite, strict TypeScript, and plain CSS.
`src/main.ts` imports the stylesheet but contains no poll behavior.
The repository has no shared model or automated test suite.
The issue has no review comments at the time of this specification.
No applicable `AGENTS.md` file was found.

## Goals

- Define a poll question, an ordered collection of lunch options, and recorded votes.
- Give each option a stable identity that does not depend on its text or position.
- Derive a total for every option, including options with no votes.
- Keep the model independent of the DOM and browser storage.
- Use plain JSON-compatible data without new runtime dependencies.

## Scope exclusions

This issue does not add forms, vote buttons, results displays, or changes to the app shell.
It does not implement browser storage, reset controls, or session-based double-vote prevention.
It does not add authentication, voter identities, a backend, timestamps, or multi-poll management.
It does not implement winner selection, tie handling, or a general runtime validation system.

Future issues own input validation, poll creation, voting, results, and persistence.
This model must not imply that those features already exist.

## Proposed contract

These are planning-agent choices for human review, not preferences explicitly stated by the issue author.
The shared module is `src/poll.ts`.
It exports the following TypeScript types and pure counting function:

```ts
export interface PollOption {
  id: string;
  label: string;
}

export interface Vote {
  optionId: string;
}

export interface Poll {
  question: string;
  options: PollOption[];
  votes: Vote[];
}

export function countVotesByOption(poll: Poll): Record<string, number>;
```

The signature describes the contract, not an implementation in this specification.
There is no default export.
Other modules can import these names without loading the app entry point or accessing browser globals.

### Poll and option rules

`Poll` represents one current poll.
The future app can represent no current poll as `Poll | null`, outside the model itself.
A poll does not need an ID because this version does not manage multiple polls.

`question` contains the poll question.
`options` preserves the order that the creator selects.
Each option has a nonempty `id` that is unique within its poll.
An option keeps the same ID after a label change or position change.
`label` contains the meal or restaurant name.
Duplicate labels do not merge options because IDs determine identity.

A complete poll has a nonblank question and at least two options with nonblank labels.
The future creation and validation features enforce these rules.
The types alone cannot enforce them.
The model does not generate IDs, trim text, or reject draft data.
The builder can choose the ID generator in the future creation issue.

### Vote rules

Each `Vote` records one vote for the option with the matching `id`.
The poll contains its own votes, so a vote does not need a poll ID.
A vote does not need a separate ID or voter identity for this local demo.

Every array entry represents a separate recorded vote.
Multiple entries with the same `optionId` each contribute one vote.
A new poll starts with `votes: []`.
Future voting code must accept only IDs from the current poll.
Session-based double-vote prevention belongs to that feature, not to this data structure.

### Counting rules

`votes` is the only source of vote totals.
Neither `Poll` nor `PollOption` stores a cached total.
This avoids two values that can disagree after a vote.

`countVotesByOption` returns a new record whose own keys are the current option IDs.
Every option starts with a total of zero.
Each vote with a matching option ID increases that total by one.
The function ignores a vote whose option ID is absent from the current options.
This rule prevents an obsolete vote from creating a nonexistent option in the results.
It does not replace validation of data from browser storage.

The function does not change the poll, its arrays, its options, or its votes.
It handles empty option and vote arrays without an error.
An empty option array produces an empty record.
Duplicate option IDs violate the model contract and require no recovery behavior in this issue.

Option IDs are arbitrary nonempty strings.
Counting must handle names such as `__proto__` and `constructor` as ordinary keys without changing an object's prototype.
Consumers use the `options` array for display order, not record key order.
Winner selection and ties remain results-view decisions.

## Example

```json
{
  "question": "Where should we eat lunch?",
  "options": [
    { "id": "pizza", "label": "Pizza" },
    { "id": "salad", "label": "Salad" },
    { "id": "soup", "label": "Soup" }
  ],
  "votes": [
    { "optionId": "pizza" },
    { "optionId": "salad" },
    { "optionId": "pizza" }
  ]
}
```

The derived totals are `pizza: 2`, `salad: 1`, and `soup: 0`.
The poll contains only strings, arrays, and plain objects.
A JSON serialization round trip preserves its values without custom conversion.
No storage key, storage adapter, or migration format is part of this issue.

## Alternatives considered

A counter on each option uses fewer vote records but does not retain individual votes.
Separate vote records match the issue's named concepts and keep totals derived from one source.

A normalized store with separate poll, option, and vote maps adds references that one local poll does not need.
Nested options and votes keep the current model small.
A class-based model adds constructors and serialization rules without a requirement for them.
Plain TypeScript interfaces fit the existing app.

## Acceptance and verification

1. `src/poll.ts` exports `Poll`, `PollOption`, `Vote`, and `countVotesByOption` with the specified contract.
2. The model has no DOM, storage, network, or runtime library dependency.
3. Counting produces zero for options without votes and the correct total for repeated matching votes.
4. Counting ignores unknown option IDs and produces an empty record for an empty option collection.
5. Equal labels with different IDs receive independent totals.
6. Counting handles special object-property names and does not change the input.
7. A representative poll retains its data through a JSON serialization round trip.
8. The existing app shell remains unchanged.
9. `npm run check` and `npm run build` succeed.

Automated tests are appropriate for the counting behavior because incorrect totals affect future results.
Tests must cover empty data, repeated votes, unknown IDs, duplicate labels, special IDs, and input preservation.
The implementation plan can choose a small test setup compatible with the existing TypeScript tooling.
Direct inspection covers the export contract and scope boundaries.
A representative JSON round trip verifies the serialization constraint.
Tests that only assert document text or static configuration are not necessary.

## Review and approval boundary

The builder review uses direct self-review without delegated agents.
The review checked the contract against the issue, project brief, and future feature descriptions.
It found no unresolved product decision that prevents an implementation plan.
ID generation, test tooling, and internal counting mechanics remain builder choices within this contract.

Human review can revise the proposed names and model choices before merge.
This specification requires a ready-for-review planning pull request and human merge.
No implementation plan or product code belongs in this change.
