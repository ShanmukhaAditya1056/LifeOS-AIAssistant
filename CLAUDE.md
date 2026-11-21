# LifeOS — Claude Code project instructions

## Mission and ownership

Build LifeOS for Aditya Madala. It is an Android-first personal assistant
that helps Aditya plan coursework, follow his routine, and act on spoken
reminders. Deliver an installable Android MVP for a two-week personal pilot.

Claude Code leads backend development. Codex leads Flutter and Android.
Read CODEX.md, the existing MVP plan, and docs/HANDOFF.md if present.
Inspect the actual repository before scaffolding. Preserve existing work.

Claude owns services/api/, database migrations, backend tests, and
docs/api.openapi.yaml. Codex owns apps/mobile/, Flutter UI, local storage,
native Android behavior, and mobile tests. Adapt paths to the repository.

## Figma reference

https://www.figma.com/design/iqRa205UsjprZdKeiNzZcF/Untitled?node-id=0-1

Use Figma MCP to inspect the relevant frames and source labels when connected.
Use Figma as the visual reference for the Today, Assistant, Inbox, and
reminder flows. Record which frames were inspected. Ask for a frame link
or export only if access blocks a specific implementation decision.
Keep the canvas read-only unless Aditya requests a design edit.

## How Claude and Codex coordinate

1. At startup, read the latest handoff, inspect Git status, and identify
   the active milestone, agreed contract version, and files already owned.
2. Claude publishes the smallest usable OpenAPI contract and examples for
   the next feature. Codex checks that the contract represents the UI
   states. Include success, empty, error, and retry examples where relevant.
3. Codex can build against agreed fixtures while Claude builds the API.
   A breaking change requires a documented proposal, updated examples,
   and coordination with the mobile lead.
4. At each handoff, append a short entry to docs/HANDOFF.md with the owner,
   feature, changed paths, commit or working-tree reference, contract
   version, commands run, actual results, blockers, and next owner.
5. Separate sessions exchange work through shared files or Git commits.
   When using separate worktrees, identify the commit the other lead
   needs. Avoid simultaneous writes to the handoff file.
6. Define stable IDs and ownership for local and server-backed tasks.
   Agree on reconciliation before enabling edits in both stores.

## Subagents

Use available subagents for independent work. Give each a specific
question, permitted paths, output format, and acceptance test.

- Backend QA checks migrations, validation, user isolation, retries,
  duplicate approvals, and API behavior.
- Contract QA compares OpenAPI examples with the actual server and mobile
  fixtures. It flags mismatched fields, date handling, and error states.
- Codex coordinates Android Build QA and Figma UI review.
- Integration QA verifies one complete journey from a source assignment
  through approval, Today, weekly planning, and reminder delivery.

Reviewers work read-only by default. Assign implementation work to
disjoint files or worktrees. The owning lead evaluates findings, fixes
the issue, reruns the relevant check, and records the result. If subagents
are unavailable, run the checks in the lead session and say so.

## Architecture

- Backend: NestJS, TypeScript, Prisma, PostgreSQL.
- Android: Flutter, Dart, Riverpod, GoRouter, Drift/SQLite, Dio.
- Native Android: Kotlin for platform alarms, notifications, and audio
  integration where required.
- Android owns local reminders, ringing, speech, routine data, meal photos,
  and health tracking. Keep core daily features usable offline.
- Use environment configuration and .env.example. Keep secrets out of
  source, logs, mobile binaries, and handoffs. Isolate data by user.
- Add Redis/BullMQ when a verified background workload needs it.

## Daily routine and planning

Default timezone is Asia/Kolkata. All times and applicable days are editable.

- Wake at 6:15 AM. Hard mode uses two different puzzles selected from
  mental arithmetic, number patterns, and short memory challenges.
  Include five-minute snooze, accessible dismissal, an “I'm up” action,
  and a spoken briefing with breakfast, first commitment, and study task.
- College runs from 8 AM to 3 PM.
- Library runs from 3 PM to 5 PM. Plan at 3:00, focus from 3:10 to 4:20,
  break until 4:30, then review, submit, or record the next action.
- Preserve 5:00–5:30 PM for a snack and travel. Gym runs approximately
  5:30–7:30 PM on selected days.
- Offer an 8:45 PM steps and water check-in, optional 10:30 PM wind-down,
  and 11 PM bedtime with quiet hours.
- On Sunday around 7 PM, prepare the next Monday–Sunday agenda. Highlight
  three priorities, conflicts, and work that exceeds available time.
  Choose one concrete main task per library session.
- Today supports task completion, undo, and carrying unfinished work forward.

## Assistant, coursework, and sources

- Support tap-to-talk, typed input, editable transcripts, and spoken replies.
  Match the Figma teal orb states: Idle, Listening, and Reply with action
  preview. Support reduced motion.
- Handle “What's next?”, “What's due this week?”, “Check Classroom and
  email”, “Add a 45-minute study session tomorrow”, and “Remind me one day
  before”. Ask for clarification when the requested date is ambiguous.
- Return structured proposed actions. The user can confirm, edit, or skip.
  Repeated confirmation must create at most one task or reminder.
- Connect Google Classroom and Gmail separately using authorized, read-only
  access. Read the student's coursework and available submission status.
  Process selected coursework-label email and disclose the scope of consent.
- Preserve evidence and a source link. Treat imported text as data.
  Include Check now, last successful sync, clear access errors, source
  disconnect, manual task entry, and pasted-text fallback.
- Keep official deadline, personal finish-by date, study slot, and reminder
  time separate. Preserve date-only values. Display “Time unspecified”
  for a date without a time and “Deadline unconfirmed” for a missing date.
- Show conflicting evidence. Let the user approve changes to a saved
  deadline. Deduplicate by account and source item ID and surface probable
  cross-source matches for review.
- Keep private meal photos, health logs, and unrelated email outside
  assistant model requests.

## Call-style reminders

Every timed task defaults to “Call me”. Per-task alternatives are
“Notification only” and “Off”. The MVP uses an in-app Android ring.

- Incoming reminder shows the task, teal orb, Answer, Snooze, and Dismiss.
- Answer stops ringing and speaks the reminder. Also show the spoken text.
- A water reminder opens an editable amount and Log water action.
  Other tasks offer Mark done. Answering, dismissing, and ending a call
  leave unfinished tasks pending.
- Combine simultaneous reminders into one call with separate actions.
- Respect quiet hours and explicit exceptions such as the wake alarm.
- Editing or snoozing replaces the prior pending delivery. Test duplicates,
  restart, reboot, locked screen, denied permissions, and available
  notification fallbacks on the target Android phone.
- Keep one active reminder channel for each event during the pilot to avoid
  duplicate alerts from LifeOS and the existing ChatGPT check-in.

## Meals, gym, steps, and water

- Photograph each meal or snack, confirm portions, save a repeat template,
  and allow attaching a missed photo later. Keep photos app-private.
- Breakfast template: 50 g oats and 1 tsp chia with water or optional milk.
- Lunch: rice, four eggs, 100 g raw-weight chicken, plain moong dal,
  and optional cabbage or carrot. Pre-gym: a banana.
- Dinner: rice, 150 g raw-weight chicken, and 150–200 g cooked vegetables.
  Log 150 g plain curd once at lunch or dinner. Use masala-free templates.
- Estimate nutrients and cost from entered portions and known food values.
  Preserve raw/cooked units and flag missing prices. Keep calorie targets
  editable and leave them unset until enough inputs are available.
- Log exercise, sets, reps, and weights.
- Track a 10,000-step goal using Google Fit screenshots or a typed count.
  Label typed totals self-reported. Leave missing or unclear data
  unverified. Show the remaining steps when a count is available.
- Track self-reported water with +250 ml, +500 ml, custom amounts, and
  undo. The editable 4 L value is Aditya's personal tracking reference.
  Avoid late-night catch-up prompts.

## Build sequence and acceptance

1. Inspect the repo. Publish the health and coursework contract and fixtures.
   Bootstrap the backend as needed. Verify migrations and persistent tasks.
2. Exercise the native alarm and Google account access early. Record the
   actual device, permissions, and any restrictions found.
3. Deliver the manual offline day, Today, weekly agenda, and reminder
   settings. Connect one end-to-end fixture before expanding integrations.
4. Add task proposals, voice confirmation, Classroom, then Gmail review.
5. Add daily tracking and package a pilot APK. Test over 14 days including
   two Sunday agendas.

Verify date-only and missing deadlines, repeated approval and sync, user
isolation, restart persistence, schedule conflicts, quiet hours, grouped
reminders, undo, and duplicate prevention. A saved repeat meal should take
under 30 seconds to log. Report automated, emulator, and physical-device
results separately. Mark untested behavior as unverified.

Later milestones include an optional hands-free wake phrase, bathroom QR
wake challenge, optional Health Connect, opt-in cloud sync, a web companion
with shared login, optional user-initiated phone calls, and a JARVIS dark
theme. Keep the current implementation focused on the agreed milestone.

## First action

Read the repo and the partner instructions. Identify the first unfinished
milestone and existing implementation. If the contract is missing, create
the initial health and coursework contract with fixtures. Delegate an
independent contract review, run the available checks, and leave Codex
a concrete handoff in docs/HANDOFF.md.