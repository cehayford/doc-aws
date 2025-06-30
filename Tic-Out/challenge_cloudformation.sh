# AWS re/Start Challenge Lab - Using AWS CloudFormation to 
# create an AWS VPC and Amazon EC2 instance


# upload the yaml file to cloudformation
# check the file upload.yaml in the current directory
# Re-QQQ
# Re-QQQ
# Re-QQQ
# Re-QQQ
# Re-QQQ

# return the account number and your user ID:
aws sts get-caller-identity

# checking for the instance description
aws ec2 describe-instances


# return the all information about the ec2 instance
# use the py command to check the instance
$ python3
>>> import boto3
>>> ec2 = boto3.client('ec2', region_name='us-west-2')  
>>> ec2.describe_regions()
>>> exit()
