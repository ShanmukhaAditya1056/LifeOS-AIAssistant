# LifeOS Backend API Service

NestJS + Prisma + PostgreSQL backend service for LifeOS personal assistant.

## Features

- **Coursework Management**: Ingests, tracks, and schedules academic assignments.
- **Deduplication & Provenance**: Tracks Google Classroom and Gmail source IDs to ensure zero duplicate tasks upon repeated sync.
- **Routine Schedules & Briefings**: Provides daily schedule blocks and personalized spoken morning briefings.
- **Call-Style Reminders**: Manages reminder states, snooze windows, and answer/dismiss actions.
- **Daily Tracking**: Sub-30s meal template logging and quick-add water intake with undo.
- **OpenAPI 3.0 Contract**: Interactive Swagger UI available at `/api/docs`.

## Quick Start

```bash
# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Generate Prisma Client & Run Migrations
npx prisma generate
npx prisma migrate dev

# Run development server
npm run start:dev
```

## Testing

```bash
# Unit tests
npm run test

# End-to-end integration tests
npm run test:e2e
```
