# first stage: build
FROM node:8.9.3 AS builder
WORKDIR /usr/src/app
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY package.json /usr/src/app/
RUN npm install --registry=https://registry.npm.taobao.org
RUN npm install -g gitbook-cli
COPY book.json /usr/src/app/
RUN gitbook install
COPY . /usr/src/app

RUN [ "gitbook", "build"]

# second stage: run
FROM nginx
COPY --from=builder /usr/src/app/_book /usr/share/nginx/html

EXPOSE 80

