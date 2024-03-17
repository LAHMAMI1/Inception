# Image base
FROM debian:bookworm

# Update and install packages
RUN apt-get update && apt-get install -y \
    wget \
    php8.2 \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-curl \
    mariadb-client

RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|" /etc/php/8.2/fpm/pool.d/www.conf

# Download and install wordpress
WORKDIR /var/www
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy configuration file
COPY ./conf/wp-config.sh /var/www
RUN chmod +x /var/www/wp-config.sh

CMD ["sh", "/var/www/wp-config.sh"]
