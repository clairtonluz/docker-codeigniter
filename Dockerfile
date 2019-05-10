FROM php:7.3-apache
RUN a2enmod rewrite
RUN a2enmod headers
RUN apt-get update && apt-get install -y libpq-dev unzip libaio1 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev 
RUN pecl install mcrypt-1.0.2
RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-install gd mysqli pgsql
RUN echo 'PassEnv CI_ENV' > /etc/apache2/conf-enabled/expose-env.conf

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN mkdir -p /var/lib/php/sesion && chown -R www-data:www-data /var/lib/php/
RUN echo 'session.save_path = "/var/lib/php/sesion"' >> /usr/local/etc/php/php.ini


# OCI8
ARG ORACLE_VERSION='11.2.0.4.0'
ARG INSTANT_CLIENT_FOLDER='instantclient_11_2'
ARG INSTANT_CLIENT_LIB='libclntsh.so.11.1'
# ARG ORACLE_VERSION='12.2.0.1.0'
# ARG INSTANT_CLIENT_FOLDER='instantclient_12_2'
# ARG INSTANT_CLIENT_LIB='libclntsh.so.12.1'

ADD oracle/instantclient-basic-linux.x64-$ORACLE_VERSION.zip /tmp/
ADD oracle/instantclient-sdk-linux.x64-$ORACLE_VERSION.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-$ORACLE_VERSION.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sdk-linux.x64-$ORACLE_VERSION.zip -d /usr/local/

RUN ln -s /usr/local/$INSTANT_CLIENT_FOLDER /usr/local/instantclient && \
    ln -s /usr/local/instantclient/$INSTANT_CLIENT_LIB /usr/local/instantclient/libclntsh.so

ENV LD_LIBRARY_PATH /usr/local/instantclient
ENV TNS_ADMIN /usr/local/instantclient
ENV ORACLE_BASE /usr/local/instantclient
ENV ORACLE_HOME /usr/local/instantclient

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8

RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \
    docker-php-ext-install oci8 && \
    rm -Rf /tmp/* && \
    ls -la /tmp

EXPOSE 80
