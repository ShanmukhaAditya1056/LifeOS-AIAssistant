import { Controller, Get, Put, Body } from '@nestjs/common';
import { RoutineService } from './routine.service';

@Controller('routine')
export class RoutineController {
  constructor(private readonly routineService: RoutineService) {}

  @Get('schedule')
  async getSchedule() {
    return this.routineService.getSchedule();
  }

  @Put('schedule')
  async updateSchedule(@Body() schedule: any[]) {
    return this.routineService.updateSchedule(schedule);
  }

  @Get('briefing')
  async getBriefing() {
    return this.routineService.getMorningBriefing();
  }
}
