FROM eboraas/debian:jessie
MAINTAINER Shawn McElroy

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /dev/stdout

RUN apt-get update \
    && apt-get -y install apache2 \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && a2enmod rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && rm -f /etc/apache2/sites-enabled/* \
    && rm -f /etc/apache2/sites-available/* \
    && sed -i 's/export APACHE_LOG_DIR.*/export APACHE_LOG_DIR=\/dev\/stdout/g' /etc/apache2/envvars \
    && sed -i 's/^ErrorLog .*/ErrorLog \/dev\/stdout/g' /etc/apache2/apache2.conf \
    && sed -i 's/^CustomLog .*/#CustomLog \/dev\/stdout vhost_combined/g' /etc/apache2/conf-enabled/other-vhosts-access-log.conf

COPY vhosts/000-default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80
EXPOSE 443

# CMD to start apache in your Dockerfile
# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
