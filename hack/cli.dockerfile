FROM php:8.1-cli

# get symfony
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list \
    && apt-get update
RUN apt-get install -y symfony-cli
# get system tools
RUN apt-get install -y wget zip libicu-dev
# get composer
RUN wget -O /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar && chmod +x /usr/local/bin/composer
RUN groupadd app && useradd -m -g app app
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
	docker-php-ext-install opcache intl
# use "app" user
USER app
