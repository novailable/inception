FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    mariadb-server \
    nano \
    curl \
 && rm -rf /var/lib/apt/lists/*

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]

