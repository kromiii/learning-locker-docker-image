# Build stage
FROM node:8.17.0-buster-slim AS builder

WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python2 \
    make \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/LearningLocker/learninglocker.git --depth 1 -b v5.2.6 \
    && cd learninglocker \
    && yarn install \
    && yarn build-all

RUN git clone https://github.com/LearningLocker/xapi-service.git --depth 1 -b v2.9.11 \
    && cd xapi-service \
    && yarn install --ignore-engines \
    && yarn build

# Execute stage
FROM node:8.17.0-buster-slim

WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g pm2@4 \
    && pm2 install pm2-logrotate \
    && pm2 set pm2-logrotate:compress true

COPY --from=builder /usr/local/src/learninglocker ./learninglocker
COPY --from=builder /usr/local/src/xapi-service ./xapi-service

EXPOSE 3000 8080

CMD ["pm2-runtime", "start", "/usr/local/src/learninglocker/pm2/all.json"]
