import { Injectable } from '@nestjs/common';

@Injectable()
export class TrackingService {
  private waterLogs: number[] = [250, 500, 250, 500];
  private mealLogs: any[] = [
    {
      id: 'meal-1',
      mealType: 'breakfast',
      itemsDescription: '50g oats, 1 tsp chia seeds, water',
      photoPath: null,
      estimatedCalories: 250,
      estimatedCostInr: 35,
      loggedAt: '2026-11-22T07:15:00.000Z',
    },
    {
      id: 'meal-2',
      mealType: 'lunch',
      itemsDescription: 'Rice, 4 eggs, 100g raw chicken, moong dal',
      photoPath: null,
      estimatedCalories: 680,
      estimatedCostInr: 95,
      loggedAt: '2026-11-22T13:30:00.000Z',
    },
  ];

  async getMeals(date: string) {
    return this.mealLogs;
  }

  async logMeal(mealDto: any) {
    const newMeal = {
      id: 'meal-' + Date.now(),
      ...mealDto,
      loggedAt: new Date().toISOString(),
    };
    this.mealLogs.push(newMeal);
    return newMeal;
  }

  async getWaterSummary(date: string) {
    const totalMl = this.waterLogs.reduce((acc, curr) => acc + curr, 0);
    return {
      totalMl,
      targetMl: 4000,
      entriesCount: this.waterLogs.length,
      lastEntryAt: new Date().toISOString(),
    };
  }

  async addWater(amountMl: number) {
    this.waterLogs.push(amountMl);
    return this.getWaterSummary(new Date().toISOString());
  }

  async undoWater() {
    if (this.waterLogs.length > 0) {
      this.waterLogs.pop();
    }
    return this.getWaterSummary(new Date().toISOString());
  }
}
