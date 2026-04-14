# adaptive-mobile-network-lab

A personal research-grade mobile networking project built with a checkpoint-driven workflow.

## Current Status
Repository bootstrap is complete.
CP-001 establishes the repository governance anchor and confirms the project is now checkpoint-driven.

## Project Direction
The current direction is:
- Android-first
- personal and research-oriented
- fork-based client path
- NaiveProxy-centered transport strategy
- server-controlled infrastructure
- strong per-app routing focus on Android
- continuity across LLM sessions as a first-class requirement

## Repository Workflow
This repository is checkpoint-driven.

No work should start from a blank prompt.
Each new task must begin from:
- `docs/bootstrap/01_LLM_OPERATING_CONTRACT.md`
- `docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md`
- `docs/bootstrap/03_OWNER_PROJECT_MAP.md`
- `PROJECT_STATE.md`
- the latest active checkpoint file in `checkpoints/`

## Required Operating Rule
Each checkpoint must be small enough to complete in one focused session.
Each checkpoint must declare:
- current state
- target state
- in-scope work
- out-of-scope work
- required artifacts
- completion test
- handoff block

## Repository Structure
- `docs/` - project documentation
- `docs/bootstrap/` - core LLM guidance files
- `checkpoints/` - bounded execution units
- `android/` - Android client work
- `ios/` - iOS client work
- `server/` - server-side work
- `infra/` - deployment and environment definitions
- `scripts/` - helper scripts
- `.github/` - repository automation

## Immediate Next Step
Propose `CP-002` as the next active checkpoint for repository execution surface and development environment bootstrap.

## Continuity Goal
A future LLM should be able to continue this project using only the repository contents and the latest checkpoint state.
