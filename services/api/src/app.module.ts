import { Module } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { HealthController } from './modules/health/health.controller';
import { TasksController } from './modules/tasks/tasks.controller';
import { TasksService } from './modules/tasks/tasks.service';
import { RoutineController } from './modules/routine/routine.controller';
import { RoutineService } from './modules/routine/routine.service';
import { RemindersController } from './modules/reminders/reminders.controller';
import { RemindersService } from './modules/reminders/reminders.service';
import { AssistantController } from './modules/assistant/assistant.controller';
import { AssistantService } from './modules/assistant/assistant.service';
import { TrackingController } from './modules/tracking/tracking.controller';
import { TrackingService } from './modules/tracking/tracking.service';
import { SyncController } from './modules/sync/sync.controller';
import { SyncService } from './modules/sync/sync.service';

@Module({
  imports: [],
  controllers: [
    HealthController,
    TasksController,
    RoutineController,
    RemindersController,
    AssistantController,
    TrackingController,
    SyncController,
  ],
  providers: [
    PrismaService,
    TasksService,
    RoutineService,
    RemindersService,
    AssistantService,
    TrackingService,
    SyncService,
  ],
})
export class AppModule {}
