FROM php:7.3-apache
RUN apt-get update \
    && apt-get install -y libpq-dev unzip libaio1 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
    && a2enmod rewrite \
    && a2enmod headers \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install gd mysqli pgsql \
    && mkdir -p /var/lib/php/sesion && chown -R www-data:www-data /var/lib/php/ \
    && echo 'session.save_path = "/var/lib/php/sesion"' >> /usr/local/etc/php/php.ini

EXPOSE 80
