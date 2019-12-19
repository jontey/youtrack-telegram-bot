FROM node:10-alpine

RUN apk add --no-cache tzdata

WORKDIR /app

RUN yarn global add pm2@3.2.2

RUN pm2 install pm2-logrotate
RUN pm2 set pm2-logrotate:compress true
RUN pm2 set pm2-logrotate:retain 7

COPY package.json .

RUN yarn install

COPY src/ ./src/

CMD ["pm2-runtime", "./src/app.json"]