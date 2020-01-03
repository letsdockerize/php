FROM php:7.2

RUN apt-get update -yqq
RUN apt-get install -yqq git \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libxml2-dev \
        libenchant-dev \
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
        gnupg \
        nodejs

# Install and run Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Install deployer
RUN curl -LO https://deployer.org/deployer.phar
RUN mv deployer.phar /usr/local/bin/dep
RUN chmod +x /usr/local/bin/dep

# Install PHP extensions
# RUN docker-php-ext-install mbstring curl json intl gd xml zip bz2 opcache
# - docker-php-ext-install mcrypt pdo_pgsql
RUN docker-php-ext-install bcmath bz2 calendar ctype curl dba dom enchant \
    exif fileinfo \
    # filter \ # need ?
    # ftp \ # need openssl
    gd gettext gmp \
    # hash iconv \ # default
    # imap \ # need 
    # interbase \ # bypass
    intl json ldap mbstring mysqli \
    # oci8 \ # bypass
    # odbc \ # need ?
    opcache pcntl pdo \
    # pdo_dblib \ # need ?
    # pdo_firebird \ # bypass
    pdo_mysql \
    # pdo_oci \ # bypass
    # pdo_odbc \ # need ?
    pdo_pgsql pdo_sqlite pgsql phar \
    # posix \ # default
    pspell \
    # readline \ #default
    recode \
    # reflection \ # default, need ?
    # session \ # default
    shmop simplexml snmp soap sockets \
    # sodium spl standard \
#     sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter \
    # xsl zend_test \
    zip

# Imap step
# apt-get install -y libc-client-dev libkrb5-dev && \
# docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
# docker-php-ext-install imap \

# Install & enable Xdebug for code coverage reports
RUN pecl update-channels \
 && pecl install xdebug \
 && docker-php-ext-enable xdebug
