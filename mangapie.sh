#!/bin/bash

set -e

fix_permissions() {
    chown -R www-data:www-data storage
    chmod -R ug+w storage
    chown -R www-data:www-data bootstrap/cache
    chmod -R ug+w bootstrap/cache
}

install_dependencies() {
    composer install --no-plugins

    php artisan mangapie:init
}

install() {
    cd /var/www/mangapie
    git clone https://github.com/pierobot/mangapie .
    cp .env.example .env

    fix_permissions
    install_dependencies
}

update() {
    cd /var/www/mangapie

    php artisan down

    git pull
    fix_permissions
    install_dependencies

    php artisan up
}

if [[ $1 = "install" ]]; then
    install
elif [[ $1 = "update" ]]; then
    update
fi
