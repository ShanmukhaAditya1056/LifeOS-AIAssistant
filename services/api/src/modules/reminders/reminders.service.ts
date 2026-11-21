import { Injectable } from '@nestjs/common';

@Injectable()
export class RemindersService {
  private mockReminders: any[] = [
    {
      id: 'rem-101',
      title: 'Library Focus: SE Assignment 3',
      spokenMessage: 'Aditya, it is 3:10 PM. Begin your 70-minute focus block on Software Engineering Assignment 3.',
      scheduledAt: '2026-11-23T15:10:00.000Z',
      preference: 'call_me',
      isWaterReminder: false,
      status: 'pending',
    },
    {
      id: 'rem-102',
      title: 'Water Intake Reminder',
      spokenMessage: 'Time for water. Drink 250 ml to stay on track for your 4-liter goal.',
      scheduledAt: '2026-11-22T14:00:00.000Z',
      preference: 'call_me',
      isWaterReminder: true,
      status: 'pending',
    },
  ];

  async findAll() {
    return this.mockReminders;
  }

  async create(data: any) {
    const newRem = {
      id: 'rem-' + Date.now(),
      preference: data.preference || 'call_me',
      status: 'pending',
      ...data,
    };
    this.mockReminders.push(newRem);
    return newRem;
  }

  async processAction(id: string, body: { action: string; snoozeMinutes?: number; waterAmountMl?: number }) {
    const rem = this.mockReminders.find((r) => r.id === id);
    if (!rem) return { success: false, error: 'Reminder not found' };

    if (body.action === 'snooze') {
      const snoozeMin = body.snoozeMinutes || 5;
      const nextTime = new Date(Date.now() + snoozeMin * 60000).toISOString();
      rem.status = 'snoozed';
      rem.scheduledAt = nextTime;
      return { success: true, nextReminderAt: nextTime };
    } else if (body.action === 'dismiss' || body.action === 'answer') {
      rem.status = body.action === 'answer' ? 'answered' : 'dismissed';
      return { success: true, status: rem.status };
    } else if (body.action === 'mark_done') {
      rem.status = 'completed';
      return { success: true, status: 'completed' };
    }

    return { success: true };
  }
}
