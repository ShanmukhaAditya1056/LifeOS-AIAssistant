import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class DailyTrackingScreen extends StatefulWidget {
  const DailyTrackingScreen({super.key});

  @override
  State<DailyTrackingScreen> createState() => _DailyTrackingScreenState();
}

class _DailyTrackingScreenState extends State<DailyTrackingScreen> {
  int waterIntakeMl = 1500;
  final int waterTargetMl = 4000;
  List<int> waterHistory = [250, 500, 250, 500];

  void _addWater(int amount) {
    setState(() {
      waterIntakeMl += amount;
      waterHistory.add(amount);
    });
  }

  void _undoWater() {
    if (waterHistory.isNotEmpty) {
      setState(() {
        final last = waterHistory.removeLast();
        waterIntakeMl = (waterIntakeMl - last).clamp(0, 10000);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (waterIntakeMl / waterTargetMl).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Daily Tracking')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Water Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.Border.all(color: AppColors.surfaceLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.water_drop, color: AppColors.tealOrb),
                        SizedBox(width: 8),
                        Text('Water Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: waterHistory.isNotEmpty ? _undoWater : null,
                      icon: const Icon(Icons.undo, size: 16),
                      label: const Text('Undo'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.surfaceLight,
                  color: AppColors.tealOrb,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 8),
                Text('$waterIntakeMl / $waterTargetMl ml (${(progress * 100).toInt()}%)', style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _addWater(250),
                        child: const Text('+250 ml'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _addWater(500),
                        child: const Text('+500 ml'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Meal Photo Logger
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.Border.all(color: AppColors.surfaceLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.restaurant, color: AppColors.warning),
                    SizedBox(width: 8),
                    Text('Meal Logger (Sub-30s Repeat)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Logged Today: Breakfast (Oats & chia), Lunch (Rice, 4 eggs, 100g chicken, moong dal)'),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Snap / Attach Meal Photo'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Steps & Workout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.Border.all(color: AppColors.surfaceLight),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_run, color: AppColors.success),
                    SizedBox(width: 8),
                    Text('Steps & Workout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 12),
                Text('Goal: 10,000 steps (Google Fit self-reported)'),
                SizedBox(height: 4),
                Text('Status: 6,420 steps logged â€¢ 3,580 steps remaining', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
