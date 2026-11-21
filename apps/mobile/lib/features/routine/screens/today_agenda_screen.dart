import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class TodayAgendaScreen extends StatelessWidget {
  const TodayAgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LifeOS Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Asia/Kolkata â€¢ Aditya Madala', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: AppColors.tealOrb),
            onPressed: () => context.push('/incoming-call'),
          ),
          IconButton(
            icon: const Icon(Icons.alarm, color: AppColors.warning),
            onPressed: () => context.push('/wake-alarm'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBriefingCard(),
          const SizedBox(height: 20),
          const Text('Daily Routine Timeline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildTimelineItem(
            time: '06:15 AM',
            title: 'Wake Alarm & Puzzles',
            subtitle: 'Hard mode (2 puzzles) â€¢ Completed',
            isDone: true,
            icon: Icons.alarm_on,
          ),
          _buildTimelineItem(
            time: '08:00 AM - 03:00 PM',
            title: 'College',
            subtitle: 'Notification-only mode active',
            isDone: false,
            isCurrent: true,
            icon: Icons.school,
          ),
          _buildTimelineItem(
            time: '03:00 PM - 05:00 PM',
            title: 'Library Focus Session',
            subtitle: '3:00 Plan | 3:10 Focus | 4:20 Break | 4:30 Review',
            isDone: false,
            icon: Icons.local_library,
          ),
          _buildTimelineItem(
            time: '05:00 PM - 05:30 PM',
            title: 'Travel & Snack Buffer',
            subtitle: 'Banana & pre-gym preparation',
            isDone: false,
            icon: Icons.directions_walk,
          ),
          _buildTimelineItem(
            time: '05:30 PM - 07:30 PM',
            title: 'Gym / Workout',
            subtitle: 'Chest & Triceps log',
            isDone: false,
            icon: Icons.fitness_center,
          ),
          _buildTimelineItem(
            time: '08:45 PM',
            title: 'Steps & Water Check-In',
            subtitle: 'Target 10,000 steps â€¢ 4L Water',
            isDone: false,
            icon: Icons.water_drop,
          ),
          _buildTimelineItem(
            time: '11:00 PM',
            title: 'Bedtime & Quiet Hours',
            subtitle: 'Mute non-critical reminders',
            isDone: false,
            icon: Icons.bedtime,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.tealOrb,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.push('/inbox');
          if (index == 2) context.push('/assistant');
          if (index == 3) context.push('/tracking');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'JARVIS'),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Tracking'),
        ],
      ),
    );
  }

  Widget _buildBriefingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.Border.all(color: AppColors.tealGlow),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.tealOrb,
            child: Icon(Icons.auto_awesome, color: Colors.black),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Morning Briefing', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tealOrb)),
                SizedBox(height: 4),
                Text(
                  'First commitment: College at 8:00 AM. Breakfast: Oats & chia seeds. Study slot: SE Assignment at 3:10 PM.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String subtitle,
    required bool isDone,
    bool isCurrent = false,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.surfaceLight : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.Border.all(
          color: isCurrent ? AppColors.tealOrb : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: isCurrent ? AppColors.tealOrb : AppColors.textSecondary, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(time, style: const TextStyle(color: AppColors.tealAccent, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
