# LifeOS Multi-Agent Architecture & Coordination Guide

This document defines the agent roles, coordination protocol, ownership boundaries, and operational standards for developing LifeOS — a personal JARVIS-style assistant for Aditya Madala.

---

## 1. Team Ownership & Mission

| Agent / Lead | Scope & Directories | Core Responsibilities |
| :--- | :--- | :--- |
| **Claude Code** | `services/api/`<br>`docs/api.openapi.yaml` | Backend lead: NestJS, Prisma, PostgreSQL, API contracts, migrations, data isolation, sync connectors (Google Classroom, Gmail). |
| **Codex** | `apps/mobile/`<br>`android/` | Android/Flutter lead: Flutter UI, Riverpod, Drift/SQLite, Kotlin native bridge, alarms, full-screen call reminders, TTS speech. |
| **Backend QA** | `.claude/agents/backend-qa.md` | Automated verification of API endpoints, Prisma migrations, data isolation, idempotency, retry mechanisms, and contract fidelity. |
| **Android QA** | `.codex/agents/android-qa.toml` | Flutter analysis, widget tests, Drift database migrations, Kotlin platform channel alarm tests, offline persistence. |
| **Integration QA**| `.codex/agents/integration-qa.toml` | End-to-end integration: Classroom/Gmail import -> Inbox approval -> Today agenda -> Native call reminder & TTS verification. |

---

## 2. Shared Delivery & Handoff Protocol

Claude Code and Codex collaborate across different sessions and environments. To avoid divergence:

1. **Session Startup**:
   - Inspect Git status and current branch/worktree.
   - Read `docs/HANDOFF.md` for the latest milestone state, agreed OpenAPI contract version, and blocking items.
   - Verify counterpart instructions (`CLAUDE.md` and `CODEX.md`).

2. **OpenAPI Contract as Single Source of Truth**:
   - `docs/api.openapi.yaml` governs all client-server interactions.
   - Claude proposes or updates schemas with realistic request/response fixtures.
   - Codex reviews contract updates against UI states before integration.
   - Breaking contract changes require documented migration paths, fixture updates, and mutual agreement in `docs/HANDOFF.md`.

3. **Handoff Documentation (`docs/HANDOFF.md`)**:
   - At the conclusion of every milestone or active session, the owning lead appends an entry containing:
     - Date & Time (Asia/Kolkata)
     - Owning Lead / Agent
     - Current Milestone
     - Git Commit / Worktree hash
     - Contract Version
     - Changed Paths
     - Validation Commands & Results
     - Pending Real-Device / Emulator Checks
     - Blockers & Next Owner

4. **Bounded Subagent Loop**:
   - **Plan**: Define isolated slice, deliverable, and acceptance criteria.
   - **Delegate**: Launch read-only QA subagents with isolated target paths.
   - **Synthesize**: Review repro steps, error codes, and affected paths.
   - **Remediate**: The designated lead applies fixes within their own ownership boundary.
   - **Verify**: Rerun checks and document evidence.

---

## 3. Core Architectural Principles

- **Offline-First Resilience**: Routine schedules, wake alarms, water logging, meal photos, and local task tracking must function flawlessly without internet connectivity using Drift/SQLite on Android.
- **Privacy & User Isolation**: Personal health data, raw meal photos, and non-coursework emails are never leaked to external AI models. All server-side data is strictly scoped to the user ID.
- **Call-Style Reminders**: Timed tasks trigger Android full-screen ringing alerts with the signature teal orb, spoken text after answer, snooze/dismiss, and quick inline actions (e.g., editable water logging).
- **Idempotency & Stable IDs**: Coursework imports and task approvals use deterministic IDs derived from source accounts and items to guarantee zero duplicate tasks upon repeated sync.
