# Inception Project

## Overview
Inception is a Docker-based LEMP stack deployment that orchestrates three main services:

- **MariaDB**: A relational database container.
- **WordPress**: A PHP-based CMS container, managed via WP-CLI.
- **Nginx**: A reverse proxy and SSL terminator serving the WordPress front end.

All services run in Docker containers, connected through a user-defined network, with data persistently stored on the host machine.

## Architecture

```text
            ┌────────────────┐       ┌────────────┐
            │   mariadb      │◄──────│ wordpress  │
            │   (3306)       │       │  (9000)    │
            └────────────────┘       └─────┬──────┘
                                           │
                                           ▼
                                      ┌────────┐
                                      │ nginx  │
                                      │  (443) │
                                      └────────┘
```  
- **User ➔ Nginx** over HTTPS (port 443)  
- **Nginx ➔ WordPress** via FastCGI on port 9000  
- **WordPress ➔ MariaDB** on port 3306  

## Prerequisites

- Docker Engine & Docker Compose
- GNU Make
- `bash` or `zsh` shell

## Installation & Usage

1. Clone the repository and change into the project folder:
   ```bash
   git clone https://github.com/LAHMAMI1/Inception Inception
   cd Inception
   ```
2. Create and start containers:
   ```bash
   make all      # Launch services (build if needed, start detached)
   ```
3. Rebuild images and restart:
   ```bash
   make re       # Force rebuild of all services
   ```
4. Stop containers:
   ```bash
   make down     # Stop services without removing images
   ```
5. Cleanup:
   ```bash
   make clean    # Stop containers and prune unused Docker resources
   make fclean   # Full cleanup (stop all containers, remove networks, volumes, images)
   ```

> **Note:** The WordPress data and MariaDB data are stored under `/home/olahmami/data/wordpress` and `/home/olahmami/data/mariadb` on the host.

## Project Structure

```
├── Makefile
├── README.md            # (this file)
└── srcs
    ├── .env             # Environment variables for services
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf/olahmamiDB.cnf
        │   └── tools/database-init.sh
        ├── wordpress
        │   ├── Dockerfile
        │   ├── conf/wp-config.sh
        │   └── tools/create-dir.sh
        └── nginx
            ├── Dockerfile
            └── conf/olahmami.42.fr.conf
```

## Service Details

### MariaDB
- Base image: `debian:bookworm`
- Installs `mariadb-server`
- Custom configuration in `olahmamiDB.cnf`:
  - Listens on `0.0.0.0:3306`
- Initializes database and user via `database-init.sh`.
- Data directory bound to `~/data/mariadb`.

### WordPress
- Base image: `debian:bookworm`
- Installs PHP 8.2, FPM, mysqli extension, curl, and `mariadb-client`
- Adjusts FPM to listen on `0.0.0.0:9000`
- Uses WP-CLI to:
  1. Download WordPress core
  2. Create `wp-config.php` from env variables
  3. Install site, admin user, and secondary subscriber
  4. Update `home` and `siteurl` options
- Serves files from `/var/www`
- Data directory bound to `~/data/wordpress`.
  
### Nginx
- Base image: `debian:bookworm`
- Installs `nginx` and `openssl` for a self-signed SSL certificate
- SSL cert and key generated at build time under `/etc/nginx/ssl`
- Custom site config in `olahmami.42.fr.conf`
- Exposes port 443 only, forwarding requests to the WordPress FPM upstream.

## Volumes & Network

- **Volumes** (host bind to `/home/olahmami/data`):
  - `db-volume`  → `/var/lib/mysql`
  - `wp-volume`  → `/var/www`
- **Network**:
  - `webapp-network` (bridge), isolates containers from default Docker network

## Learning Objectives

- Containerize each layer of a LEMP stack (Linux, Nginx, MariaDB, PHP/WordPress).
- Write Dockerfiles from scratch using a minimal base (`debian:bookworm`).
- Orchestrate multi-container applications with Docker Compose.
- Manage persistent data with Docker volumes and host bind mounts.
- Automate initialization tasks via shell scripts (`database-init.sh`, `create-dir.sh`, `wp-config.sh`).
- Secure traffic with self-signed SSL certificates and Nginx configuration.
- Leverage WP-CLI for non-interactive WordPress setup.
- Explore Makefile targets for repeatable workflows.

## Troubleshooting

- **Ports in Use**: If port 443 or 3306 is already in use, stop conflicting services or change the ports in `srcs/docker-compose.yml` and Nginx config.
- **Database Connection Fails**: Ensure `/home/${USER}/data/mariadb` exists and has proper permissions. Check `MARIADB_*` env vars in `srcs/.env`.
- **WordPress Not Loading**: Verify WP-CLI commands by entering the container:
  ```zsh
  docker exec -it wordpress bash
  # Inside container:
  wp --info
  ```
- **SSL Certificate Errors**: Trust the self-signed cert or replace with a valid certificate by mounting your own files into `/etc/nginx/ssl`.
