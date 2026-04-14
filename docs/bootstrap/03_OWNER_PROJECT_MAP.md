# Owner Project Map

## What This Project Is
This project is a personal engineering and research build.
The goal is not mass deployment.
The goal is to learn deeply, build a serious system, and preserve continuity across sessions and across LLMs.

## What Is Being Built
A mobile networking lab with:
- Android-first client
- fork-based development path
- policy-driven routing
- server-controlled infrastructure
- CI/CD and Docker support
- checkpoint-based execution model

## Why Three Core Files Exist
`01_LLM_OPERATING_CONTRACT.md` tells any LLM how it must behave.
`02_LLM_CHECKPOINT_PROTOCOL.md` tells any LLM how to read and write work units.
This file tells the owner what the project currently is and how to steer it.

## How To Use The System
When starting a new session:
1. provide the three core files
2. provide the latest `PROJECT_STATE.md`
3. provide the latest unfinished or next checkpoint file
4. ask the LLM to work only on that checkpoint

## What A Good Prompt Looks Like
A good prompt is one checkpoint.
It must say:
- what already exists
- what must exist after this step
- what is allowed
- what must not be touched
- how completion is verified

## What To Watch For
A model is going off course if it:
- starts redesigning everything
- skips the current checkpoint
- claims success without files or code
- mixes future work into the current task
- forgets to update state and handoff

## Minimal Operational Loop
Create or update one checkpoint.
Run one bounded implementation step.
Verify the result.
Update state.
Move to the next checkpoint.

## Recommended Core Files To Add Next
- `PROJECT_STATE.md`
- `checkpoints/CP-001.md`

## Current Direction
Start from repository initialization.
Then define project state.
Then define the first executable checkpoint.
Then move into environment setup, server skeleton, Android fork integration, and later policy routing and diagnostics.

## Project Standard
This project should always remain:
- resumable
- auditable
- modular
- checkpoint-driven
- documented well enough for handoff to another LLM

## Owner Reminder
Do not ask for large ambiguous jumps.
Ask for one finished block at a time.
