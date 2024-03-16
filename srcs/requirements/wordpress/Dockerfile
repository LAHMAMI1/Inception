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
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    cp -r wordpress/* . && \
    rm -rf latest.tar.gz wordpress

# Copy configuration file
COPY ./conf/wp-config.php /var/www/

CMD ["/usr/sbin/php-fpm8.2", "-F"]
