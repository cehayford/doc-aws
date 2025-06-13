ssh -i "C:\\<files-collected>\\labsuser.pem" <user-name>@<public-ip-address>

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



SHOW DATABASES;
#define the database if not exists
DROP DATABASE IF EXISTS studentsEntry;
CREATE DATABASE studentsEntry;
USE studentsEntry;
SOURCE /home/ec2-user/studentsEntry.sql;


CREATE TABLE RESTART (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Restart_City VARCHAR(50),
    Graduation_Date DATETIME
);

INSERT INTO RESTART (Student_ID, Student_Name, Restart_City, Graduation_Date) VALUES
(1001, 'John Smith', 'New York', '2024-05-15 10:00:00'),
(1002, 'Sarah Johnson', 'Los Angeles', '2024-06-20 14:30:00'),
(1003, 'Michael Brown', 'Chicago', '2024-07-10 09:15:00'),
(1004, 'Emily Davis', 'Houston', '2024-08-05 11:45:00'),
(1005, 'David Wilson', 'Phoenix', '2024-09-12 13:20:00'),
(1006, 'Lisa Anderson', 'Philadelphia', '2024-10-18 16:00:00'),
(1007, 'Robert Taylor', 'San Antonio', '2024-11-22 08:30:00'),
(1008, 'Jennifer Martinez', 'San Diego', '2024-12-03 12:10:00'),
(1009, 'William Garcia', 'Dallas', '2025-01-14 15:45:00'),
(1010, 'Jessica Rodriguez', 'San Jose', '2025-02-28 10:20:00');


SELECT * FROM RESTART;



CREATE TABLE CLOUD_PRACTITIONER (
    Student_ID INT,
    Certification_Date DATETIME,
    FOREIGN KEY (Student_ID) REFERENCES RESTART(Student_ID)
);

SELECT 
    r.Student_ID,
    r.Student_Name,
    cp.Certification_Date
FROM RESTART r
INNER JOIN CLOUD_PRACTITIONER cp ON r.Student_ID = cp.Student_ID;

SHOW TABLES;

# Display the structure of the RESTART table
DESCRIBE RESTART;
# Display the structure of the CLOUD_PRACTITIONER table
DESCRIBE CLOUD_PRACTITIONER;

SHOW TABLES;

# Display the structure of the RESTART table
DESCRIBE RESTART;
# Display the structure of the CLOUD_PRACTITIONER table
DESCRIBE CLOUD_PRACTITIONER;

QUIT;

