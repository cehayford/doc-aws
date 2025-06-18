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
mysql -u root --password='<your_password_here>'

# display the various databases
SHOW DATABASES;
#define the database if not exists
DROP DATABASE IF EXISTS world;
CREATE DATABASE world;
USE world;
SOURCE /home/ec2-user/world.sql;


SHOW DATABASES;

SELECT * FROM world.country;
SELECT Region, Name, Population FROM world.country WHERE Region = 'Australia and New Zealand' ORDER By Population desc;
SELECT Region, SUM(Population) FROM world.country WHERE Region = 'Australia and New Zealand' GROUP By Region ORDER By SUM(Population) desc;

# the output displays the population of a country along side a running total of the region
SELECT Region, Name, Population,
       (SELECT SUM(c2.Population) 
        FROM world.country c2 
        WHERE c2.Region = c1.Region 
        AND c2.Population <= c1.Population) AS RunningTotal
FROM world.country c1
WHERE Region = 'Australia and New Zealand'
ORDER BY Population;

# the RANK() function is useful when dealing with large groups of records
SELECT Region, Name, Population,
       (SELECT SUM(c2.Population) 
        FROM world.country c2 
        WHERE c2.Region = c1.Region 
        AND c2.Population <= c1.Population) AS `Running Total`,
       (SELECT COUNT(*) 
        FROM world.country c3 
        WHERE c3.Region = c1.Region 
        AND c3.Population > c1.Population) + 1 AS `Ranked`
FROM world.country c1
WHERE Region = 'Australia and New Zealand'
ORDER BY Population;



