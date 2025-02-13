FROM node:lts-buster-slim AS development

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install
RUN yarn global add ts-node

COPY . .

FROM development AS dev-envs
RUN apt-get update --allow-releaseinfo-change
RUN apt-get install -y --no-install-recommends git

RUN useradd -s /bin/bash -m deploy
RUN groupadd docker
RUN usermod -aG docker deploy

USER deploy
