# Creating prerequisite components for Amazon RDS
# create security group to EC2 instance
aws ec2 create-security-group \
--group-name CafeDatabaseSG \
--description "Security group for Cafe database" \
--vpc-id vpc-03cda0a88c91ba19b
# {
#     "GroupId": "sg-0326cdd1e90c1516e"
# }


# create inbound rule to the security group(sg-0326cdd1e90c1516e)
aws ec2 authorize-security-group-ingress \
--group-id sg-0326cdd1e90c1516e \
--protocol tcp --port 3306 \
--source-group sg-0186cabb064df738c


# create a subnet for the availability zone us-east-2a
aws ec2 create-subnet \
--vpc-id vpc-03cda0a88c91ba19b \
--cidr-block 10.200.2.0/23 \
--availability-zone us-west-2a

# {
#     "Subnet": {
#         "MapPublicIpOnLaunch": false, 
#         "AvailabilityZoneId": "usw2-az2", 
#         "AvailableIpAddressCount": 507, 
#         "DefaultForAz": false, 
#         "SubnetArn": "arn:aws:ec2:us-west-2:814200003682:subnet/subnet-0945cf16421343449", 
#         "Ipv6CidrBlockAssociationSet": [], 
#         "VpcId": "vpc-03cda0a88c91ba19b", 
#         "MapCustomerOwnedIpOnLaunch": false, 
#         "AvailabilityZone": "us-west-2a", 
#         "SubnetId": "subnet-0945cf16421343449", 
#         "OwnerId": "814200003682", 
#         "CidrBlock": "10.200.2.0/23", 
#         "State": "available", 
#         "AssignIpv6AddressOnCreation": false
#     }
# }



aws ec2 create-subnet \
--vpc-id vpc-03cda0a88c91ba19b \
--cidr-block 10.200.10.0/23 \
--availability-zone us-west-2b
# {
#     "Subnet": {
#         "MapPublicIpOnLaunch": false, 
#         "AvailabilityZoneId": "usw2-az1", 
#         "AvailableIpAddressCount": 507, 
#         "DefaultForAz": false, 
#         "SubnetArn": "arn:aws:ec2:us-west-2:814200003682:subnet/subnet-0e53f55bfc404fb0a", 
#         "Ipv6CidrBlockAssociationSet": [], 
#         "VpcId": "vpc-03cda0a88c91ba19b", 
#         "MapCustomerOwnedIpOnLaunch": false, 
#         "AvailabilityZone": "us-west-2b", 
#         "SubnetId": "subnet-0e53f55bfc404fb0a", 
#         "OwnerId": "814200003682", 
#         "CidrBlock": "10.200.10.0/23", 
#         "State": "available", 
#         "AssignIpv6AddressOnCreation": false
#     }
# }


# create a DB subnet group
aws rds create-db-subnet-group \
--db-subnet-group-name "CafeDB Subnet Group" \
--db-subnet-group-description "DB subnet group for Cafe" \
--subnet-ids subnet-0945cf16421343449 subnet-0e53f55bfc404fb0a \
--tags "Key=Name,Value= CafeDatabaseSubnetGroup"
# {
#     "DBSubnetGroup": {
#         "Subnets": [
#             {
#                 "SubnetStatus": "Active", 
#                 "SubnetIdentifier": "subnet-0945cf16421343449", 
#                 "SubnetOutpost": {}, 
#                 "SubnetAvailabilityZone": {
#                     "Name": "us-west-2a"
#                 }
#             }, 
#             {
#                 "SubnetStatus": "Active", 
#                 "SubnetIdentifier": "subnet-0e53f55bfc404fb0a", 
#                 "SubnetOutpost": {}, 
#                 "SubnetAvailabilityZone": {
#                     "Name": "us-west-2b"
#                 }
#             }
#         ], 
#         "VpcId": "vpc-03cda0a88c91ba19b", 
#         "DBSubnetGroupDescription": "DB subnet group for Cafe", 
#         "SubnetGroupStatus": "Complete", 
#         "DBSubnetGroupArn": "arn:aws:rds:us-west-2:814200003682:subgrp:cafedb subnet group", 
#         "DBSubnetGroupName": "cafedb subnet group"
#     }
# }



# list available MariaDB versions
aws rds describe-db-engine-versions \
  --engine mariadb \
  --query 'DBEngineVersions[*].EngineVersion' \
  --output table

# configure settings for the RDS instance
aws rds create-db-instance \
--db-instance-identifier CafeDBInstance \
--engine mariadb \
--engine-version 10.6.13 \
--db-instance-class db.t3.micro \
--allocated-storage 20 \
--availability-zone us-west-2a \
--db-subnet-group-name "CafeDB Subnet Group" \
--vpc-security-group-ids sg-0186cabb064df738c \
--no-publicly-accessible \
--master-username root --master-user-password 'Re:Start!9'

# check the status of the RDS instance
aws rds describe-db-instances \
--db-instance-identifier CafeDBInstance \
--query "DBInstances[*].[Endpoint.Address,AvailabilityZone,PreferredBackupWindow,BackupRetentionPeriod,DBInstanceStatus]"
# [
#     [
#         null, 
#         "us-west-2a", 
#         "11:59-12:29", 
#         1, 
#         "creating"
#     ]
# ]
# [
#     [
#         "cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com", 
#         "us-west-2a", 
#         "11:59-12:29", 
#         1, 
#         "available"
#     ]
# ]


mysqldump --user=root --password='Re:Start!9' \
--databases cafe_db \
--add-drop-database > cafedb-backup.sql

mysqldump --user=root --password='Re:Start!9' \
  --host='cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com' \
  --databases cafe_db \
  --add-drop-database > cafedb-backup.sql

mysql --user=root --password='Re:Start!9' \
--host='cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com' \
cafe_db

mysql --u root --password='Re:Start!9' \
--host='cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com' \
cafe_db

