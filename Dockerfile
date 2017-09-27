FROM php:5-apache

MAINTAINER Michon van Dooren <michon1992@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y libpq-dev freetds-dev
RUN cp -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/
RUN docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql mssql

# Add + compile adminer
COPY adminer/ /var/www/html/adminer/
WORKDIR /var/www/html/adminer
RUN php compile.php

# Add the index page
COPY index.php /var/www/html
COPY load.php /plugins/load.php

# The volume for plugins
VOLUME /plugins
