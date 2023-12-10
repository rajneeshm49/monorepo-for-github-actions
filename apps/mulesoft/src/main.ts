/**
 * This is not a production server yet!
 * This is only a minimal backend to get started.
 */

import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';

import { AppModule } from './app/app.module';
import { environment } from './environments/environment';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const globalPrefix = 'api';
  app.enableCors({
    origin: [
      'http://localhost',
      'http://localhost:80',
      environment.FE_URL,
      'fe-clusterip-service',
      'fe-clusterip-service:80',
      'http://fe-clusterip-service',
      'http://fe-clusterip-service:80',
    ],
    preflightContinue: true,
    methods: 'GET, POST',
  });
  app.setGlobalPrefix(globalPrefix);
  const port = process.env.PORT || 3000;
  await app.listen(port);
  Logger.log(
    `🚀 Application is running on: http://localhost:${port} with global prefix ${globalPrefix}`
  );
}

bootstrap();
