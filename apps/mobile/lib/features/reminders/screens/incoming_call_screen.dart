import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class IncomingCallScreen extends StatefulWidget {
  final String taskTitle;
  final String spokenMessage;
  final bool isWaterReminder;

  const IncomingCallScreen({
    super.key,
    required this.taskTitle,
    required this.spokenMessage,
    this.isWaterReminder = false,
  });

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> with SingleTickerProviderStateMixin {
  bool isAnswered = false;
  int waterAmountMl = 250;
  late AnimationController _orbAnimationController;

  @override
  void initState() {
    super.initState();
    _orbAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _orbAnimationController.dispose();
    super.dispose();
  }

  void _answerCall() {
    setState(() {
      isAnswered = true;
    });
    // In production, trigger flutter_tts to speak widget.spokenMessage
  }

  void _snoozeCall() {
    Navigator.of(context).pop();
  }

  void _dismissCall() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              isAnswered ? 'LifeOS Connected' : 'LifeOS Reminder',
              style: const TextStyle(
                color: AppColors.tealOrb,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.taskTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            // Signature Teal Orb with pulsing glow animation
            AnimatedBuilder(
              animation: _orbAnimationController,
              builder: (context, child) {
                final scale = 1.0 + (_orbAnimationController.value * 0.15);
                return Container(
                  width: 160 * scale,
                  height: 160 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.tealOrb,
                        AppColors.tealOrb.withOpacity(0.6),
                        AppColors.tealOrb.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.2, 0.5, 0.8, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.tealOrb.withOpacity(0.4 * _orbAnimationController.value),
                        blurRadius: 40,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.blur_on,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            if (isAnswered) ...[
              // Spoken message text display
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.volume_up, color: AppColors.tealOrb, size: 20),
                        SizedBox(width: 8),
                        Text('Speaking...', style: TextStyle(color: AppColors.tealOrb, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.spokenMessage,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (widget.isWaterReminder) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppColors.tealOrb),
                        onPressed: () => setState(() => waterAmountMl = (waterAmountMl - 50).clamp(50, 1000)),
                      ),
                      Text('$waterAmountMl ml', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: AppColors.tealOrb),
                        onPressed: () => setState(() => waterAmountMl = (waterAmountMl + 50).clamp(50, 1000)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Log Water'),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.check),
                  label: const Text('Mark Done'),
                ),
              ],
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('End Call (Keep Pending)', style: TextStyle(color: AppColors.textSecondary)),
              ),
            ] else ...[
              // Incoming Call Actions: Snooze, Dismiss, Answer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.surfaceLight),
                          onPressed: _snoozeCall,
                          icon: const Icon(Icons.snooze, color: AppColors.warning),
                        ),
                        const SizedBox(height: 6),
                        const Text('Snooze 5m', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.danger, iconSize: 32),
                          onPressed: _dismissCall,
                          icon: const Icon(Icons.call_end, color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        const Text('Dismiss', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.success, iconSize: 32),
                          onPressed: _answerCall,
                          icon: const Icon(Icons.call, color: Colors.black),
                        ),
                        const SizedBox(height: 6),
                        const Text('Answer', style: TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
