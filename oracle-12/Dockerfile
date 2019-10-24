FROM clairtonluz/codeigniter

# OCI8
ARG ORACLE_VERSION='12.2.0.1.0'
ARG INSTANT_CLIENT_FOLDER='instantclient_12_2'
ARG INSTANT_CLIENT_LIB='libclntsh.so.12.1'

ADD instantclient-basic-linux.x64-$ORACLE_VERSION.zip /tmp/
ADD instantclient-sdk-linux.x64-$ORACLE_VERSION.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-$ORACLE_VERSION.zip -d /usr/local/ \
    && unzip /tmp/instantclient-sdk-linux.x64-$ORACLE_VERSION.zip -d /usr/local/ \
    && ln -s /usr/local/$INSTANT_CLIENT_FOLDER /usr/local/instantclient \
    && ln -s /usr/local/instantclient/$INSTANT_CLIENT_LIB /usr/local/instantclient/libclntsh.so

ENV LD_LIBRARY_PATH /usr/local/instantclient
ENV TNS_ADMIN /usr/local/instantclient
ENV ORACLE_BASE /usr/local/instantclient
ENV ORACLE_HOME /usr/local/instantclient

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8 \
    && docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient \
    && docker-php-ext-install oci8 \
    && rm -Rf /tmp/*

EXPOSE 80
