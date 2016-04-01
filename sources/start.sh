#!/bin/bash

chown -Rf www-data.www-data /var/www/

# Starting PHP 7 service
service php7.0-fpm start

# Restart Nginx service
service nginx restart

# Start SSH service
service ssh restart
