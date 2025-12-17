FROM node:18-alpine

WORKDIR /app

COPY strapi/package*.json ./

RUN npm install

COPY strapi/ ./

ENV NODE_ENV=production

RUN npm run build

EXPOSE 1337

CMD ["npm", "start"]
