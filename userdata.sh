#!/bin/bash
apt-get update
apt-get install apache2 -y
cp /home/ubuntu/upload/index.html /var/www/html
cp /home/ubuntu/upload/image.png /var/www/html
#chmod 777 /var/www/html/index.html
chmod 644 /var/www/html/index.html
systemctl enable apache2
systemctl start apache2
