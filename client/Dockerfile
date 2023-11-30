FROM node:18-alpine

RUN mkdir -p /client

WORKDIR /client

COPY package*.json /client/ 

ENV NEXT_TELEMETRY_DISABLED 1

RUN yarn install

COPY . /client/

EXPOSE 3000

CMD [ "yarn", "dev"]