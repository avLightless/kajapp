FROM php:8.1-apache

# install PHP extension dependencies
RUN apt-get update && apt-get install -y zip libicu-dev libpq-dev wget

# install PHP extensions and set up php and apache configs
RUN docker-php-ext-install opcache intl pdo pdo_pgsql && \
    mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
COPY ./infrastructure/apache2.conf /etc/apache2/apache2.conf
COPY ./infrastructure/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY ./infrastructure/php-config.ini /usr/local/etc/php/conf.d/custom.ini

# copy the source code
COPY . /var/www
WORKDIR /var/www

# install composer, then install the dependencies and remove composer immediately
RUN wget -O /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    composer i -o --prefer-dist --no-progress --no-scripts --no-dev && \
    rm /usr/local/bin/composer

# set the default user to the one declared in the php-*-apache containers
USER $APACHE_RUN_USER:$APACHE_RUN_GROUP