Task-2 
# Strapi Project – Postgres & Docker Setup

This update migrates the project from SQLite to PostgreSQL and introduces a complete Dockerized workflow using a custom Dockerfile and a docker-compose setup. The goal was to ensure a production-ready environment and resolve issues caused by SQLite when using Node’s Alpine base image.

---

## 🚀 What Was Done

* Switched database from **SQLite → PostgreSQL**
* Updated all **environment variables** to match Postgres
* Fixed issues caused by Node + SQLite dependencies
* Added a production-ready **Dockerfile**
* Added a **docker-compose.yml** to run Strapi + Postgres together
* Cleaned build artifacts and rebuilt Strapi admin panel
* Verified containers and resolved port conflicts

---

# 📦 Environment Variables (`.env.docker`)

```env
# Server
HOST=0.0.0.0
PORT=1337
NODE_ENV=production

# Keys (replace with real secrets)
APP_KEYS=something1,something2
API_TOKEN_SALT=somethingrandom
ADMIN_JWT_SECRET=somethingsecure
TRANSFER_TOKEN_SALT=somethingrandom
JWT_SECRET=somethingrandom

# Database (Postgres)
DATABASE_CLIENT=postgres
DATABASE_HOST=db
DATABASE_PORT=5432
DATABASE_NAME=strapi
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_SSL=false
```

---

# 🛠 Dockerfile (for Strapi App)

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 1337

CMD ["npm", "start"]
```

---

# 🐳 docker-compose.yml

```yaml
version: "3.8"

services:
  strapi-app:
    build: .
    container_name: strapi-app
    env_file: .env.docker
    ports:
      - "1337:1337"
    depends_on:
      - strapi-db
    volumes:
      - .:/app
      - /app/node_modules

  strapi-db:
    image: postgres:15
    container_name: strapi-db
    environment:
      POSTGRES_USER: strapi
      POSTGRES_PASSWORD: strapi
      POSTGRES_DB: strapi
    ports:
      - "5433:5432"   # changed to avoid local port conflict
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

---

# ▶️ Running the App

```bash
docker compose up --build
```

Visit the admin panel:

```
http://localhost:1337/admin
```

---

# 🧹 Clean Before Rebuild (Optional)

If needed:

```bash
npm install rimraf -g
rimraf .cache build dist
```

---

# ✔️ Result

The project now runs fully containerized with a stable Postgres database, using production-grade environment configurations. Strapi builds correctly and the admin panel loads with no missing-file errors.

---

Video Link: https://www.loom.com/share/4834c5249f0a4df99f581e441c8a7f4a