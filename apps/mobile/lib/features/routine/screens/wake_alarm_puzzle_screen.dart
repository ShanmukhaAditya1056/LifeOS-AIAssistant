import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class WakeAlarmPuzzleScreen extends StatefulWidget {
  const WakeAlarmPuzzleScreen({super.key});

  @override
  State<WakeAlarmPuzzleScreen> createState() => _WakeAlarmPuzzleScreenState();
}

class _WakeAlarmPuzzleScreenState extends State<WakeAlarmPuzzleScreen> {
  int currentPuzzle = 1;
  final TextEditingController _answerController = TextEditingController();
  String errorMessage = '';
  bool completed = false;

  // Puzzle 1: Arithmetic: 37 + 48 = 85
  // Puzzle 2: Sequence: 3, 9, 27, ? (81)
  final String puzzle1Question = "Solve: 37 + 48 = ?";
  final String puzzle1Answer = "85";

  final String puzzle2Question = "Next number: 3, 9, 27, ?";
  final String puzzle2Answer = "81";

  void _verifyAnswer() {
    final input = _answerController.text.trim();
    if (currentPuzzle == 1) {
      if (input == puzzle1Answer) {
        setState(() {
          currentPuzzle = 2;
          _answerController.clear();
          errorMessage = '';
        });
      } else {
        setState(() => errorMessage = 'Incorrect, try again.');
      }
    } else if (currentPuzzle == 2) {
      if (input == puzzle2Answer) {
        setState(() {
          completed = true;
          errorMessage = '';
        });
      } else {
        setState(() => errorMessage = 'Incorrect, try again.');
      }
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                '06:15 AM WAKE-UP',
                style: TextStyle(color: AppColors.tealOrb, fontSize: 18, letterSpacing: 3, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hard Mode: Solve 2 Puzzles to Stop Alarm',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 48),
              if (!completed) ...[
                Text(
                  'Puzzle $currentPuzzle of 2',
                  style: const TextStyle(color: AppColors.tealAccent, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.Border.all(color: AppColors.surfaceLight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        currentPuzzle == 1 ? puzzle1Question : puzzle2Question,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _answerController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22, color: AppColors.tealOrb),
                        decoration: const InputDecoration(
                          hintText: 'Enter answer',
                          hintStyle: TextStyle(color: AppColors.textMuted),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(errorMessage, style: const TextStyle(color: AppColors.danger)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _verifyAnswer,
                  child: Text(currentPuzzle == 1 ? 'Submit & Next Puzzle' : 'Submit & Stop Alarm'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Snooze 5 Minutes', style: TextStyle(color: AppColors.warning)),
                ),
              ] else ...[
                const Icon(Icons.check_circle_outline, color: AppColors.success, size: 80),
                const SizedBox(height: 20),
                const Text('Alarm Deactivated!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text(
                  'Tap "I\'m Up" to hear your personalized morning briefing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Triggers morning briefing audio
                    Navigator.of(context).pop();
                  },
                  child: const Text("I'm Up (Play Briefing)"),
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
