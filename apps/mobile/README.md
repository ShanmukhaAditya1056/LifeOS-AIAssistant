# LifeOS Android / Flutter Client

Mobile application for LifeOS, providing an offline-first experience with a native Kotlin bridge for exact alarms, call-style reminder screens, and text-to-speech.

## Key Features

- **Call-Style Reminders**: Full-screen ringing incoming call experience featuring the teal LifeOS orb, Answer, Snooze, and Dismiss.
- **Wake Alarm (Hard Mode)**: 6:15 AM alarm requiring two mental puzzles (arithmetic/sequence) before turning off, followed by a spoken morning briefing.
- **Offline Drift SQLite Database**: Persists coursework tasks, routine schedules, water intake, and meal templates locally.
- **Voice & Assistant Interface**: Push-to-talk mic with live transcript, action proposals, and speech reply.
- **Daily Health Tracking**: Water quick add (+250 ml, +500 ml) with instant Undo, meal photo template logging, and step tracking.

## Architecture

- **State Management**: Riverpod (`flutter_riverpod`)
- **Local Database**: Drift (`drift`, `sqlite3_flutter_libs`)
- **Routing**: GoRouter (`go_router`)
- **Native Bridge**: Android Kotlin platform channels for `AlarmManager` and full-screen intents.
