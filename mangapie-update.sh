#!/bin/bash

# Make sure we're in the correct dir
cd /var/www/mangapie
# Update mangapie from github
echo "Updating mangapie..."
php artisan down
git pull
# Update the vendor dependencies, if any
echo "Updating dependencies..."
composer install --no-plugins
# Publish any vendor configs, if any
php artisan mangapie:init

php artisan up