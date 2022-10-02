#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo wp core download --path=/var/www/html --allow-root

sudo mv /tmp/wp-config.php /var/www/html/
cd /var/www/html
sudo rm index.html

sudo wp core install --path=/var/www/html/  --admin_user=${admin_user} --admin_password=${admin_pass} --admin_email=test@gmail.com --skip-email --title='test' --allow-root --url=${public_ip}





