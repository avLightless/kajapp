FROM php:8.1-cli


# get symfony
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list && apt update
RUN apt install -y symfony-cli
# get system tools
RUN apt install -y wget zip
# get composer
RUN wget -O /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar && chmod +x /usr/local/bin/composer
RUN groupadd app && useradd -m -g app app
# use "app" user
USER app
