import { Controller, Get, Post, Body, Query } from '@nestjs/common';
import { TrackingService } from './tracking.service';

@Controller('tracking')
export class TrackingController {
  constructor(private readonly trackingService: TrackingService) {}

  @Get('meals')
  async getMeals(@Query('date') date: string) {
    return this.trackingService.getMeals(date);
  }

  @Post('meals')
  async logMeal(@Body() mealDto: any) {
    return this.trackingService.logMeal(mealDto);
  }

  @Get('water')
  async getWater(@Query('date') date: string) {
    return this.trackingService.getWaterSummary(date);
  }

  @Post('water')
  async addWater(@Body('amountMl') amountMl: number) {
    return this.trackingService.addWater(amountMl);
  }

  @Post('water/undo')
  async undoWater() {
    return this.trackingService.undoWater();
  }
}
