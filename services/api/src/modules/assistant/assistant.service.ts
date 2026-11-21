import { Injectable } from '@nestjs/common';

@Injectable()
export class AssistantService {
  async processQuery(input: string, mode: string = 'voice') {
    const clean = input.toLowerCase();

    if (clean.includes("what's next") || clean.includes("what is next")) {
      return {
        replyText: 'You have College until 3:00 PM, followed by your Library focus session at 3:10 PM.',
        spokenText: 'You have College until 3:00 PM, followed by your Library focus session.',
        proposedAction: null,
      };
    }

    if (clean.includes('due this week')) {
      return {
        replyText: 'You have 2 pending items: SE Assignment 3 due Nov 25, and DB Lab Final due Nov 28.',
        spokenText: 'You have 2 assignments due this week: SE Assignment 3 on Wednesday, and DB Lab on Saturday.',
        proposedAction: null,
      };
    }

    if (clean.includes('study session')) {
      return {
        replyText: 'I have proposed a 45-minute study block for tomorrow from 3:10 PM to 3:55 PM.',
        spokenText: 'I scheduled a 45-minute study session tomorrow at 3:10 PM in the library.',
        proposedAction: {
          actionType: 'schedule_study',
          summary: 'Tomorrow 3:10 PM - 3:55 PM Study Session',
          parameters: {
            durationMinutes: 45,
            date: '2026-11-23',
            time: '15:10',
          },
        },
      };
    }

    if (clean.includes('remind me')) {
      return {
        replyText: 'Reminder proposed: 1 day before SE Assignment 3 (Nov 24 at 10:00 AM).',
        spokenText: 'I will call you one day before the deadline at 10:00 AM.',
        proposedAction: {
          actionType: 'set_reminder',
          summary: 'Call reminder 1 day before deadline',
          parameters: {
            scheduledAt: '2026-11-24T10:00:00.000Z',
            preference: 'call_me',
          },
        },
      };
    }

    return {
      replyText: `Synchronized coursework. Checking Classroom and Gmail now for new assignments.`,
      spokenText: `Checking Google Classroom and Gmail for new coursework.`,
      proposedAction: {
        actionType: 'sync_coursework',
        summary: 'Classroom & Gmail Sync',
        parameters: {},
      },
    };
  }
}
