# Inception Infrastructure User Guide

## Introduction

This document provides instructions on how to interact with the **Inception** infrastructure, both for end users and administrators. The system includes a secure, HTTPS-enabled WordPress website, a MariaDB database for content storage, and a robust Docker Compose setup for automatic service management.

## Components Overview

The following services are included in the Inception stack:

| Service   | Description                                         |
| --------- | --------------------------------------------------- |
| NGINX     | Handles HTTPS reverse proxy for secure traffic      |
| WordPress | A PHP-based website managed by WordPress            |
| MariaDB   | The database system used for storing WordPress data |

## Starting the Stack

To get the infrastructure running, execute the following command from the project’s root directory:

```bash
make up
```

This command will:

* Build the necessary Docker images
* Set up Docker networks and volumes
* Start all required containers

## Shutting Down the Stack

To stop all running services and bring the stack down:

```bash
make down
```

## Accessing the Website

The website can be accessed through the following URL:

* **Website URL:** [https://aoo.42.fr](https://aoo.42.fr)

Make sure to add the domain to your `/etc/hosts` file to point it to your VM's IP address:

```text
127.0.0.1  aoo.42.fr
```

## Accessing the WordPress Admin Panel

To log in to the WordPress administration interface, visit:

* **Admin Panel URL:** [https://aoo.42.fr/wp-admin](https://aoo.42.fr/wp-admin)

You'll need to use the administrator username and password set during the installation process. Note: The admin username **cannot** include common terms like `admin` or `administrator`.

## Credential Management

Sensitive credentials, such as database access and WordPress admin details, are securely stored using **Docker secrets**. These include:

* The MariaDB root password
* The MariaDB password for the WordPress user
* The WordPress administrator credentials

These secrets are securely mounted in the containers under the directory:

```text
/run/secrets/
```

**Important:** Do **not** modify these files directly.

## Monitoring Services

You can check the status of running containers and their logs using the following commands:

* List running containers:

  ```bash
  docker container ps
  ```

* View logs for a specific service:

  ```bash
  docker logs nginx
  docker logs wordpress
  docker logs mariadb
  ```

* List Docker volumes:

  ```bash
  docker volume ls
  ```

## Data Storage and Persistence

Persistent data, including the WordPress database and website files, is stored on the host at:

```text
/home/aoo/data/
```

This data remains unaffected even if the containers are stopped, restarted, or rebuilt.

---

This guide should help you effectively interact with the **Inception** infrastructure, whether you're managing the environment or simply using the website.
