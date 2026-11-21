# LifeOS project instructions

Product owner and in-app display name: Aditya Madala.

Use the existing MVP plan (docs/MVP.md or LifeOS-MVP-Plan.md) together with
this handoff. The shared behavior and product brief below define the current scope. Inspect the repo before choosing paths or scaffolding anything.

Figma design reference: https://www.figma.com/design/iqRa205UsjprZdKeiNzZcF/Untitled?node-id=0-1
Use the Figma MCP read tools to inspect relevant frame links and compare
screenshots with the app. Report missing frames or access errors. The design
was accessible in a signed-in browser; MCP access needs its own sign-in.
The Figma reminder prototype simulates ringing and speech.
Preserve the canvas unless Aditya explicitly asks for Figma edits.

## Shared behavior

- Every scheduled task defaults to Call me. Each task can override that
  with Notification only or Off. Call me means an Android in-app ringing
  reminder with spoken text after Answer.
- Incoming: show the teal LifeOS orb, task title, Answer, Snooze and Dismiss.
  Answered: show the spoken message and actions. Water reminders offer
  Log water with an editable amount. Other reminders offer Mark done.
  Answer, End call and Dismiss leave unfinished tasks pending.
- Group tasks due together in one call while keeping their completion
  separate. Respect quiet hours and explicit exceptions. Keep the 6:15 AM
  wake-up alarm with its two-puzzle hard mode, snooze and accessible dismiss.
- Keep the assistant's Idle, Listening and Reply states. Preview and confirm
  assistant actions before saving. Separate official due dates, study slots,
  finish-by dates and reminders. Flag unknown dates.
- Keep local routine and tracking usable offline. Preserve daily meal photos,
  manual Google Fit totals and editable water tracking. Avoid duplicate
  notifications when the user is already using an external check-in.

## Codex owns Android frontend

Use Flutter, Riverpod, Drift and the Kotlin bridge in the existing mobile
project (apps/mobile/ in the monorepo). Read the reviewed OpenAPI contract
before integration. Use local fixtures for independent UI work. Keep the
Figma layouts, typography, colors and states as the visual reference.

Implement local scheduling and persisted reminder preferences. Check
Android alarm and notification permissions before scheduling and offer a
call-style notification when a full-screen alert is unavailable. Implement
ringing and speech in the app. Handle grouped tasks, quiet hours, snooze,
reboot and schedule edits without duplicate deliveries.

Run Flutter analysis, relevant tests and a debug APK build. Verify incoming
and answered states, pending status after ending, editable water amounts,
and independent completion for grouped tasks. Test locked screen, app
closed and reboot on a real device. Use independent read-only Android Build
QA and Integration QA agents when useful. Report device checks separately
from automated results. The frontend lead applies fixes.

## Shared delivery protocol for Claude Code and Codex

These instructions govern implementation in both clients. Read the counterpart
file, the current OpenAPI contract and docs/HANDOFF.md at session start. Check
git status and existing work before editing. Use separate branches or worktrees
when both leads are active. Share commits and handoffs through Git or explicitly
pass them between sessions. Do not assume the other client can see local changes.

1. Claude owns services/api and docs/api.openapi.yaml. Codex owns apps/mobile
   and Android code. Inspect the actual repo layout before acting. Each lead can
   review both sides. Route fixes to the owning lead.
2. Before parallel work, agree on milestone, branch or worktree, contract commit,
   and acceptance cases. Claude proposes schema and fixtures. Codex reviews
   request/response examples and error states before integration. Use the last
   agreed contract for mocks while the API is in flight.
3. Create docs/HANDOFF.md when implementation starts. Each lead appends its
   own entry with date, owner, milestone, commit, contract version, changed
   paths, commands/results, pending device checks, blockers, and next owner.
   Avoid simultaneous writes to this shared file. For a breaking contract
   change, record the proposal, migration and fixtures, then get the other
   lead's review before switching consumers. If the other lead is unavailable,
   keep the baseline and work on independent tasks.
4. Define explicitly which coursework is local and which is server-backed.
   Use stable IDs, idempotency and source provenance. Define reconciliation
   before enabling edits from both stores.
5. Delegate independent work and collect evidence in the same session. Claude
   delegates API/database QA and contract review. Codex delegates Flutter build
   QA and Figma/Android review. At integration, one independent QA agent checks
   an end-to-end fixture from import through approval, Today, agenda and Android
   reminder. Assign each agent an isolated directory or worktree, allowed paths,
   one deliverable and pass criteria. Default reviewers to read-only source
   access. Grant write ownership only for a disjoint, explicitly assigned slice.
6. Follow a bounded loop: plan, delegate independent checks in parallel, gather
   findings, fix within the lead's scope, rerun failed checks, publish handoff.
   Do not spawn recursive agents or have two agents write the same files. A
   reviewer reports severity, repro, exact command/result, affected path and
   owner. Mark permission, network and real-device checks blocked when applicable.
7. Finish each milestone with actual results and evidence. Keep secrets out of
   logs and handoffs. No push, deployment or external account changes without
   explicit authorization.

## Full product scope

The product brief below carries the complete agreed MVP. The shared behavior at
the top takes precedence for newer reminder and wake-up details.

# LifeOS Android MVP

## Goal
Build a personal JARVIS-style assistant that answers what to do next and turns coursework into an approved plan. Deliver an installable Android APK for a two-week personal pilot. Seed times in Asia/Kolkata and make routine days and times editable.

## Daily experience
- 6:15 AM wake alarm. Solve arithmetic or a sequence, stop the sound, stand up, tap I'm up, then hear the morning briefing. Provide five-minute snooze and an accessible dismiss action. The briefing includes the first commitment, breakfast, and one study action.
- College 8 AM–3 PM. Library 3–5 PM. Plan 3:00–3:10, focus 3:10–4:20, break 4:20–4:30, review or submit 4:30–5:00. Keep the travel and snack buffer before gym around 5:30–7:30 PM on selected days.
- Meals. Snap or attach a photo, confirm portions, then save. Breakfast: 50 g oats and 1 tsp chia, with water or optional milk. Lunch: rice, four eggs, 100 g raw-weight chicken, plain moong dal and optional cabbage or carrot. Pre-gym: banana around 4:45–5 PM. Dinner: rice, 150 g raw-weight chicken and 150–200 g cooked vegetables. Log 150 g plain curd once at lunch or dinner. Use plain ingredients the user tolerates. Save templates and allow photo attachment later. Calculate estimated nutrition and cost from entered amounts and saved food values. Leave personalized calories and incomplete costs unset.
- Log workouts by exercise, sets, reps and weight. Seed 10,000 steps, manually entered from Google Fit. The existing 8:45 PM ChatGPT check-in handles screenshot review and self-reported water. LifeOS uses a matching optional local reminder with a toggle to avoid duplicates.
- Water quick-add +250 ml and +500 ml with undo. The editable 4 L reference is user-selected. Skip catch-up prompts.
- Optional 10:30 PM wind-down, 11 PM bedtime and quiet hours. Sunday around 7 PM preview the coming Monday–Sunday plan. Keep one reminder channel enabled per check-in during the pilot.

## Voice and task inbox
Tap the mic or type. Show the transcript, speak the answer, and preview actions for confirmation. Support “What's next?”, “What's due this week?”, “Check Classroom and email”, “Add a 45-minute study session tomorrow”, and “Remind me one day before”. Reject incomplete or ambiguous date commands with a clarification. Confirming a repeated request must not create duplicates.

Connect Classroom and Gmail separately using Google OAuth. Read coursework and own submission status where available. Read only selected coursework-label messages in the app workflow and disclose that the Gmail authorization scope is broader than the label. Use Classroom's published due-date fields directly. For email, extract a title, original evidence, explicit date if available and source link. Treat mail content as input data. Keep general mailbox contents, meal photos and health logs out of AI requests. For the first Gmail slice use local parsing or explicitly selected text, and review Google's data handling requirements before external AI processing. Account approval from the college may be needed. Provide a pasted-text fallback and show last successful sync and access errors. Use Check now and app-open refresh after opt-in. Defer dependable unattended sync until tested.

The inbox supports Add, Edit and add, Skip and Open source. Store the source deadline, personal finish-by date, planned study slot and reminder separately. Show Deadline unconfirmed for missing or ambiguous dates and Time unspecified for dates without times. Show conflicting evidence and ask which date to use. Proposed changes to saved deadlines require approval. Deduplicate by source account and item ID, then show probable cross-source matches for review. Plan around college, gym, and recorded commitments. Show work that exceeds available time and highlight the week's top three tasks. Keep official due dates intact.

## Build sequence
1. Device feasibility. Verify the exact wake alarm, locked-screen interaction, permission recovery and reboot rescheduling on the pilot Android phone. Verify college Classroom and Gmail authorization with the intended accounts. Record results before relying on either connector.
2. End-to-end core. Flutter, Riverpod and Drift/SQLite. Ship Today, Coursework, Weekly Agenda and Settings with manual task entry. Kotlin bridge handles native alarms. Add local routine reminders, wake puzzle and a cached morning briefing.
3. JARVIS experience. Push-to-talk, speech output, typed alternative and explicit confirmation. Use structured proposed actions checked by app code before any task, schedule or reminder changes. Build the source review inbox and Classroom import, then Gmail review.
4. Daily tracking and release. Add photo meals, water, manual Google Fit totals, workouts, evening wrap-up and notification controls. Package a pilot APK. Run the two-week pilot.

Keep records local by default. Store OAuth tokens in secure storage and photos in app-private files. Add source disconnect and local data deletion. Core routine, alarms, manual tasks and logs work offline. Connector refresh and any optional remote assistant processing require connectivity. Later: hands-free wake phrase, bathroom QR challenge, cloud sync and Health Connect if wanted.

## Acceptance and pilot
| Area | Pass condition |
|---|---|
| Wake-up | On the target phone, alarm rings when locked, app closed and after reboot; solve, snooze and accessible dismiss are available. Editing replaces the old alarm. Denials are visible. |
| Voice | Five listed commands work via voice and typed fallback. Unclear dates prompt a question. Confirm twice and see only one task. |
| Imports | Dated, undated, changed and conflicting source fixtures produce correct cards. Repeat sync creates zero duplicate tasks. Revoked access leaves manual entry usable and shows the sync issue. |
| Agenda | A library collision shortens available study time, overflow is visible, and the gym buffer is preserved. The suggested date is never shown as the official deadline. |
| Logs | A repeat meal photo saves in under 30 seconds, water logs in one tap with undo, and step progress distinguishes missing and entered data. Logs persist after restart. |
| Pilot | Run 14 days including two Sunday agendas. Record alarm misses, duplicate reminders, incorrect deadlines, time to log meals and library sessions completed. Release when critical flows pass, there are zero unexplained alarm misses in supported scenarios, and there are no guessed deadlines or duplicate tasks. |

### Product roadmap beyond the pilot

- Extend the Classroom deadline watcher to Android and web, with reliable
  background sync and optional shared Firebase login when approved.
- Explore optional hands-free wake phrase, QR wake-up step, Health Connect,
  and opt-in cloud sync. Keep routine features usable offline.
- Plan optional user-initiated voice calls separately from in-app reminder
  calls. Keep the Jarvis dark theme, badge and explicit DONE/UNDO checklist.
- Keep Redis/BullMQ and remote model integrations conditional on pilot needs.
- Preserve the later pilot routine defaults in the brief and let the owner
  edit schedules, including the earlier 3–6 PM library and 6 PM gym variant.
