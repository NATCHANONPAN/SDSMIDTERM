#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo wp core download --path=/var/www/html --allow-root


cd /var/www/html
sudo rm index.html

sudo apt install mysql-server -y

sleep 20

sudo wp config create --dbname=${db_name} --dbuser=${db_user} --dbpass=${db_pass} --dbhost=${db_host} --allow-root --extra-php << PHP
define( 'AS3CF_SETTINGS', serialize( array(
    'provider' => 'aws',
   
    'access-key-id' => '${iam_user_access_key}',
    
    'secret-access-key' => '${iam_user_secret}',

    'bucket' => '${bucket_name}',
   
    'region' => '${region}',
    
    'copy-to-s3' => true,
    'serve-from-s3' => true,
    'remove-local-file' => true,

    
    
) ) );


PHP

sudo wp core install --path=/var/www/html/  --admin_user=${admin_user} --admin_password=${admin_pass} --admin_email=test@gmail.com --skip-email --title='test' --allow-root --url=${public_ip}

sudo wp plugin install https://downloads.wordpress.org/plugin/amazon-s3-and-cloudfront.3.0.0.zip --path=/var/www/html --allow-root --activate

sudo chown -R www-data /var/www/html/wp-content/uploads


sudo apt install php-xml -y
sudo apt install php-curl -y
sudo apt install php-gd -y


sudo service apache2 restart






