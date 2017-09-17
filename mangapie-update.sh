#!/bin/bash

# Make sure we're in the correct dir
cd /var/www/mangapie
# Update mangapie from github
echo "Updating mangapie..."
git pull
# Update the vendor dependencies, if any
echo "Updating dependencies..."
composer update --no-plugins
# Publish any vendor configs, if any
php artisan mangapie:init
