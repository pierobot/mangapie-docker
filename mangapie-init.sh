#!/bin/bash

composer install --no-plugins

php artisan mangapie:init

chown -R www-data:www-data storage
chmod -R ug+w storage
chown -R www-data:www-data bootstrap/cache
chmod -R ug+w bootstrap/cache
