#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php -y

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz


sudo mv wordpress/ /var/www/html

sudo service apache2 restart


