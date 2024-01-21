#!/bin/sh

apt-get update
apt-get install -y unzip nginx php php-fpm php-mysql
cd /srv/www
wget https://builds.matomo.org/matomo.zip && unzip matomo.zip
rm -rf html
mv matomo html
chown -R www-data:www-data .
cat > /etc/nginx/sites-enabled/default << EOF
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
            try_files \$uri \$uri/ =404;
        }
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        }
    }
EOF
nginx -t && systemctl reload nginx