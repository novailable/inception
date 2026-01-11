FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    nano \
    openssl

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out    /etc/nginx/ssl/server.crt \
    -subj   "/C=SG/ST=Singapore/L=Singapore/O=42/CN=localhost"

# Copy nginx configuration
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
