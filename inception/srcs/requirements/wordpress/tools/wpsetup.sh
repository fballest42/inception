#!/bin/bash


#wp config create --dbname=${MARIADB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PASS} --dbhost='mariadb' --dbcharset='utf8' --locale='es_ES'

#cp /var/www/wp-config.php /var/www/wordpress/wp-config.php

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;

chmod +x wp-cli.phar;
mv wp-cli.phar /usr/local/bin/wp;

cd /var/www/wordpress

wp config create --allow-root --dbname=${MARIADB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PASS} --dbhost='mariadb' --dbcharset='utf8' --locale='es_ES' --path=/var/www/wordpress
wp core install --allow-root --url=${HTTP_NAME} --title="FBALLEST WORDPRESS HOMEPAGE" --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASS} --admin_email=${EMAIL_ADMIN} --path=/var/www/wordpress
wp user create --allow-root ${WP_USER_NAME} ${EMAIL_USER} --user_pass=${WP_USER_PASS} --role=editor --path=/var/www/wordpress

php-fpm7.3 -F;