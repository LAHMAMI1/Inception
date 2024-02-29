# Image base
FROM debian:bookworm

# Update and install packages
RUN apt-get update
RUN apt install -y nginx openssl

# Generate self-signed SSL certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
    -keyout /etc/nginx/ssl/olahmami.42.fr.key \
    -out /etc/nginx/ssl/olahmami.42.fr.crt \
    -subj "/C=MA/ST=Benguerir/L=Benguerir/O=42-Network/OU=1337/CN=olahmami.42.fr"

# Copy nginx config file
COPY ./conf/olahmami.42.fr.conf /etc/nginx/conf.d
COPY ./tools/index.html /var/www/html

# Expose port
EXPOSE 443

# Execute nginx
CMD ["nginx", "-g", "daemon off;"]
