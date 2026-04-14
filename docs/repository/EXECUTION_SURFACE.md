# Repository Execution Surface

## Purpose
This document defines which repository areas are active execution surfaces during the current project phase.
It exists to keep future sessions from mixing bootstrap work with server or Android implementation.

## Active Root-Level Surfaces

| Path | Role | Current Status | Allowed Work In This Phase |
| --- | --- | --- | --- |
| `PROJECT_STATE.md` | Global project state and continuity anchor | Active | Update only when a checkpoint changes the known repository state |
| `README.md` | Human and LLM entry point | Active | Keep aligned with checkpoint-driven workflow |
| `checkpoints/` | Bounded execution units | Active | Add or update one checkpoint at a time |
| `docs/bootstrap/` | Authoritative LLM operating guidance | Active | Read before any checkpoint work; do not rewrite casually |
| `docs/repository/` | Repository governance and structure docs | Active | Document repository execution boundaries |
| `docs/development/` | Local developer bootstrap docs | Active | Document workstation setup and verification flow |
| `scripts/` | Safe local helper scripts | Active | Add bootstrap and verification helpers only |

## Reserved Implementation Surfaces

| Path | Intended Use | Current Status | Restriction |
| --- | --- | --- | --- |
| `server/` | Server-side application and control-plane work | Reserved | No implementation until a server checkpoint is active |
| `android/` | Android client and fork integration work | Reserved | No implementation until an Android checkpoint is active |
| `ios/` | iOS-related work if later needed | Reserved | No implementation in the current phase |
| `infra/` | Deployment, environment, and container support | Reserved | No runtime infrastructure implementation in the current phase |
| `.github/` | Repository automation and CI/CD | Reserved | No CI/CD implementation in the current phase |

## Root Policy Files
The following root-level files govern repository bootstrap behavior:

| File | Role |
| --- | --- |
| `.editorconfig` | Baseline text formatting policy for repository files |
| `.gitignore` | Baseline ignore policy for local noise and generated files |
| `.env.example` | Non-secret example variables for local bootstrap context |

## Change Routing Rules
- Governance and continuity changes belong in `PROJECT_STATE.md`, `README.md`, and `checkpoints/`.
- Repository structure and workstation guidance belong in `docs/repository/` and `docs/development/`.
- Safe local helper automation belongs in `scripts/`.
- Product code must not be introduced into `server/`, `android/`, `ios/`, `infra/`, or `.github/` unless an active checkpoint explicitly authorizes it.

## Pre-Implementation Gate
Before any server or Android checkpoint begins, a future session should confirm:
- the active checkpoint authorizes implementation in that surface
- local bootstrap verification has passed
- the repository state and checkpoint handoff agree on the next action
