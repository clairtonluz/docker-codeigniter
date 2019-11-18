FROM php:7.3-apache
RUN apt-get update \
    && apt-get install -y libpq-dev unzip libaio1 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libzip-dev zlib1g-dev  \
    && a2enmod rewrite \
    && a2enmod headers \
    && pecl install mcrypt-1.0.2 redis \
    && docker-php-ext-install -j$(nproc) zip mysqli pgsql iconv \
    && docker-php-ext-enable mcrypt redis \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

