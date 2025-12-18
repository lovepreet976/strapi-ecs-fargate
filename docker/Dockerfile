# =========================
# Build Stage
# =========================
FROM node:18-alpine AS build

WORKDIR /app

COPY strapi/package.json strapi/package-lock.json ./
RUN npm install

COPY strapi/ ./
RUN npm run build


# =========================
# Runtime Stage
# =========================
FROM node:18-alpine

WORKDIR /app
ENV NODE_ENV=production

COPY --from=build /app ./

# Remove dev deps & cache (THIS reduces size correctly)
RUN npm prune --production \
 && npm cache clean --force \
 && rm -rf /root/.npm

EXPOSE 1337
CMD ["npm", "start"]
