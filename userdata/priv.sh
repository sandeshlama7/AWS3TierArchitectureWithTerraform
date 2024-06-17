#!/bin/bash
apt-get install -y apache2
systemctl start apache2
apt-get install -y php php-mysql git mysql-client

cd ~
git clone https://github.com/sandeshlama7/LAMP-EmployeeApp.git
sed -i "s/DB_SERVER/'${RDS_ENDPOINT}'/g" LAMP-EmployeeApp/index.php
mv LAMP-EmployeeApp/* /var/www/html/

echo "DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm" | sudo tee /etc/apache2/mods-enabled/dir.conf

sed -i "s/80/8080/g" /etc/apache2/sites-available/000-default.conf

sed -i "s/80/8080/g"  /etc/apache2/ports.conf

systemctl restart apache2
