FROM php:7-fpm-alpine

MAINTAINER pierobot

# Update with community repository as some of these php modules are there
RUN apk add --update \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
        autoconf \
        bash \
        g++ \
        git \
        make \
        mysql-client \
        mariadb-client \
        musl \
        ### get the libs and headers we need to build and use some php modules
        icu-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libzip-dev \
        zlib-dev \
        gd-dev \
        ### php modules
        php7-ctype \
        php7-curl \
        php7-dom \
        # php7-gd \
        # php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        # php7-pdo_mysql \
        php7-posix \
        php7-session \
        php7-tidy \
        php7-xml
        # php7-zip

# The packages commented above are not being detected by PHP so let's have fun building.

# libjpeg-turbo-dev doesn't get detected by php7-gd's configure script so we have to manually specify the include dir
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include && docker-php-ext-install gd
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install sockets
RUN docker-php-ext-install zip

# Build & install the inotify module
RUN pecl install inotify && docker-php-ext-enable inotify

# Build & install the rar module
RUN git clone https://github.com/cataphract/php-rar && \
    cd php-rar && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    docker-php-ext-enable rar

# Build & install the redis module
RUN pecl install redis && docker-php-ext-enable redis

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Cleanup
RUN apk del --purge autoconf \
                    g++ \
                    make \
                    && rm -rf /var/cache/apk/*

RUN deluser www-data && \
    addgroup -g 3390 -S www-data && \
    adduser -u 3390 -D -S -G www-data www-data
