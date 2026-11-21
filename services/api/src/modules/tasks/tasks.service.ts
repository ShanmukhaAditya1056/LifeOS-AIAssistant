import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class TasksService {
  constructor(private readonly prisma: PrismaService) {}

  // Mock in-memory store fallback when DB is bootstrapping
  private mockTasks: any[] = [
    {
      id: 'd1a2b3c4-e5f6-7a8b-9c0d-1e2f3a4b5c6d',
      title: 'SE Assignment 3: Software Architecture Patterns',
      description: 'Submit report covering Microservices vs Monolith architectures.',
      status: 'inbox',
      officialDeadline: '2026-11-25T23:59:00.000Z',
      deadlineStatus: 'confirmed',
      finishByDate: '2026-11-24',
      studySlotStart: '2026-11-23T15:10:00.000Z',
      studySlotDurationMinutes: 70,
      reminderPreference: 'call_me',
      sourceType: 'google_classroom',
      sourceEvidence: 'Published by Prof. Sharma in Software Engineering classroom.',
      sourceUrl: 'https://classroom.google.com/c/sample',
    },
    {
      id: 'a9b8c7d6-e5f4-3a2b-1c0d-9e8f7a6b5c4d',
      title: 'Database Lab Final Project Submission',
      description: 'Submit SQL scripts and ER diagram documentation.',
      status: 'inbox',
      officialDeadline: '2026-11-28T17:00:00.000Z',
      deadlineStatus: 'confirmed',
      finishByDate: '2026-11-27',
      studySlotStart: '2026-11-27T15:10:00.000Z',
      studySlotDurationMinutes: 70,
      reminderPreference: 'call_me',
      sourceType: 'gmail',
      sourceEvidence: 'Email from db-lab-coord@college.edu with subject "Lab 5 due date announced".',
      sourceUrl: null,
    },
  ];

  async findAll(status?: string) {
    if (status) {
      return this.mockTasks.filter((t) => t.status === status);
    }
    return this.mockTasks;
  }

  async findOne(id: string) {
    const task = this.mockTasks.find((t) => t.id === id);
    return task || { error: 'Task not found' };
  }

  async create(data: any) {
    const newTask = {
      id: 'task-' + Date.now(),
      status: 'inbox',
      reminderPreference: data.reminderPreference || 'call_me',
      sourceType: 'manual',
      ...data,
      createdAt: new Date().toISOString(),
    };
    this.mockTasks.push(newTask);
    return newTask;
  }

  async update(id: string, data: any) {
    const index = this.mockTasks.findIndex((t) => t.id === id);
    if (index !== -1) {
      this.mockTasks[index] = { ...this.mockTasks[index], ...data };
      return this.mockTasks[index];
    }
    return { error: 'Task not found' };
  }

  async approve(id: string, data: any) {
    const index = this.mockTasks.findIndex((t) => t.id === id);
    if (index !== -1) {
      this.mockTasks[index] = {
        ...this.mockTasks[index],
        status: 'approved',
        ...data,
      };
      return this.mockTasks[index];
    }
    return { error: 'Task not found' };
  }
}
