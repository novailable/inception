# Developer Guide for Inception Project

## Overview

This document provides detailed instructions for developers on how to set up, build, run, and maintain the **Inception** project from the ground up. It covers prerequisites, project structure, secrets configuration, and common maintenance tasks.

## Prerequisites

Before you start, ensure your development environment is set up with the following:

* A Linux-based virtual machine
* Docker and Docker Compose
* Make utility

Verify Docker is running with this command:

```bash
sudo systemctl status docker
```

## Project Directory Structure

Here’s an overview of the project's file and folder structure:

```text
Inception/
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
│   ├── mariadb_pw
│   ├── mariadb_root_pw
│   ├── wordpress_db_pw
│   ├── wordpress_admin_pw
│   └── wordpress_user_pw
└── srcs/
    ├── docker-compose.yml
    ├── requirements/
    │   ├── nginx/
    │   │   ├── Dockerfile
    │   │   └── conf/
    │   │       └── nginx.conf
    │   ├── wordpress/
    │   │   ├── Dockerfile
    │   │   └── tools/
    │   │       └── setup.sh
    │   └── mariadb/
    │       ├── Dockerfile
    │       └── tools/
    │           └── entrypoint.sh
```

### Key Directories & Files:

* **Makefile**: Defines commands to manage the project lifecycle (build, deploy, clean, etc.)
* **secrets/**: Stores sensitive information such as passwords for MariaDB and WordPress. These files **should not** be committed to version control.
* **srcs/**: Contains the Dockerfiles, configuration files, and setup scripts for the different services (NGINX, WordPress, MariaDB).

## Secrets Configuration

Sensitive information (e.g., database credentials, admin passwords) is stored in the `secrets/` folder and passed to the containers via Docker Compose.

### Secret Files:

* `mariadb_pw`
* `mariadb_root_pw`
* `wordpress_db_pw`
* `wordpress_admin_pw`
* `wordpress_user_pw`

**Important:** These files must **never** be committed to version control.

## Building the Project

To build the project, use the following command:

```bash
make build
```

This command will:

* Build Docker images from each service's respective Dockerfile.
* Use only Debian-based images for consistency.

## Starting the Stack

To launch the full stack (including NGINX, WordPress, and MariaDB), run:

```bash
make up
```

This is equivalent to:

```bash
docker compose up -d --build
```

## Managing the Stack with Makefile Commands

You can control the stack's lifecycle using the `Makefile`:

* **Restart services**: Rebuild the containers and restart all services:

  ```bash
  make restart
  ```

* **Stop services**: Bring down all running containers:

  ```bash
  make down
  ```

* **Remove all containers and volumes**: Completely clean up the project, including volumes:

  ```bash
  make fclean
  ```

## Volumes & Data Persistence

Persistent data for the project is stored on the host machine at:

```text
/home/aoo/data/
```

This includes:

* **MariaDB data**: Database files
* **WordPress data**: Website files, themes, and plugins

| Volume           | Purpose                  |
| ---------------- | ------------------------ |
| `mariadb_data`   | Stores database files    |
| `wordpress_data` | Stores WordPress content |

Data will persist even if the containers are rebuilt, unless the volumes are explicitly removed.

## Networking

* A dedicated Docker bridge network is used to allow communication between containers.
* Containers interact with each other by using their service names (e.g., `nginx`, `wordpress`, `mariadb`).
* **Note**: The `network: host` and `--link` options are **not allowed**.

## Process Management (PID 1)

Each container runs a single main process:

* **NGINX**: The web server (nginx)
* **WordPress**: PHP-FPM (php-fpm)
* **MariaDB**: MySQL (mysqld)

Each container is set up to avoid common pitfalls like infinite loops (`tail -f`, `sleep infinity`, etc.), ensuring that the main process runs in the foreground.

## Debugging and Troubleshooting

### Logs:

To view logs for the services, use:

```bash
docker compose logs -f
```

### Entering a Container:

You can access a running container to debug or inspect it. For example, to access the WordPress container:

```bash
docker exec -it wordpress sh
```

### Inspecting Volumes:

If you need to inspect a volume, use:

```bash
docker volume inspect <volume_name>
```

## Routine Maintenance

To ensure the infrastructure remains stable and secure, perform the following tasks regularly:

* **Update SSL/TLS certificates**: Rebuild the NGINX image whenever certificates need to be updated.
* **Update WordPress files**: Modify the WordPress files by working with the `wordpress_data` volume.
* **Backup data**: Regularly back up the `/home/aoo/data/` directory to avoid data loss.

---

This developer guide provides the necessary steps and best practices for building, deploying, and maintaining the **Inception** infrastructure.
