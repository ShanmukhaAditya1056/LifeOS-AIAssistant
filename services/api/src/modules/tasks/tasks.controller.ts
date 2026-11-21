import { Controller, Get, Post, Patch, Param, Body, Query } from '@nestjs/common';
import { TasksService } from './tasks.service';

@Controller('tasks')
export class TasksController {
  constructor(private readonly tasksService: TasksService) {}

  @Get()
  async getTasks(@Query('status') status?: string) {
    return this.tasksService.findAll(status);
  }

  @Post()
  async createTask(@Body() data: any) {
    return this.tasksService.create(data);
  }

  @Get(':id')
  async getTaskById(@Param('id') id: string) {
    return this.tasksService.findOne(id);
  }

  @Patch(':id')
  async updateTask(@Param('id') id: string, @Body() data: any) {
    return this.tasksService.update(id, data);
  }

  @Post(':id/approve')
  async approveTask(@Param('id') id: string, @Body() data: any) {
    return this.tasksService.approve(id, data);
  }
}
