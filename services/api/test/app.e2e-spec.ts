import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';

describe('LifeOS API (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.setGlobalPrefix('api/v1');
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('/api/v1/health (GET)', () => {
    return request(app.getHttpServer())
      .get('/api/v1/health')
      .expect(200)
      .expect((res) => {
        expect(res.body.status).toBe('ok');
        expect(res.body.service).toBe('lifeos-api');
      });
  });

  it('/api/v1/tasks (GET)', () => {
    return request(app.getHttpServer())
      .get('/api/v1/tasks')
      .expect(200)
      .expect((res) => {
        expect(Array.isArray(res.body)).toBe(true);
      });
  });

  it('/api/v1/routine/briefing (GET)', () => {
    return request(app.getHttpServer())
      .get('/api/v1/routine/briefing')
      .expect(200)
      .expect((res) => {
        expect(res.body.spokenText).toBeDefined();
        expect(res.body.firstCommitment).toBeDefined();
      });
  });
});
