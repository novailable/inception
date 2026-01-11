## Project Overview

This repository contains work completed within the **42 curriculum**, authored by *aoo*, as part of the **Inception** project.

## Inception

## Purpose

The **Inception** project is designed to introduce and solidify core containerization principles through the construction of a secure, modular service architecture using **Docker** and **Docker Compose**. Rather than relying on prebuilt images, each service is manually defined and built using custom Dockerfiles.

The final objective is to deploy a fully functional **WordPress** application exposed through **NGINX** over **HTTPS**, using **TLS 1.2 and 1.3 only**, with data persistence ensured by a **MariaDB** backend. Throughout the project, strict constraints are enforced to promote best practices in security, networking, and container lifecycle management.

This project focuses on:

* Distinguishing container-based systems from traditional virtual machines
* Writing reliable and standards-compliant Dockerfiles
* Properly configuring services, volumes, networks, and secrets
* Ensuring correct process handling (PID 1 compliance, no artificial keep-alive loops)

## Infrastructure Layout

The application stack is composed of the following elements:

* **NGINX service**
  Responsible for terminating TLS connections and serving HTTPS traffic exclusively.

* **WordPress service**
  Runs WordPress using **php-fpm** only; no web server is embedded in this container.

* **MariaDB service**
  Provides persistent database storage for WordPress.

* **Dedicated Docker network**
  Enables secure internal communication between services.

* **Persistent Docker volumes**

  * One volume for database storage
  * One volume for WordPress application files

All services:

* Are built from **custom Dockerfiles**
* Use **Debian Bookworm** as the base image
* Are configured to restart automatically in case of failure

## Setup Requirements

To run this project, the following are required:

* A Linux-based virtual machine
* Docker
* Docker Compose
* GNU Make

## Build and Deployment

To build images and start all services:

```bash
make up
```

## Shutdown and Cleanup

To stop services and remove containers:

```bash
make down
```

To completely remove containers, images, and volumes:

```bash
make fclean
```

## Accessing the Application

* URL: `https://aoo.42.fr`

Make sure that the domain name resolves to your local virtual machine by adding an entry to `/etc/hosts`.

## Architectural Decisions

### Containers Compared to Virtual Machines

* **Virtual machines** emulate entire operating systems, leading to higher resource usage and slower startup times.
* **Containers** operate by sharing the host kernel, making them lightweight, fast, and ideal for service-oriented architectures.

### Secrets Versus Environment Variables

* **Environment variables** are convenient but can be exposed through container inspection.
* **Docker secrets** enhance security by storing sensitive data as protected files within containers.

### Docker Networking Versus Host Networking

* **Custom Docker networks** provide isolation, built-in DNS resolution, and improved security.
* **Host networking** bypasses isolation and is explicitly disallowed in this project.

### Volumes Versus Bind Mounts

* **Docker volumes** are managed internally by Docker, offering better portability and safety.
* **Bind mounts** depend on host filesystem paths and are more prone to configuration errors.

## References

### Documentation

* Official Docker documentation
* Docker Compose reference
* NGINX documentation
* WordPress Codex
* MariaDB documentation

### Use of AI Tools

AI tools were used strictly as an educational aid to:

* Improve understanding of Docker-related concepts
* Review shell scripts and Dockerfile logic
* Assist in organizing project documentation

All implementation choices, debugging, and final validation were carried out independently.

---

If you want, I can also:

* Make it sound more academic
* Make it shorter (README-style)
* Adapt it to 42 evaluation expectations
* Rewrite it again with a different tone (technical, minimalist, or narrative)
