import { Injectable } from '@nestjs/common';

@Injectable()
export class RoutineService {
  private defaultSchedule = [
    {
      id: 'block-wake',
      name: 'Wake Alarm & Puzzles',
      startTime: '06:15',
      endTime: '07:00',
      daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
    },
    {
      id: 'block-college',
      name: 'College',
      startTime: '08:00',
      endTime: '15:00',
      daysOfWeek: [1, 2, 3, 4, 5],
    },
    {
      id: 'block-library',
      name: 'Library Focus Session',
      startTime: '15:00',
      endTime: '17:00',
      daysOfWeek: [1, 2, 3, 4, 5],
      subBlocks: [
        { title: 'Plan & setup', startOffsetMinutes: 0, durationMinutes: 10 },
        { title: 'Focus block', startOffsetMinutes: 10, durationMinutes: 70 },
        { title: 'Break', startOffsetMinutes: 80, durationMinutes: 10 },
        { title: 'Review & submit', startOffsetMinutes: 90, durationMinutes: 30 },
      ],
    },
    {
      id: 'block-snack-travel',
      name: 'Travel & Snack Buffer',
      startTime: '17:00',
      endTime: '17:30',
      daysOfWeek: [1, 2, 3, 4, 5],
    },
    {
      id: 'block-gym',
      name: 'Gym / Workout',
      startTime: '17:30',
      endTime: '19:30',
      daysOfWeek: [1, 3, 5],
    },
    {
      id: 'block-evening-checkin',
      name: 'Steps & Water Check-In',
      startTime: '20:45',
      endTime: '21:00',
      daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
    },
    {
      id: 'block-bedtime',
      name: 'Bedtime & Quiet Hours',
      startTime: '23:00',
      endTime: '06:15',
      daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
    },
  ];

  async getSchedule() {
    return this.defaultSchedule;
  }

  async updateSchedule(schedule: any[]) {
    this.defaultSchedule = schedule;
    return this.defaultSchedule;
  }

  async getMorningBriefing() {
    return {
      spokenText:
        'Good morning Aditya. Wake up confirmed. Your first commitment is College at 8:00 AM. Breakfast is oats and chia seeds. Your priority study task is Software Engineering Assignment 3 during your 3:10 PM library session.',
      firstCommitment: 'College at 8:00 AM',
      breakfast: '50g oats, 1 tsp chia seeds, water/milk',
      topStudyTask: 'SE Assignment 3 (Library block at 3:10 PM)',
    };
  }
}
