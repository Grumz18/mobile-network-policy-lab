# LLM Operating Contract

## Purpose
This file defines the hard operating rules for any LLM working on this project.
It is written for machine execution quality, not for human readability first.

## Project Mission
Build a personal research-grade mobile networking project with:
- Android client based on a forked NekoBox foundation
- NaiveProxy-centered transport strategy
- server-side controlled infrastructure
- per-app routing policy on Android
- reproducible checkpoints, logs, CI/CD, Docker-based deployment
- documentation and handoff quality high enough to continue in any future LLM session

## Non-Negotiable Rules
1. Do not drift from the current checkpoint.
2. Do not redesign the whole system unless the prompt explicitly requests redesign.
3. Do not skip unfinished work and start future work early.
4. Do not hide uncertainty. State assumptions explicitly.
5. Do not claim completion if the requested artifact is not created or changed.
6. Do not expand scope inside a checkpoint.
7. Do not delete existing project intent.
8. Prefer small, auditable changes over broad rewrites.
9. Every output must preserve future continuity.
10. Every output must help the next LLM continue without re-discovery work.

## Work Style
- Work checkpoint by checkpoint.
- Each checkpoint must produce a concrete artifact.
- Each checkpoint must update current state and next state.
- If execution fails, produce a recovery plan instead of pretending success.
- If a task is partially done, label it as partial.

## Required Output Discipline
For any implementation prompt:
- restate the checkpoint id
- restate current known state
- restate requested target state
- perform only the requested scope
- finish with:
  - completed
  - remaining
  - risks
  - next checkpoint suggestion

## Definition of Done
A checkpoint is done only if:
- the requested artifact exists
- the artifact is internally consistent
- the artifact is named predictably
- the current state is updated
- the next likely step is identified

## Anti-Drift Clause
If the prompt conflicts with the current project state:
- do not silently overwrite direction
- explicitly flag the conflict
- propose the smallest valid correction

## Continuity Rule
Assume future sessions will not remember prior context.
Every meaningful output must be understandable using only:
- this file
- checkpoint protocol file
- owner map file
- latest project state file
- latest checkpoint file

## Refusal Rule
Refuse only when the requested task is impossible, unsafe, or contradictory.
Otherwise, do the smallest complete useful part.

## File Priority
When project files disagree, use this order:
1. latest checkpoint file
2. project state file
3. owner map
4. checkpoint protocol
5. this operating contract

## Required Attitude
Be precise, conservative, and explicit.
Optimize for continuity, not cleverness.
