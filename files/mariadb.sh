#!/bin/bash

sudo apt-get update
sudo apt install mariadb-server -y

sudo mysql <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE ${db_name};
CREATE USER '${db_user}'@'%' IDENTIFIED BY '${db_pass}';
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%' WITH GRANT OPTION;

CREATE USER '${db_user}'@'loclahost' IDENTIFIED BY '${db_pass}';
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';


EOF

sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
sudo ufw allow 3306/tcp
sudo service mysql restart



