FROM node:lts-alpine3.10 as builder
ARG NODE_ENV
ARG BUILD_FLAG
WORKDIR /app/builder
COPY . .
RUN apk add --update python make g++\
   && rm -rf /var/cache/apk/*
RUN npm i