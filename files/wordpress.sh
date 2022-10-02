#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz

sudo mv wordpress/ /var/www/html

sudo mv /tmp/wp-config.php /var/www/html/wordpress/

sudo service apache2 restart

sudo apt install mariadb-server

sudo mariadb

source /tmp/dbinit.sql

exit






sudo wp core download --path=/var/www/html/wordpress --allow-root





