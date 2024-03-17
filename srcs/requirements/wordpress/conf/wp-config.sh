#!/bin/sh

# download wordpress and create wp-config.php
wp core download --allow-root
wp config create --dbhost=$DBHOST --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DBPASS --allow-root
wp core install --url=$URL --title=$TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL --allow-root
wp user create $OTHER_USER $OTHER_MAIL --role=subscriber --user_pass=$OTHER_PASS --allow-root
wp option update home '$URL'
wp option update siteurl '$URL'

# start php-fpm
/usr/sbin/php-fpm8.2 -F