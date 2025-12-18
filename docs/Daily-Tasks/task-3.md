Dockerized Strapi Setup with PostgreSQL and Nginx
Overview

This project sets up a complete Dockerized environment for Strapi, PostgreSQL, and Nginx.
The goal is to run Strapi with a PostgreSQL database and expose it to the browser through an Nginx reverse proxy.

The stack includes:

PostgreSQL as the database

Strapi as the CMS application

Nginx as a reverse proxy for routing external traffic to Strapi

All containers communicate through a user-defined Docker network.

Project Structure
.
├── docker-compose.yml
├── Dockerfile (optional if using local Strapi build)
├── nginx/
│   └── nginx.conf
└── strapi-data/   (Strapi app volume)

1. User-Defined Docker Network

A custom network strapi-net is created so that all services can communicate internally without exposing unnecessary ports.

networks:
  strapi-net:
    driver: bridge

2. PostgreSQL Configuration

A PostgreSQL 15 container is set up with environment variables required for Strapi to connect.

Environment Variables Configured

POSTGRES_USER

POSTGRES_PASSWORD

POSTGRES_DB

These allow Strapi to authenticate with PostgreSQL and operate using a persistent database.

A Docker volume (postgres_data) is used to store database data.

Example from docker-compose:

postgres:
  image: postgres:15
  environment:
    POSTGRES_USER: strapi
    POSTGRES_PASSWORD: strapi123
    POSTGRES_DB: strapidb

3. Strapi Configuration

The Strapi container uses environment variables to connect to PostgreSQL.

Environment Variables Configured for Strapi

DATABASE_CLIENT

DATABASE_HOST

DATABASE_PORT

DATABASE_NAME

DATABASE_USERNAME

DATABASE_PASSWORD

These ensure Strapi uses PostgreSQL instead of the default SQLite database.

Strapi is connected to the same network (strapi-net) so it can communicate with the "postgres" service internally.

Strapi data is stored using the volume:

./strapi-data:/srv/app

4. Nginx Reverse Proxy Setup

Nginx is configured to forward incoming HTTP requests (port 80) to the internal Strapi container running on port 1337.

Key Responsibilities:

Accept traffic at http://localhost

Proxy all traffic to http://strapi:1337

nginx.conf sample:

location / {
    proxy_pass http://strapi:1337;
}


This ensures Strapi is accessible through the browser without exposing its internal port.

5. Accessing the Application

Once all services are running:

Open in browser:

http://localhost/admin


This loads the Strapi Admin Panel through Nginx → Strapi → PostgreSQL.

6. Running the Setup
Start all services
docker-compose up -d 

or 

docker-compose -f task3-compose.yaml up 

Stop services
docker-compose down

7. Summary

This setup includes:

Configured PostgreSQL with proper credentials

Configured Strapi to use PostgreSQL via environment variables

Created a user-defined Docker network for clean communication

Configured Nginx as a reverse proxy on port 80

Successfully accessed Strapi Admin at http://localhost/admi

---

Video Link: https://www.loom.com/share/74c4a95cde284f8987e543b72f09f973