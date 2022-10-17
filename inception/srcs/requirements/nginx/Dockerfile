FROM debian:buster

LABEL mantenier="fballest <fballest@student.42madrid.com>"

RUN apt-get -y update && apt-get -y install nginx openssl 

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/certs/fballest.42.fr.crt -keyout /etc/ssl/certs/fballest.42.fr.key -subj "/C=ES/ST=Madrid/L=Madrid/O=42_Madrid/CN=fballest.42.fr"

RUN rm -rf /etc/nginx/sites-enabled/*

COPY ./conf/nginx.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
