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
# php7-intl will fail to compile unless g++ is given the c++11 flag because of char16_t and other types.
ENV CXXFLAGS="-std=c++11"
# libjpeg-turbo-dev doesn't get detected by php7-gd's configure script so we have to manually specify the include dir
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include && docker-php-ext-install gd
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip

# Build & install the rar module
RUN pecl install rar && docker-php-ext-enable rar

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Cleanup
RUN apk del --purge autoconf \
                    g++ \
                    make \
                    && rm -rf /var/cache/apk/*

WORKDIR /var/www/mangapie

VOLUME "/manga"