aws ec2 create-security-group \
--group-name CafeDatabaseSG \
--description "Security group for Cafe database" \
--vpc-id vpc-0094184b26f51c0e2
# {
#     "GroupId": "sg-0cbd462b5602fc177"
# }

aws ec2 authorize-security-group-ingress \
--group-id sg-0cbd462b5602fc177 \
--protocol tcp --port 3306 \
--source-group sg-0e70babd3be611f56


# Display the security group rules
aws ec2 describe-security-groups \
--query "SecurityGroups[*].[GroupName,GroupId,IpPermissions]" \
--filters "Name=group-name,Values='CafeDatabaseSG'"
# [
#     [
#         "CafeDatabaseSG", 
#         "sg-0cbd462b5602fc177", 
#         [
#             {
#                 "PrefixListIds": [], 
#                 "FromPort": 3306, 
#                 "IpRanges": [], 
#                 "ToPort": 3306, 
#                 "IpProtocol": "tcp", 
#                 "UserIdGroupPairs": [
#                     {
#                         "UserId": "814200003682", 
#                         "GroupId": "sg-0e70babd3be611f56"
#                     }
#                 ], 
#                 "Ipv6Ranges": []
#             }
#         ]
#     ]
# ]



aws ec2 create-subnet \
--vpc-id vpc-0094184b26f51c0e2 \
--cidr-block 10.200.2.0/23 \
--availability-zone us-west-2a
# {
#     "Subnet": {
#         "MapPublicIpOnLaunch": false, 
#         "AvailabilityZoneId": "usw2-az2", 
#         "AvailableIpAddressCount": 507, 
#         "DefaultForAz": false, 
#         "SubnetArn": "arn:aws:ec2:us-west-2:814200003682:subnet/subnet-0fce0d6ff675a79ac", 
#         "Ipv6CidrBlockAssociationSet": [], 
#         "VpcId": "vpc-0094184b26f51c0e2", 
#         "MapCustomerOwnedIpOnLaunch": false, 
#         "AvailabilityZone": "us-west-2a", 
#         "SubnetId": "subnet-0fce0d6ff675a79ac", 
#         "OwnerId": "814200003682", 
#         "CidrBlock": "10.200.2.0/23", 
#         "State": "available", 
#         "AssignIpv6AddressOnCreation": false
#     }
# }



aws ec2 create-subnet \
--vpc-id vpc-0094184b26f51c0e2 \
--cidr-block 10.200.10.0/23 \
--availability-zone us-west-2b
# {
#     "Subnet": {
#         "MapPublicIpOnLaunch": false, 
#         "AvailabilityZoneId": "usw2-az1", 
#         "AvailableIpAddressCount": 507, 
#         "DefaultForAz": false, 
#         "SubnetArn": "arn:aws:ec2:us-west-2:814200003682:subnet/subnet-003ce5ea9accaefce", 
#         "Ipv6CidrBlockAssociationSet": [], 
#         "VpcId": "vpc-0094184b26f51c0e2", 
#         "MapCustomerOwnedIpOnLaunch": false, 
#         "AvailabilityZone": "us-west-2b", 
#         "SubnetId": "subnet-003ce5ea9accaefce", 
#         "OwnerId": "814200003682", 
#         "CidrBlock": "10.200.10.0/23", 
#         "State": "available", 
#         "AssignIpv6AddressOnCreation": false
#     }
# }



aws rds create-db-subnet-group \
--db-subnet-group-name "CafeDB Subnet Group" \
--db-subnet-group-description "DB subnet group for Cafe" \
--subnet-ids "subnet-0fce0d6ff675a79ac" "subnet-003ce5ea9accaefce" \
--tags "Key=Name,Value= CafeDatabaseSubnetGroup"
# {
#     "DBSubnetGroup": {
#         "Subnets": [
#             {
#                 "SubnetStatus": "Active", 
#                 "SubnetIdentifier": "subnet-0fce0d6ff675a79ac", 
#                 "SubnetOutpost": {}, 
#                 "SubnetAvailabilityZone": {
#                     "Name": "us-west-2a"
#                 }
#             }, 
#             {
#                 "SubnetStatus": "Active", 
#                 "SubnetIdentifier": "subnet-003ce5ea9accaefce", 
#                 "SubnetOutpost": {}, 
#                 "SubnetAvailabilityZone": {
#                     "Name": "us-west-2b"
#                 }
#             }
#         ], 
#         "VpcId": "vpc-0094184b26f51c0e2", 
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



aws rds create-db-instance \
--db-instance-identifier CafeDBInstance \
--engine mariadb \
--engine-version 10.5.20 \
--db-instance-class db.t3.micro \
--allocated-storage 20 \
--availability-zone us-west-2a \
--db-subnet-group-name "CafeDB Subnet Group" \
--vpc-security-group-ids sg-0cbd462b5602fc177 \
--no-publicly-accessible \
--master-username root --master-user-password 'Re:Start!9'
# --engine-version 10.5.13 \ {the initial version used in the re/start lab}
# {
#     "DBInstance": {
#         "PubliclyAccessible": false, 
#         "MasterUsername": "root", 
#         "MonitoringInterval": 0, 
#         "LicenseModel": "general-public-license", 
#         "VpcSecurityGroups": [
#             {
#                 "Status": "active", 
#                 "VpcSecurityGroupId": "sg-0cbd462b5602fc177"
#             }
#         ], 
#         "CopyTagsToSnapshot": false, 
#         "OptionGroupMemberships": [
#             {
#                 "Status": "in-sync", 
#                 "OptionGroupName": "default:mariadb-10-5"
#             }
#         ], 
#         "PendingModifiedValues": {
#             "MasterUserPassword": "****"
#         }, 
#         "Engine": "mariadb", 
#         "MultiAZ": false, 
#         "DBSecurityGroups": [], 
#         "DBParameterGroups": [
#             {
#                 "DBParameterGroupName": "default.mariadb10.5", 
#                 "ParameterApplyStatus": "in-sync"
#             }
#         ], 
#         "PerformanceInsightsEnabled": false, 
#         "AutoMinorVersionUpgrade": true, 
#         "PreferredBackupWindow": "09:09-09:39", 
#         "DBSubnetGroup": {
#             "Subnets": [
#                 {
#                     "SubnetStatus": "Active", 
#                     "SubnetIdentifier": "subnet-0fce0d6ff675a79ac", 
#                     "SubnetOutpost": {}, 
#                     "SubnetAvailabilityZone": {
#                         "Name": "us-west-2a"
#                     }
#                 }, 
#                 {
#                     "SubnetStatus": "Active", 
#                     "SubnetIdentifier": "subnet-003ce5ea9accaefce", 
#                     "SubnetOutpost": {}, 
#                     "SubnetAvailabilityZone": {
#                         "Name": "us-west-2b"
#                     }
#                 }
#             ], 
#             "DBSubnetGroupName": "cafedb subnet group", 
#             "VpcId": "vpc-0094184b26f51c0e2", 
#             "DBSubnetGroupDescription": "DB subnet group for Cafe", 
#             "SubnetGroupStatus": "Complete"
#         }, 
#         "ReadReplicaDBInstanceIdentifiers": [], 
#         "AllocatedStorage": 20, 
#         "DBInstanceArn": "arn:aws:rds:us-west-2:814200003682:db:cafedbinstance", 
#         "BackupRetentionPeriod": 1, 
#         "PreferredMaintenanceWindow": "wed:12:50-wed:13:20", 
#         "DBInstanceStatus": "creating", 
#         "IAMDatabaseAuthenticationEnabled": false, 
#         "EngineVersion": "10.5.20", 
#         "DeletionProtection": false, 
#         "AvailabilityZone": "us-west-2a", 
#         "DomainMemberships": [], 
#         "StorageType": "gp2", 
#         "DbiResourceId": "db-VBLHK4HVZIEIDVGVEFIV5K6LZY", 
#         "CACertificateIdentifier": "rds-ca-rsa2048-g1", 
#         "StorageEncrypted": false, 
#         "AssociatedRoles": [], 
#         "DBInstanceClass": "db.t3.micro", 
#         "DbInstancePort": 0, 
#         "DBInstanceIdentifier": "cafedbinstance"
#     }
# }


# check the status of the database
aws rds describe-db-instances \
--db-instance-identifier CafeDBInstance \
--query "DBInstances[*].[Endpoint.Address,AvailabilityZone,PreferredBackupWindow,BackupRetentionPeriod,DBInstanceStatus]"
# [
#     [
#         "cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com", 
#         "us-west-2a", 
#         "09:09-09:39", 
#         1, 
#         "available"
#     ]
# ]

