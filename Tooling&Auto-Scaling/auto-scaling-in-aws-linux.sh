curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep region

aws configure
cd /home/ec2-user/
more UserData.txt

find -wholename /root/.*history -wholename /home/*/.*history -exec rm -f {} \;
find / -name 'authorized_keys' -exec rm -f {} \;
rm -rf /var/lib/cloud/data/scripts/*

# AMIID	ami-06afbc42f893119e9
# HTTPACCESS	sg-0346b921172e97c51
# COMMANDHOSTIP	35.89.80.19
# KEYNAME	vockey
# SUBNETID	subnet-00b8b3133eb72fa27
aws ec2 run-instances --key-name vockey --instance-type t3.micro --image-id ami-06afbc42f893119e9 --user-data file:///home/ec2-user/UserData.txt --security-group-ids sg-0346b921172e97c51 --subnet-id subnet-00b8b3133eb72fa27 --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WebServer}]' --output text --query 'Instances[*].InstanceId'
# instance id: i-081d2bd59fcd12594
aws ec2 wait instance-running --instance-ids i-081d2bd59fcd12594

aws ec2 describe-instances --instance-id i-081d2bd59fcd12594 --query 'Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicDnsName'
# new instance public DNS name: ec2-54-149-233-110.us-west-2.compute.amazonaws.com

# http://ec2-54-149-233-110.us-west-2.compute.amazonaws.com/index.php

# creating a custom AAMI
aws ec2 create-image --name WebServerAMI --instance-id i-081d2bd59fcd12594
# new AMI ID: ami-0dc51702d4de9e0ba
