import { Controller, Get, Post, Param, Body } from '@nestjs/common';
import { RemindersService } from './reminders.service';

@Controller('reminders')
export class RemindersController {
  constructor(private readonly remindersService: RemindersService) {}

  @Get()
  async getReminders() {
    return this.remindersService.findAll();
  }

  @Post()
  async createReminder(@Body() data: any) {
    return this.remindersService.create(data);
  }

  @Post(':id/action')
  async processAction(@Param('id') id: string, @Body() body: any) {
    return this.remindersService.processAction(id, body);
  }
}
