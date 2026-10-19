# Team Lunch Poll Scaffold Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use the sibling `executing-plans` skill to implement this plan inline, task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. Kernel runs do not require subagent tools.

**Goal:** Provide a static Team Lunch Poll shell and a documented local development workflow.

**Architecture:** Use Vite with vanilla TypeScript at the repository root. The HTML entry contains the semantic shell, and the TypeScript entry imports plain CSS. No application state or backend is necessary.

**Tech Stack:** Node.js 24, npm, stable compatible Vite and TypeScript, HTML, plain CSS.

**Spec:** `docs/specs/2026-10-19-issue-1-create-the-team-lunch-poll-app-scaffold-design.md`

## Global Constraints

- The browser tab title and the single level-one heading are `Team Lunch Poll`.
- A main landmark contains the heading, description, and two placeholder sections.
- The first section has the level-two heading `Create a poll`.
- The second section has the level-two heading `Poll results`.
- These sections contain no forms, mock results, or inactive buttons.
- At a viewport width of 320 CSS pixels, all text and both sections remain visible without horizontal scrolling.
- The page requires no external fonts, images, or services.
- The TypeScript configuration uses strict type checks.
- The implementation selects compatible stable package versions for Node.js 24 and records them in the lockfile.
- The README retains the existing project context and Patchmill demo instructions.
- No environment variables, credentials, or database setup are necessary.

Poll creation, voting, results calculation, storage, routing, authentication, deployment, and component libraries remain outside this issue.
Keep existing Patchmill configuration, environment files, issue prompts, and `E2E.md` unchanged.

## Review Focus

These five conditions use direct verification in Task 1, not maintained automated tests:

1. A clean Node.js 24 installation reproduces the dependency tree from the lockfile (Step 5).
2. At 320 CSS pixels, long placeholder text wraps without horizontal scrolling (Step 7).
3. Browser zoom and desktop widths preserve readable text and the semantic heading order (Step 7).
4. A production preview loads its stylesheet and module without app errors or external service dependencies (Step 8).
5. A new contributor can use the README without losing the existing Patchmill instructions (Steps 4 and 9).

## Verification Choice

The Testing Value Gate excludes tests that only assert static text, configuration, or dependency versions.
This scaffold contains no interactive production behavior, parser, API contract, or security boundary that needs an automated regression test.
Do not add a test runner or static-content snapshots.
Use dependency installation, TypeScript checks, builds, browser inspection, and a README walkthrough instead.
Future poll behavior needs its own automated tests.

## File Map

| Path | Action | Responsibility |
| --- | --- | --- |
| `package.json` | Create | Private npm package, dependency declarations, and contributor commands. |
| `package-lock.json` | Create | Reproducible npm dependency tree. |
| `tsconfig.json` | Create | Strict, browser-targeted TypeScript checks without output. |
| `index.html` | Create | English document, viewport metadata, title, and semantic static shell. |
| `src/main.ts` | Create | Browser module entry that imports `./style.css`. |
| `src/style.css` | Create | Readable colors, spacing, and responsive normal-flow layout. |
| `src/vite-env.d.ts` | Create | Vite client types, including stylesheet imports. |
| `README.md` | Modify | App prerequisites and commands, alongside existing demo instructions. |

The existing `.gitignore` already excludes `node_modules/` and `dist/`. Keep those rules without duplicate entries.
Vite defaults are sufficient. Do not add a Vite configuration file or scaffold generator artifacts.

---

### Task 1: Deliver the runnable shell and contributor workflow

This is one reviewable deliverable: the static page, build setup, and instructions must work together.

**Files:** Create and modify the files listed in the File Map. No automated test files are necessary.

**Interfaces:**
- Consumes: Node.js 24 and npm from the existing development environment.
- Produces: `index.html` loads `/src/main.ts` as a module, and `src/main.ts` imports `./style.css`.
- Produces: `dev` → `vite`, `check` → `tsc --noEmit`, `build` → `npm run check && vite build`, `preview` → `vite preview`.
- Produces: `dist/` as generated production output, never committed.
- No exported functions or domain types are necessary for this static shell.

- [ ] **Step 1: Establish the starting point.**
  Run `git status --short`, `node --version`, and `npm --version`.
  Expected: no unexpected edits, Node.js `v24.x`, and a working npm command.
  Read the specification and existing README before changes.
  Record the initial commit and verification evidence in the execution ledger.

- [ ] **Step 2: Create the package and TypeScript configuration.**
  Set the package name to `team-lunch-poll`, with `private: true`, `type: "module"`, and `engines.node: ">=24"`.
  Add the four scripts from the Interfaces block.
  Select stable Vite and TypeScript releases that support Node.js 24 as development dependencies.
  Configure TypeScript with `target: "ES2022"`, `module: "ESNext"`, and `moduleResolution: "Bundler"`.
  Use `lib: ["ES2022", "DOM", "DOM.Iterable"]`, `strict: true`, `noEmit: true`, and `include: ["src"]`.
  Add `/// <reference types="vite/client" />` to `src/vite-env.d.ts`.

- [ ] **Step 3: Create the static shell and stylesheet.**
  Set `lang="en"`, UTF-8 encoding, and `width=device-width, initial-scale=1.0` viewport metadata in `index.html`.
  Add the exact title and heading from Global Constraints.
  Use the description `Help your team decide where or what to eat together.`
  Under `Create a poll`, explain that a future form accepts a lunch question and meal or restaurant options.
  Under `Poll results`, explain that future results show teammate votes and the current winner.
  Keep all content inside one `main`, with two semantic sections and their level-two headings.
  Create `src/main.ts` with the stylesheet import.
  Use system fonts, readable contrast, flexible widths, border-box sizing, and normal document flow in `src/style.css`.
  Avoid fixed minimum widths and unnecessary controls, assets, dependencies, or demo content.

- [ ] **Step 4: Document the workflow in `README.md`.**
  Retain the project context, Demo workflow, and Source of truth sections.
  Replace only the obsolete claim that the repository contains documentation and prompts only.
  Add an app section with Node.js 24 and npm prerequisites, and commands from the repository root.
  Document `npm install`, `npm ci`, `npm run dev`, `npm run check`, `npm run build`, and `npm run preview`.
  Explain each command's purpose, the printed local URL, and Ctrl+C to stop either server.
  State that preview requires a production build first.
  State that credentials, environment variables, and a database are unnecessary.

- [ ] **Step 5: Generate and exercise the lockfile.**
  Run `npm install`, then `npm ci`.
  Expected: both exit zero on Node.js 24, and `package-lock.json` records the dependency tree.
  Inspect `git status --short --ignored`.
  Expected: dependencies remain ignored, and no unrelated generator artifacts exist.

- [ ] **Step 6: Run the contributor checks.**
  Run `npm run check` and `npm run build`.
  Expected: both exit zero, and the build creates `dist/index.html` plus local assets.
  Inspect the script definitions to verify that `build` runs TypeScript checks before Vite.

- [ ] **Step 7: Inspect the development page in a browser.**
  Run `npm run dev` and open the printed URL.
  Expected: the server starts and prints its local URL.
  Inspect at 320 CSS pixels and at a desktop width of 1280 CSS pixels.
  Inspect at 200% browser zoom, including all content after vertical scrolling.
  Expected: readable text, both visible sections, and no horizontal scrolling or overlapping content.
  Verify one `main`, one `h1`, and the two ordered `h2` headings through browser accessibility or DOM inspection.
  Verify the title, description, placeholder meanings, contrast, and absence of starter demos or misleading controls.
  Expected: no app errors in the browser console and no external font, image, or service requests.
  Stop the server with Ctrl+C.

- [ ] **Step 8: Inspect the production preview.**
  Run `npm run preview` after the successful build and open its printed URL.
  Expected: the same shell, readable styles, successful local asset requests, and no app errors in the console.
  Stop the preview server with Ctrl+C.
  Record browser inspection results in the execution ledger. Do not claim unavailable browser checks as passed.

- [ ] **Step 9: Review and commit the deliverable.**
  Walk through the README commands and compare their descriptions with the observed outputs.
  Review the full diff against the specification and all five Review Focus conditions.
  Run `npm run check && npm run build` and `git diff --check`.
  Expected: exit zero, no whitespace errors, and all specification acceptance items have recorded evidence.
  Stage only the File Map paths and this plan's checkbox updates.
  Commit with `git commit -m "feat: add Team Lunch Poll app scaffold"`.
  Expected: a focused implementation commit without dependencies, build output, secrets, or unrelated tooling changes.

## Execution Handoff

The kernel starts implementation in a separate session on this same branch.
Use the sibling `executing-plans` skill and its ledger for inline execution.
Apply the Testing Value Gate exception stated here instead of static-content TDD.
Complete a separate whole-branch self-review without requiring subagent tools.
Follow the implementation session's envelope for push and implementation PR publication.
Do not create another planning PR or wait for a planning merge.

## Plan Self-Review

The single task covers all ten specification acceptance items.
The interfaces match the file map and npm commands.
All five Review Focus conditions have explicit direct verification steps.
No application behavior, dependency versions, or static text requires a maintained automated test in this issue.
The merged specification PR (#13) has no review comments or unresolved decisions.
