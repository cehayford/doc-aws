aws s3api create-bucket --bucket flowlog864212 --region 'us-west-2' --create-bucket-configuration LocationConstraint='us-west-2'
# {
#     "Location": "http://flowlog864212.s3.amazonaws.com/"
# }


aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,Tags[?Key==`Name`].Value,CidrBlock]' --filters "Name=tag:Name,Values='VPC1'"
# [
#     [
#         "vpc-0008c8f71087e13a4",
#         [
#             "VPC1"
#         ],
#         "10.0.0.0/16",
#         "
#     ]
# ]



aws ec2 create-flow-logs --resource-type VPC --resource-ids vpc-0008c8f71087e13a4 --traffic-type ALL --log-destination-type s3 --log-destination arn:aws:s3:::flowlog864212


aws ec2 describe-instances --filter "Name=ip-address,Values='<WebServerIP>'"


aws ec2 describe-instances --filter "Name=ip-address,Values='52.89.124.105'" --query 'Reservations[*].Instances[*].[State,PrivateIpAddress,InstanceId,SecurityGroups,SubnetId,KeyName]'

# download the flow logs from S3
aws s3 cp s3://<flowlog######>/ . --recursive


cd cd <AWSLogs/AccountID/vpcflowlogs/us-west-2/yyyy/mm/dd/>

head -n 10 <flowlogfile.log>
grep -rn REJECT . | wc -l
grep -rn 22 . | grep REJECT


154.161.30.99/32

grep -rn 22 . | grep REJECT | grep 154.161.30.99/32

aws ec2 describe-network-interfaces --filters "Name=association.public-ip,Values='52.89.124.105'" --query 'NetworkInterfaces[*].[NetworkInterfaceId,Association.PublicIp]'
# [
#     [
#         "eni-04d0babf7c7ff3b33", 
#         "52.89.124.105"
#     ]
# ]


date -d @1554496931
date

