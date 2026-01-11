This project has been created as part of the 42 curriculum by aoo.

# Inception

## Description
The **Inception** project aims to introduce containerization concepts by building a small, secure, and modular infrastructure using **Docker** and **Docker Compose**. The stack is composed of multiple services, each running in its own dedicated container and built from custom Dockerfiles.

The main goal is to deploy a WordPress website served through **NGINX** with **TLS (v1.2/v1.3)**, backed by a **MariaDB** database, while following strict rules regarding security, networking, volumes, and process management.

This project emphasizes:
- Understanding how containers differ from virtual machines
- Writing clean and correct Dockerfiles
- Managing services, networks, volumes, and secrets properly
- Respecting Docker best practices (PID 1, no infinite loops, no hacky keep-alive commands)

# Project Architecture
The infrastructure consists of:
- **NGINX container**: Handles HTTPS traffic (TLS only)
- **WordPress container**: Runs WordPress with php-fpm (no nginx inside)
- **MariaDB container**: Hosts the WordPress database
- **Docker network**: Enables internal communication between containers
- **Docker volumes**:
  - WordPress database data
  - WordPress website files

All containers:
- Are built from **custom Dockerfiles**
- Are based on **Debian bookworm (penultimate stable)**
- Restart automatically on failure

## Instructions

# Requirements
- Linux virtual machine
- Docker
- Docker Compose
- Make

# Build and Run dockerfiles
```bash
make up
```

# Stop and Clean
```bash
make down
```

# Full Cleanup (including volumes)
```bash
make fclean
```

# Access
- Website: https://aoo.42.fr

Ensure that `aoo.42.fr` points to your local VM IP in `/etc/hosts`.

## Design Choices & Comparisons

### Virtual Machines vs Docker
- **VMs** virtualize entire operating systems, consuming more resources.
- **Docker containers** share the host kernel, are lightweight, faster to start, and better suited for microservices.

### Secrets vs Environment Variables
- **Environment variables** are easy to use but may be exposed via `docker inspect`.
- **Docker secrets** provide safer credential handling by mounting sensitive data as files with restricted access.

### Docker Network vs Host Network
- **Docker network** offers isolation, DNS-based service discovery, and security.
- **Host network** removes isolation and is forbidden in this project.

### Docker Volumes vs Bind Mounts
- **Volumes** are managed by Docker, portable, and safer for persistent data.
- **Bind mounts** depend on host paths and are more error-prone.

## Resources

### Technical References
- Docker documentation
- Docker Compose documentation
- NGINX official documentation
- WordPress Codex
- MariaDB documentation

### AI Usage
AI was used as a **learning and support tool** to:
- Clarify Docker and Docker Compose concepts
- Review shell scripts and Dockerfiles
- Help structure documentation

All design decisions, code, and debugging were implemented and validated manually.
