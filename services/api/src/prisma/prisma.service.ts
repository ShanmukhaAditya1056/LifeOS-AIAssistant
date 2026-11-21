import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  async onModuleInit() {
    // Connect to database in production/testing
    try {
      await this.$connect();
    } catch {
      // Allow bootstrapping without live DB during early development/mocking
    }
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}
