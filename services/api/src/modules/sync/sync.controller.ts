import { Controller, Get, Post } from '@nestjs/common';
import { SyncService } from './sync.service';

@Controller('sync')
export class SyncController {
  constructor(private readonly syncService: SyncService) {}

  @Get('status')
  async getStatus() {
    return this.syncService.getStatus();
  }

  @Post('classroom/trigger')
  async triggerClassroomSync() {
    return this.syncService.syncClassroom();
  }

  @Post('gmail/trigger')
  async triggerGmailSync() {
    return this.syncService.syncGmail();
  }
}
