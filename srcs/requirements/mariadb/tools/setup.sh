#!/bin/bash
set -e

#export database keys
export MARIADB_ROOT_PW=$(cat /run/secrets/DbRoot_password)
export MARIADB_USER_PW=$(cat /run/secrets/DbUser_password)

echo "[Database] MariaDB initializing..."

#create directories
mkdir -p /var/run/mysqld
mkdir -p /var/lib/mysql

#fix permissions
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod 755 /var/run/mysqld
chmod 755 /var/lib/mysql

#initialize database
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[Database] First start detected, initializing database..."
    mysql_install_db \
        --user=mysql \
        --datadir=/var/lib/mysql \
        --skip-test-db
fi

echo "[Database] Running on background..."
mysqld --user=mysql \
    --skip-networking &

echo "[Database] Waiting to start..."
until mysqladmin \
    ping --silent; do
    sleep 1
done


if mysql -u root -e "SELECT 1" &>/dev/null; then
    echo "[Database] Entrypoint: Connecting to root without password..."
    AUTH_CMD="mysql -u root"
else
    echo "[Database] Entrypoint: Retrying with password..."
    AUTH_CMD="mysql -u root --password=${MARIADB_ROOT_PW}"
fi

    echo "[Database] Creating users and database (first run)..."
    ${AUTH_CMD}<<EOF
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PW}';
        CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
        CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PW}';
        GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
        FLUSH PRIVILEGES;
EOF
    echo "[Database] Complete."

echo "[Database] Attempting user password..."
mysqladmin --user=root --password="${MARIADB_ROOT_PW}" shutdown

echo "[Database] Starting database (production)..."
exec mysqld --user=mysql --bind-address=0.0.0.0
