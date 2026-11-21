import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CourseworkInboxScreen extends StatelessWidget {
  const CourseworkInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Coursework Inbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: AppColors.tealOrb),
            tooltip: 'Sync Classroom & Gmail',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checking Classroom and Gmail...')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInboxCard(
            context,
            source: 'Google Classroom',
            title: 'SE Assignment 3: Software Architecture Patterns',
            officialDeadline: 'Nov 25, 2026 â€¢ 11:59 PM',
            suggestedStudySlot: 'Tomorrow 3:10 PM - 4:20 PM (Library)',
            finishBy: 'Nov 24, 2026',
            evidence: 'Published by Prof. Sharma in Software Engineering classroom.',
          ),
          const SizedBox(height: 16),
          _buildInboxCard(
            context,
            source: 'Gmail (Coursework Label)',
            title: 'Database Lab Final Project Submission',
            officialDeadline: 'Nov 28, 2026 â€¢ 5:00 PM',
            suggestedStudySlot: 'Friday 3:10 PM - 4:20 PM (Library)',
            finishBy: 'Nov 27, 2026',
            evidence: 'Email from db-lab-coord@college.edu with subject "Lab 5 due date announced".',
          ),
        ],
      ),
    );
  }

  Widget _buildInboxCard(
    BuildContext context, {
    required String source,
    required String title,
    required String officialDeadline,
    required String suggestedStudySlot,
    required String finishBy,
    required String evidence,
  }) {
    return Container(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(source, style: const TextStyle(fontSize: 11, color: AppColors.tealOrb)),
              ),
              const Icon(Icons.bookmark_outline, color: AppColors.textSecondary, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.event, size: 16, color: AppColors.warning),
              const SizedBox(width: 6),
              Text('Official Deadline: $officialDeadline', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.flag, size: 16, color: AppColors.tealAccent),
              const SizedBox(width: 6),
              Text('Finish-by: $finishBy', style: const TextStyle(fontSize: 13, color: AppColors.tealAccent)),
            ],
          ),
          const SizedBox(height: 8),
          Text('Evidence: $evidence', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Edit & Add'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task approved and study slot scheduled!')),
                    );
                  },
                  child: const Text('Approve'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
