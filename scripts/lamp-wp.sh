#!/bin/bash
# Install LAMP and Wordpress on CentOS 7
#

## Install LAMP

# Disable SELinux & Open ports: 80, 443 

check_fw=`rpm -qa | grep firewalld`
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
if [ -n "$check_fw" ]
then
  firewall-cmd --add-port=80/tcp --permanent
  firewall-cmd --add-port=443/tcp --permanent
  firewall-cmd --reload
fi

# Install LAMP

yum clean all
# yum -y update
yum -y install httpd


## Enable mod_rewrite
sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

## Disable Apache Web Server Signature

echo -e "ServerSignature Off
ServerTokens Prod" >> /etc/httpd/conf/httpd.conf

systemctl start httpd && systemctl enable httpd

## Install PHP

sudo yum -y install php php-mysql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl wget unzip

## Hide version PHP

sed -i 's/expose_php = On/expose_php = Off/g' /etc/php.ini 
sed -i 's/;date.timezone =/date.timezone = Asia\/Ho_Chi_Minh/g' /etc/php.ini
sed -i 's/index.html/index.html index.php/g' /etc/httpd/conf/httpd.conf

systemctl restart httpd

## Install MariaDB

yum install mariadb-server mariadb -y

systemctl enable mariadb && systemctl start mariadb

cd /opt/
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -avr wordpress/* /var/www/html/
chmod 755 /var/www/html/
chown apache. -R /var/www/html/

