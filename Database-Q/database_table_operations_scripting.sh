
# Update all the package using below command and then try installing MySql:
sudo yum update -y
sudo yum install mysql -y


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

# login to mysql
mysql -u root #--password='re:St@rt!9'
# or with password
# Uncomment the line below to use a password
mysql -u root --password='re:St@rt!9'


