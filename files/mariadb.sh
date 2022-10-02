#!/bin/bash

sudo apt-get update
sudo apt install mariadb-server -y

sudo mysql <<EOF
FLUSH PRIVILEGES;
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'username'@'localhost';

EOF

sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
sudo ufw allow 3306/tcp
sudo service mysql restart



