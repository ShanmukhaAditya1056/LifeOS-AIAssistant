import { Controller, Post, Body } from '@nestjs/common';
import { AssistantService } from './assistant.service';

@Controller('assistant')
export class AssistantController {
  constructor(private readonly assistantService: AssistantService) {}

  @Post('query')
  async query(@Body() body: { input: string; mode?: string }) {
    return this.assistantService.processQuery(body.input, body.mode);
  }
}
