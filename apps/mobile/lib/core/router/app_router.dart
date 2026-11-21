import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/routine/screens/today_agenda_screen.dart';
import '../../features/reminders/screens/incoming_call_screen.dart';
import '../../features/routine/screens/wake_alarm_puzzle_screen.dart';
import '../../features/coursework/screens/inbox_screen.dart';
import '../../features/assistant/screens/jarvis_assistant_screen.dart';
import '../../features/tracking/screens/daily_tracking_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TodayAgendaScreen(),
      ),
      GoRoute(
        path: '/incoming-call',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          return IncomingCallScreen(
            taskTitle: extras['taskTitle'] ?? 'Scheduled Reminder',
            spokenMessage: extras['spokenMessage'] ?? 'Time to focus on your next task.',
            isWaterReminder: extras['isWaterReminder'] ?? false,
          );
        },
      ),
      GoRoute(
        path: '/wake-alarm',
        builder: (context, state) => const WakeAlarmPuzzleScreen(),
      ),
      GoRoute(
        path: '/inbox',
        builder: (context, state) => const CourseworkInboxScreen(),
      ),
      GoRoute(
        path: '/assistant',
        builder: (context, state) => const JarvisAssistantScreen(),
      ),
      GoRoute(
        path: '/tracking',
        builder: (context, state) => const DailyTrackingScreen(),
      ),
    ],
  );
});
