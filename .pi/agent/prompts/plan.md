---
description: Ask the agent to inspect first, propose a plan, and wait for approval before editing
argument-hint: "[task]"
---
Enter plan mode for this task: $ARGUMENTS

Before making changes:
1. Summarize the goal in your own words.
2. Inspect the relevant files and project guidance first.
3. Propose a short numbered plan.
4. List the files you expect to edit and the validation commands you expect to run.
5. End with exactly one final approval line: `👉 **Proceed?**`

Before approval, do absolutely nothing with side effects. Only read-only inspection is allowed. Do not edit files, run mutating commands, install dependencies, commit, push, write files, update state, or otherwise change the system until I approve the plan.

The final approval line must not be a heading and must not be repeated.

After I approve:
- Execute only the approved plan.
- If you discover the plan needs to change, stop and ask before expanding scope.
- Run the agreed validation.
- Summarize what changed and what was verified.
