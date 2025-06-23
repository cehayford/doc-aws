aws configure

sudo systemctl stop maraidb
# if the service is not running, you can start it with:
sudo systemctl start mariadb

# or install mariadb if it is not installed:
# do this to check whether mariadb is run smoothly:
sudo yum install -y mariadb-server maraiadb
# start the mysql service
systemctl start mariadb
# enable the mysql service to start on boot
systemctl enable mariadb
# check the status of mysql service
systemctl status mariadb

# remove the mariadb service
sudo yum -y remove mariadb-server

# creating EC2 instance
aws ec2 describe-instances \
--filters "Name=tag:Name,Values= CafeInstance" \
--query "Reservations[*].Instances[*].InstanceId"
[
    [
        "i-0ce32cb5b02c733dd"
    ]
]

# stop the EC2 instance
aws ec2 stop-instances --instance-ids "i-0ce32cb5b02c733dd"
# [
#     [
#         "i-0ce32cb5b02c733dd"
#     ]
# ]
# [ec2-user@cli-host ~]$ aws ec2 stop-instances --instance-ids "i-0ce32cb5b02c733dd"
# {
#     "StoppingInstances": [
#         {
#             "InstanceId": "i-0ce32cb5b02c733dd", 
#             "CurrentState": {
#                 "Code": 64, 
#                 "Name": "stopping"
#             }, 
#             "PreviousState": {
#                 "Code": 16, 
#                 "Name": "running"
#             }
#         }
#     ]
# }

# Change the instance type to t3.micro. In the SSH window for the CLI Host instance:
# aws ec2 modify-instance-attribute \
# --instance-id <instance-id> \
# --instance-type "{\"Value\": \"t3.micro\"}"
aws ec2 modify-instance-attribute \
--instance-id "i-0ce32cb5b02c733dd" \
--instance-type "{\"Value\": \"t3.micro\"}"


# start the EC2 instance with instance id
aws ec2 start-instances --instance-ids "i-0ce32cb5b02c733dd"
# {
#     "StartingInstances": [
#         {
#             "InstanceId": "i-0ce32cb5b02c733dd", 
#             "CurrentState": {
#                 "Code": 0, 
#                 "Name": "pending"
#             }, 
#             "PreviousState": {
#                 "Code": 80, 
#                 "Name": "stopped"
#             }
#         }
#     ]
# }

# check the status of the EC2 instance is running
aws ec2 describe-instances \
--instance-ids "i-0ce32cb5b02c733dd" \
--query "Reservations[*].Instances[*].[InstanceType,PublicDnsName,PublicIpAddress,State.Name]"
# [
#     [
#         [
#             "t3.micro", 
#             "ec2-44-243-118-99.us-west-2.compute.amazonaws.com", 
#             "44.243.118.99", 
#             "running"
#         ]
#     ]
# ]
# Downsized CafeInstance Public DNS Name: ec2-zzz-zzz-zzz-zzz.eu-west-2.compute.amazonaws.com
# Downsized CafeInstance Public IP Address: nnn.nnn.nnn.nnn


# Access the CafeInstance web application using the Public DNS Name:
# http://<Downsized CafeInstance Public DNS Name>/cafe
http://44.243.118.99/cafe

# Access the AWS Cost Calculator to estimate costs:
https://calculator.aws