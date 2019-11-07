FROM php:7.3-fpm
RUN apt-get update \
    && apt-get install -y libpq-dev unzip libaio1 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
    && a2enmod rewrite \
    && a2enmod headers \
    && pecl install mcrypt-1.0.2 redis \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-enable mcrypt redis \
    && docker-php-ext-install -j$(nproc) gd mysqli pgsql \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
