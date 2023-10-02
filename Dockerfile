FROM debian:11-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_TAG_VERSION

RUN set -eux; \
    apt-get update; \
    apt-get install -y apt-transport-https lsb-release ca-certificates curl wget; \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list; \
    apt-get update; \
    apt-get install -yq git libzip-dev zip unzip gnupg \
        # nodejs \
    ; \
    apt upgrade -yq --purge

RUN set -eux; \
    # apt-get install -y php${PHP_TAG_VERSION}
    apt-get update \
    ;

RUN set -eux; \
    apt-get install -y \
        php${PHP_TAG_VERSION}-bcmath \
        php${PHP_TAG_VERSION}-bz2 \
        php${PHP_TAG_VERSION}-cli \
        php${PHP_TAG_VERSION}-fpm \
        php${PHP_TAG_VERSION}-curl \
        php${PHP_TAG_VERSION}-decimal \
        php${PHP_TAG_VERSION}-enchant \
        # ffi 不支援 7.3
        # php${PHP_TAG_VERSION}-ffi \
        php${PHP_TAG_VERSION}-gd \
        php${PHP_TAG_VERSION}-gearman \
        php${PHP_TAG_VERSION}-gettext \
        php${PHP_TAG_VERSION}-gmp \
        php${PHP_TAG_VERSION}-gnupg \
        php${PHP_TAG_VERSION}-iconv \
        php${PHP_TAG_VERSION}-imap \
        # php${PHP_TAG_VERSION}-interbase \
        php${PHP_TAG_VERSION}-intl \
        php${PHP_TAG_VERSION}-ldap \
        php${PHP_TAG_VERSION}-mbstring \
        php${PHP_TAG_VERSION}-mcrypt \
        php${PHP_TAG_VERSION}-mongodb \
        php${PHP_TAG_VERSION}-mysql \
        php${PHP_TAG_VERSION}-odbc \
        php${PHP_TAG_VERSION}-opcache \
        php${PHP_TAG_VERSION}-pgsql \
        php${PHP_TAG_VERSION}-posix \
        php${PHP_TAG_VERSION}-pspell \
        php${PHP_TAG_VERSION}-redis \
        php${PHP_TAG_VERSION}-sqlite3 \
        # php${PHP_TAG_VERSION}-sybase \
        php${PHP_TAG_VERSION}-xmlwriter \
        php${PHP_TAG_VERSION}-zip \
        # php${PHP_TAG_VERSION}-hash \
        ;
RUN set -eux; \
    if  [ ${PHP_TAG_VERSION} != "7.3" ] && \
        [ ${PHP_TAG_VERSION} != "7.2" ] && \
        [ ${PHP_TAG_VERSION} != "7.1" ]; then \
        apt-get install -y php${PHP_TAG_VERSION}-ffi; \
    fi
# RUN set -eux; \
#     if [ $(php -r "echo PHP_MAJOR_VERSION;") != "7" ]; then \
#         if [ $(php -r "echo PHP_MINOR_VERSION;") != "4" ]; then \
#             if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
#                 apt-get install -y php${PHP_TAG_VERSION}-hash; \
#             fi; \
#         fi; \
#     fi
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
        apt-get install -y php${PHP_TAG_VERSION}-json; \
    fi
# RUN set -eux; \
#     if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
#         apt-get install -y php${PHP_TAG_VERSION}-mbstring; \
#     fi
# RUN set -eux; docker-php-ext-install oci8
# RUN set -eux; \
#     apt-get install -yqq unixodbc unixodbc-dev; \
#     docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \
#     docker-php-ext-install odbc
# RUN apt-get install -y php${PHP_TAG_VERSION}-pcntl
# RUN set -eux; \
    # apt-get install -yqq freetds-bin freetds-dev ;\
    # ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/ ;\
    # apt-get install -y php${PHP_TAG_VERSION}-pdo_dblib
# RUN set -eux; docker-php-ext-install pdo_oci
# RUN set -eux; docker-php-ext-install phar
RUN if [ ${PHP_TAG_VERSION} = "5.6" ] || [ ${PHP_TAG_VERSION} = "7.0" ] || [ ${PHP_TAG_VERSION} = "7.1" ] || [ ${PHP_TAG_VERSION} = "7.2" ]; then \
        apt-get install -y php${PHP_TAG_VERSION}-readline; \
    fi; \
    php -m | grep -oiE '^readline$'
# RUN set -eux; docker-php-ext-install reflection
# RUN set -eux; \
#     docker-php-ext-install session shmop simplexml snmp soap sockets
# RUN set -eux; docker-php-ext-install sodium
# RUN set -eux; docker-php-ext-install spl
# RUN set -eux; docker-php-ext-install standard
# RUN set -eux; \
#     docker-php-ext-install sysvmsg sysvsem sysvshm
# RUN set -eux; docker-php-ext-install tidy
RUN set -eux; \
    if [ $(PHP_TAG_VERSION) != "8.1" ]; then \
        apt-get install -y php${PHP_TAG_VERSION}-tokenizer; \
        php -m | grep -oiE '^tokenizer$'; \
    fi
RUN apt-get install -y php${PHP_TAG_VERSION}-xml; \
    php -m | grep -oiE '^xml$'
# RUN set -eux; docker-php-ext-install xmlreader
RUN set -eux; \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") != "8" ]; then \
        apt-get install -y php${PHP_TAG_VERSION}-xmlrpc; \
        php -m | grep -oiE '^xmlrpc$'; \
    fi
# RUN set -eux; docker-php-ext-install xsl
# RUN set -eux; docker-php-ext-install zend_test

RUN php${PHP_TAG_VERSION} -m

RUN set -eux; \
    # Install and run Composer
    curl -sS https://getcomposer.org/installer | phpphp${PHP_TAG_VERSION}; \
    mv composer.phar /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer; \
    # Install deployer
    curl -LO https://deployer.org/deployer.phar; \
    mv deployer.phar /usr/local/bin/dep; \
    chmod +x /usr/local/bin/dep;
