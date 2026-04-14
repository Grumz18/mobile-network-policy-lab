# LLM Checkpoint Protocol

## Purpose
This file defines how prompts, checkpoints, handoff, and project state must be written.

## Core Model
Prompts are checkpoints.
Each checkpoint is a bounded unit of work with:
- a start condition
- an end condition
- concrete artifacts
- updated current state
- declared next step

## Mandatory Checkpoint Format
Use this exact structure:

### CHECKPOINT_ID
Unique id such as `CP-001`.

### TITLE
Short stable title.

### CURRENT_STATE
What is already true before work starts.

### TARGET_STATE
What must be true when this checkpoint is complete.

### IN_SCOPE
What is allowed in this checkpoint.

### OUT_OF_SCOPE
What must not be touched in this checkpoint.

### REQUIRED_ARTIFACTS
Files, folders, code, docs, configs, tests, or scripts expected at the end.

### EXECUTION_NOTES
Important assumptions, constraints, and environmental facts.

### COMPLETION_TEST
How to verify the checkpoint is complete.

### RESULT
One of:
- complete
- partial
- blocked

### WHAT_CHANGED
What was created or modified.

### REMAINING_GAPS
What is still missing inside this checkpoint, if any.

### NEXT_CHECKPOINT
The immediate next logical step.

## Mandatory Prompt Reading Rule
Before acting, the LLM must parse the prompt in this order:
1. checkpoint id
2. current state
3. target state
4. in scope
5. out of scope
6. required artifacts
7. completion test

If any of those are missing, the LLM must infer conservatively and state the inference.

## Partial Completion Rule
If the checkpoint is not fully completed:
- do not mark it complete
- write `RESULT: partial`
- identify the exact blocking reason
- preserve all useful progress

## Retry Rule
If the same checkpoint is retried:
- do not restart blindly
- first read CURRENT_STATE and WHAT_CHANGED
- continue from the latest valid artifact
- avoid duplicate files and duplicated reasoning

## File Update Rule
At the end of each checkpoint, update:
- the checkpoint file itself
- the global project state file, if it exists

## Naming Convention
Use predictable names:
- `PROJECT_STATE.md`
- `checkpoints/CP-001.md`
- `checkpoints/CP-002.md`

## Handoff Block
Every finished checkpoint must end with a handoff block:

```md
## HANDOFF
Current checkpoint status: <complete|partial|blocked>
Safe next action: <one exact next step>
Artifacts created or updated:
- <file>
- <file>
Known risks:
- <risk>
Resume from:
- <file>
```

## Checkpoint Authoring Rule
A checkpoint should be small enough that:
- one session can finish it
- verification is unambiguous
- rollback is easy

## Forbidden Behavior
- silent scope expansion
- silent renaming of core concepts
- declaring success without artifacts
- mixing multiple large milestones into one checkpoint
- rewriting project direction inside an execution response
