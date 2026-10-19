# Team Lunch Poll

Team Lunch Poll is a small greenfield demo app for trying Patchmill on a safe,
disposable repository.

The app should let a team create a lunch poll, add meal or restaurant options,
vote on those options, and see the current winner. The repository now includes a
static app shell with placeholders for poll creation and results. Those features
are not implemented yet. Patchmill agents build the application from the seeded
issues.

## Run the app

Prerequisites: Node.js 24 and npm. The app uses Vite with vanilla TypeScript and
plain CSS. No environment variables, credentials, or database setup are needed.

Run these commands from the repository root:

| Command | Purpose |
| --- | --- |
| `npm install` | Install dependencies for local development. |
| `npm ci` | Install the exact dependencies from the committed lockfile (clean install). |
| `npm run dev` | Start the local development server. Open the local URL it prints. |
| `npm run check` | Run strict TypeScript checks without generating output. |
| `npm run build` | Run TypeScript checks, then build production files into `dist/`. |
| `npm run preview` | Serve the production build locally. Run `npm run build` first, then open the printed local URL. |

Use Ctrl+C to stop either the development or preview server. The checks for this
static scaffold are TypeScript checking, the production build, and browser
inspection; there is no automated test suite yet.

## Demo workflow

After this repository is seeded, try Patchmill manually:

```bash
patchmill init
patchmill triage --dry-run
patchmill triage
```

## Source of truth

This repository is disposable. The reusable project brief and issue prompts live
in the Patchmill package under `fixtures/patchmill-test-repo/`.
