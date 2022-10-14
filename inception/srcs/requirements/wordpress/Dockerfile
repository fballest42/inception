FROM debian:buster

LABEL manteiner="fballest <fballest@student.42madrid.com>"

#ARG EMAIL_USER
#ARG EMAIL_ADMIN
#ARG HTTP_NAME
#ARG WP_USER_NAME
#ARG WP_USER_PASS
#ARG WP_ADMIN_NAME
#ARG WP_ADMIN_PASS
#ARG MARIADB_NAME
#ARG MARIADB_USER
#ARG MARIADB_PASS

RUN apt-get update
RUN apt-get install -y php7.3-fpm \
    php7.3-mysqli \
    mariadb-client \
    wget \
    sendmail \
    vim

WORKDIR /var/www

RUN wget https://es.wordpress.org/latest-es_ES.tar.gz && \
	tar -xvzf latest-es_ES.tar.gz && rm -rf latest-es_ES.tar.gz

RUN mkdir -p /var/run/php

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY tools/wpsetup.sh /var
RUN chmod +x /var/wpsetup.sh
RUN chown -R www-data:www-data /var/www/wordpress

CMD ["bash", "/var/wpsetup.sh"]
