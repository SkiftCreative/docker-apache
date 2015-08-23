FROM eboraas/debian:jessie
MAINTAINER Shawn McElroy

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /dev/stdout

RUN apt-get update \
    && apt-get -y install \
        apache2 \
    && apt-get clean \
    && a2enmod socache_shmcb rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && rm -f /etc/apache2/sites-enabled/* \
    && rm -f /etc/apache2/sites-available/* \
    && sed -i 's/export APACHE_LOG_DIR.*/export APACHE_LOG_DIR=\/dev\/stdout/g' /etc/apache2/envvars

COPY vhost/000-default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80
EXPOSE 443

# CMD to start apache in your Dockerfile
# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
