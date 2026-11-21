import { Injectable } from '@nestjs/common';

@Injectable()
export class SyncService {
  async getStatus() {
    return {
      classroomConnected: true,
      gmailConnected: true,
      lastClassroomSyncAt: '2026-11-22T00:15:00.000Z',
      lastGmailSyncAt: '2026-11-22T00:15:00.000Z',
      errorMessage: null,
    };
  }

  async syncClassroom() {
    return {
      status: 'completed',
      source: 'google_classroom',
      importedCount: 1,
      items: [
        {
          sourceId: 'classroom-assignment-103',
          title: 'SE Assignment 3: Software Architecture Patterns',
          officialDeadline: '2026-11-25T23:59:00.000Z',
        },
      ],
    };
  }

  async syncGmail() {
    return {
      status: 'completed',
      source: 'gmail',
      importedCount: 1,
      items: [
        {
          sourceId: 'gmail-msg-204',
          title: 'Database Lab Final Project Submission',
          officialDeadline: '2026-11-28T17:00:00.000Z',
        },
      ],
    };
  }
}
