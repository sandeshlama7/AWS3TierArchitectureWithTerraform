#!/bin/bash
# Update all packages
yum update -y
dnf update -y

#Install Apache
yum install httpd -y
#Start and enable Apache
systemctl start httpd
systemctl enable httpd
#Install php and its extensions
yum install -y php php-mysqlnd php-bcmath php-ctype php-fileinfo php-json php-openssl php-gd php-tokenizer

#  echo "<center><h1>Hello TEST</h1></center>" > /var/www/html/index.html
# systemctl restart httpd
yum install git -y

cd ~/   #Change to Home Directory

git clone https://github.com/sandeshlama7/LAMP-EmployeeApp.git
sed -i "s/DB_SERVER/'${RDS_ENDPOINT}'/g" LAMP-EmployeeApp/index.php

mv LAMP-EmployeeApp/* /var/www/html/

#Install Mysql Client
wget https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
dnf -y install mysql84-community-release-el9-1.noarch.rpm
dnf -y install mysql-community-server
systemctl restart httpd

#Create a database inside the RDS
# mysql -h$HOST -u$USER -p$PASS -e "CREATE DATABASE Employees";
