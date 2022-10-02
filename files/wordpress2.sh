#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz

sudo mv wordpress/ /var/www/html




sudo mv /tmp/wp-config.php /var/www/html/wordpress/





