# Skills-first kernel test environment

This disposable repository contains the Patchmill poll-app fixture and 12 GitHub issues.
The environment pins Patchmill to commit `951e24c359fc8dafca10814e0b60160bcc547035` on `architecture/skills-first-kernel`.
The input fetches that published commit from GitHub. The lock records its exact revision and content hash.
The repository is public: https://github.com/rochecompaan/patchmill-test-skills-kernel.

The shell includes Patchmill, Node.js 24, npm, Git, and the GitHub CLI.
Shell entry does not call a model or change issue labels.
Patchmill credentials, installed skills, run records, and worktrees stay in ignored local directories.

Enter the environment:

```sh
cd ~/projects/patchmill-test-skills-kernel
devenv shell
```

Alternatively, run `direnv allow` in this directory to enable automatic shell entry.

Before the first live test, authenticate Pi and select a model:

```sh
patchmill auth
```

Patchmill opens its provider login selector.
Complete provider login, then choose a model in the model picker.
The command saves your selection and returns to your shell.
Authentication uses this repository's isolated `.patchmill/pi-agent` directory.
Do not commit credentials or copy them into tracked files.

Doctor and triage call the configured model and can incur costs.
Both triage commands process candidate issues, not just issue 1.
Run the live preflight and triage when you are ready:

```sh
patchmill doctor
patchmill triage --dry-run
patchmill triage
```

The triage dry run prints proposed labels and comments without applying them.
The final triage command applies them to the disposable repository.

Inspect the next attempt without calling a model:

```sh
patchmill run-once --dry-run
```

Planning and implementation call models, push branches, and can create or update pull requests.
Choose a fresh ready issue for the merge-gate test. Replace `N` below with its number.
Issues started under the older label-based flow need manual branch and PR review; do not reset their labels or delete their worktrees automatically.
Run the chosen issue's planning phase:

```sh
patchmill run-once --issue N --plan-only
```

This repository keeps its required spec gate enabled. The plan gate is off.
Both gates default off in a newly initialized repository.
Review the spec PR from `agent/issue-N--spec`. Its body must use `Refs #N`, not a closing reference.
The issue stays `in-progress` while that PR is open. Rerunning then must not start Pi.

Merge the spec PR through GitHub, then resume:

```sh
patchmill run-once --issue N
```

Do not add approval labels. Review approval without merge does not unlock a gate.
The resumed run creates the implementation branch from the fetched base, writes the plan, and implements.
Only the implementation PR may close the issue.
To test two planning stops, set `workflow.planApproval.required` to `true` before starting a fresh issue.
Then merge the spec PR, rerun, merge the plan PR, and rerun for implementation.
With both gates off, both documents go into the implementation PR without a planning PR.

Inspect the resulting pull request, issue labels, and files in `.patchmill/runs`.
No live model calls form part of environment setup.
