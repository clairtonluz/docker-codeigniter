FROM php:7.3-apache
RUN a2enmod rewrite
RUN apt-get update && apt-get install -y libpq-dev
RUN docker-php-ext-install mysqli pgsql
RUN echo 'PassEnv CI_ENV' > /etc/apache2/conf-enabled/expose-env.conf && \
	echo 'PassEnv DB_HOST' >> /etc/apache2/conf-enabled/expose-env.conf && \
	echo 'PassEnv DB_USER' >> /etc/apache2/conf-enabled/expose-env.conf && \
	echo 'PassEnv DB_PASS' >> /etc/apache2/conf-enabled/expose-env.conf && \
	echo 'PassEnv DB_NAME' >> /etc/apache2/conf-enabled/expose-env.conf
EXPOSE 80
