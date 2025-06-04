
#!/bin/bash
yum update -y
# installing mariaDB
yum install -y mariadb-server maraiadb
# start the mysql service
systemctl start mariadb
# enable the mysql service to start on boot
systemctl enable mariadb
# check the status of mysql service
systemctl status mariadb
# secure the mysql installation
mysql_secure_installation

# login with password
mysql -u root --password='re:St@rt!9'

# display the various databases
SHOW DATABASES;
#define the database if not exists
DROP DATABASE IF EXISTS world;
CREATE DATABASE world;
USE world;
SOURCE /home/ec2-user/world.sql;