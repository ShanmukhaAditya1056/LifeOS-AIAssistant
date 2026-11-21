import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class JarvisAssistantScreen extends StatefulWidget {
  const JarvisAssistantScreen({super.key});

  @override
  State<JarvisAssistantScreen> createState() => _JarvisAssistantScreenState();
}

class _JarvisAssistantScreenState extends State<JarvisAssistantScreen> {
  String assistantState = 'idle'; // idle, listening, replying
  final TextEditingController _inputController = TextEditingController();
  String lastTranscript = '';
  String assistantReply = '';
  Map<String, dynamic>? proposedAction;

  void _simulateVoiceCommand(String command) {
    setState(() {
      assistantState = 'listening';
      lastTranscript = command;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        assistantState = 'replying';
        if (command.contains("next")) {
          assistantReply = "You have College until 3:00 PM, followed by your Library focus session.";
          proposedAction = null;
        } else if (command.contains("study")) {
          assistantReply = "I have drafted a 45-minute study slot for tomorrow at 3:10 PM.";
          proposedAction = {
            'title': 'Add Study Session',
            'details': 'Tomorrow 3:10 PM - 3:55 PM',
          };
        } else {
          assistantReply = "Checking Classroom and Gmail now. 2 new coursework items found.";
          proposedAction = {
            'title': 'Review 2 Inbox Items',
            'details': 'SE Assignment 3, DB Lab Project',
          };
        }
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('JARVIS Assistant')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: assistantState == 'listening'
                      ? AppColors.tealOrb.withOpacity(0.3)
                      : AppColors.surfaceLight,
                  border: Border.Border.all(
                    color: assistantState == 'listening' ? AppColors.tealOrb : AppColors.surfaceLight,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    assistantState == 'listening' ? Icons.graphic_eq : Icons.mic,
                    color: AppColors.tealOrb,
                    size: 48,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              assistantState == 'listening' ? 'Listening...' : (assistantState == 'replying' ? 'Speaking Reply...' : 'Idle'),
              style: const TextStyle(color: AppColors.tealOrb, letterSpacing: 1.5, fontSize: 13),
            ),
            const SizedBox(height: 24),
            if (lastTranscript.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('"$lastTranscript"', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
              ),
              const SizedBox(height: 16),
            ],
            if (assistantReply.isNotEmpty) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assistantReply, style: const TextStyle(fontSize: 15, height: 1.4)),
                    if (proposedAction != null) ...[
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(proposedAction!['title'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.tealOrb)),
                              Text(proposedAction!['details'], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() => proposedAction = null);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Action confirmed & saved!')),
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ],
            const Spacer(),
            // Quick voice suggestion chips
            Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  label: const Text("What's next?"),
                  onPressed: () => _simulateVoiceCommand("What's next?"),
                ),
                ActionChip(
                  label: const Text("Check Classroom"),
                  onPressed: () => _simulateVoiceCommand("Check Classroom and email"),
                ),
                ActionChip(
                  label: const Text("Add 45m study"),
                  onPressed: () => _simulateVoiceCommand("Add a 45-minute study session tomorrow"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Type command or question...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          _simulateVoiceCommand(val.trim());
                          _inputController.clear();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () => _simulateVoiceCommand("What's next?"),
                    icon: const Icon(Icons.mic, color: Colors.black),
                    style: IconButton.styleFrom(backgroundColor: AppColors.tealOrb),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
