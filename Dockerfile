ARG PHP_TAG_VERSION
FROM php:${PHP_TAG_VERSION}

ARG PHP_TAG_VERSION

RUN set -eux; \
    apt-get update; \
    apt-get install -yq \
        git \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libxml2-dev \
        libjpeg-dev  \
        libpng-dev \
        libgmp3-dev \
        libicu-dev \
        libldap2-dev \
        libpq-dev \
        libsqlite3-dev \
        libpspell-dev \
        libedit-dev \
        librecode-dev \
        libsnmp-dev \
#     libmcrypt-dev libpq-dev libvpx-dev libxpm-dev zlib1g-dev libfreetype6-dev libexpat1-dev unixodbc-dev libaspell-dev libpcre3-dev libtidy-dev
        libzip-dev zip unzip \
        gnupg \
        nodejs \
    ; \
    if [ ${PHP_TAG_VERSION} = "5.6" ] || [ ${PHP_TAG_VERSION} = "7.0" ] || [ ${PHP_TAG_VERSION} = "7.1" ] || [ ${PHP_TAG_VERSION} = "7.2" ]; then \
        apt-get install -yq libenchant-dev; \
    else \
        apt-get install -yq libenchant-2-dev; \
    fi; \
    apt upgrade -yq --purge

RUN set -eux; \
    # Install and run Composer
    curl -sS https://getcomposer.org/installer | php; \
    mv composer.phar /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer; \
    # Install deployer
    curl -LO https://deployer.org/deployer.phar; \
    mv deployer.phar /usr/local/bin/dep; \
    chmod +x /usr/local/bin/dep;

RUN set -eux; \
    docker-php-ext-install bcmath bz2 calendar ctype curl dba dom enchant exif

RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "7" ]; then \
        if [ $(php -r "echo PHP_MINOR_VERSION;") = "4" ]; then \
            docker-php-ext-install ffi \
        ;fi \
    ;fi
RUN set -eux; docker-php-ext-install fileinfo
# RUN set -eux; docker-php-ext-install filter
# RUN set -eux; docker-php-ext-install ftp
RUN set -eux; docker-php-ext-install gd
RUN set -eux; docker-php-ext-install gettext
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
      ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    ;fi ;\
    docker-php-ext-install gmp
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "7" ]; then \
        if [ $(php -r "echo PHP_MINOR_VERSION;") != "4" ]; then \
            if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
                docker-php-ext-install hash \
            ;fi \
        ;fi \
    ;fi
RUN set -eux; docker-php-ext-install iconv
RUN set -eux; \
    apt-get install -y libc-client-dev libkrb5-dev ;\
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl ;\
    docker-php-ext-install imap
RUN set -eux; docker-php-ext-install intl
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
        docker-php-ext-install json \
    ;fi
RUN set -eux; \
    apt-get install -y libldap2-dev; \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ ;\
    docker-php-ext-install ldap
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "7" ]; then \
        if [ $(php -r "echo PHP_MINOR_VERSION;") = "4" ]; then \
            apt-get install -yqq libonig-dev \
        ;fi \
    ;fi
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
        docker-php-ext-install mbstring \
    ;fi
RUN set -eux; docker-php-ext-install mysqli
# RUN set -eux; docker-php-ext-install oci8
# RUN set -eux; \
#     apt-get install -yqq unixodbc unixodbc-dev; \
#     docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \
#     docker-php-ext-install odbc
RUN set -eux; docker-php-ext-install opcache
RUN set -eux; docker-php-ext-install pcntl
RUN set -eux; docker-php-ext-install pdo
RUN set -eux; \
    apt-get install -yqq freetds-bin freetds-dev ;\
    ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/ ;\
    docker-php-ext-install pdo_dblib
# RUN set -eux; docker-php-ext-install pdo_firebird
RUN set -eux; docker-php-ext-install pdo_mysql
# RUN set -eux; docker-php-ext-install pdo_oci
# RUN set -eux; \
#     apt-get install -yqq unixodbc unixodbc-dev; \
#     docker-php-ext-configure pdo_odbc --with-unixODBC=shared,/usr; \
#     docker-php-ext-install pdo_odbc
RUN set -eux; docker-php-ext-install pdo_pgsql
RUN set -eux; docker-php-ext-install pdo_sqlite
RUN set -eux; docker-php-ext-install pgsql
# RUN set -eux; docker-php-ext-install phar
RUN set -eux; docker-php-ext-install posix
RUN set -eux; docker-php-ext-install pspell
RUN set -eux; docker-php-ext-install readline
# RUN set -eux; docker-php-ext-install reflection
RUN set -eux; \
    docker-php-ext-install session shmop simplexml snmp soap sockets
# RUN set -eux; docker-php-ext-install sodium
# RUN set -eux; docker-php-ext-install spl
# RUN set -eux; docker-php-ext-install standard
RUN set -eux; \
    docker-php-ext-install sysvmsg sysvsem sysvshm
# RUN set -eux; docker-php-ext-install tidy
RUN set -eux; docker-php-ext-install tokenizer
RUN set -eux; docker-php-ext-install xml
# RUN set -eux; docker-php-ext-install xmlreader
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
        docker-php-ext-install xmlrpc \
    ;fi
RUN set -eux; docker-php-ext-install xmlwriter
# RUN set -eux; docker-php-ext-install xsl
# RUN set -eux; docker-php-ext-install zend_test
RUN set -eux; docker-php-ext-install zip

RUN set -eux; \
    php -m
