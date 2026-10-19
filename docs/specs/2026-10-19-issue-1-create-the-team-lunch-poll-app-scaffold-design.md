# Team Lunch Poll scaffold design

## Purpose

Issue #1 needs a working starting point for contributors to the Team Lunch Poll app.
The product helps teams choose where or what to eat through a poll.
This issue provides only the app shell and the local development setup.

## Current state

The repository contains a project brief, issue prompts, and tooling for the Patchmill demo.
There is no app, package manifest, or existing frontend framework.
The development environment provides Node.js 24 and npm.
The issue has no review comments at the time of this specification.

## Goals

- Provide a small TypeScript web app that runs locally.
- Show the product name and a short product description.
- Reserve visible space for future poll creation and results.
- Document dependency installation, local development, and checks.
- Keep the page usable on desktop and mobile screens.

## Scope exclusions

This issue does not include poll creation, voting, results calculation, or browser storage.
It does not include a backend, authentication, routing, deployment, or a component library.
The scaffold must not imply that these future features already work.
The existing Patchmill setup and demo instructions remain intact.

## Technical choice

The proposed default is Vite with vanilla TypeScript, npm, and plain CSS.
This is the planning agent's choice, not an explicit framework preference from the issue author.
Vite provides a development server and a production build without a backend.
Vanilla TypeScript avoids framework dependencies for a page with no interactive behavior.
React with Vite is a reasonable alternative, but this shell does not need a component framework.
A server framework adds features outside this issue's scope.

The app uses the repository root as its package root.
The implementation includes an HTML entry point, TypeScript entry point, stylesheet, TypeScript configuration, and package manifest.
The implementation commits an npm lockfile and excludes dependency directories and generated output from Git.
The TypeScript configuration uses strict type checks.
The implementation selects compatible stable package versions for Node.js 24 and records them in the lockfile.

## App shell

The browser tab title and the single level-one heading are `Team Lunch Poll`.
A main landmark contains the heading, description, and two placeholder sections.
The proposed description is: "Help your team decide where or what to eat together."

The first section has the level-two heading `Create a poll`.
Its placeholder explains that a future form will accept a lunch question and meal or restaurant options.
The second section has the level-two heading `Poll results`.
Its placeholder explains that future results will show teammate votes and the current winner.
These sections contain no forms, mock results, or inactive buttons.
No user input, stored data, network request, or error state is necessary for this static shell.

The page uses semantic HTML, readable text, and sufficient text contrast.
The layout uses normal document flow and adapts to narrow screens without horizontal scrolling.
At a viewport width of 320 CSS pixels, all text and both sections remain visible without horizontal scrolling.
The page requires no external fonts, images, or services.
Colors, spacing, and exact placeholder wording remain builder decisions within these constraints.

## Contributor workflow

The README retains the existing project context and Patchmill demo instructions.
A new app section states the Node.js 24 and npm prerequisites.
It documents these commands from the repository root:

| Command | Purpose |
| --- | --- |
| `npm install` | Install dependencies for local development. |
| `npm ci` | Install the exact dependencies from the committed lockfile. |
| `npm run dev` | Start the local development server. |
| `npm run check` | Run TypeScript checks without generated output. |
| `npm run build` | Run TypeScript checks and create a production build. |
| `npm run preview` | Serve an existing production build locally. |

The README explains that the development server prints its local URL.
It also explains how to stop the server with Ctrl+C.
Preview documentation states that a production build must exist first.
No environment variables, credentials, or database setup are necessary.

## Acceptance and verification

1. A clean installation with `npm ci` succeeds on Node.js 24.
2. The documented development command starts the app and prints its local URL.
3. The page shows the required heading, description, and both labeled placeholder sections.
4. The page has no Vite starter logos, counter, or unrelated demo content.
5. The page remains readable at mobile and desktop widths without horizontal scrolling.
6. The browser console contains no app errors during the page load.
7. Both `npm run check` and `npm run build` succeed.
8. The preview command serves the built app with the same shell content.
9. The README contains the prerequisites and all documented commands.
10. Existing Patchmill configuration and demo instructions remain available.

Verification uses direct document inspection, dependency installation, TypeScript checks, a production build, and browser inspection.
Automated tests that assert static text, configuration, or dependency versions are not necessary for this scaffold.
Future issues can add automated tests for actual poll behavior.

## Review and approval boundary

The issue delegates the setup choice and provides enough detail for this bounded scaffold.
There are no unresolved product questions for this specification.
The builder review found no missing decision that prevents an implementation plan.
This specification requires human review and merge through its planning pull request.
No implementation plan or app code belongs in this specification change.
