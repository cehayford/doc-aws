sudo su -l ec2-user
pwd

aws configure
# Enter your AWS Access Key ID, Secret Access Key, region, and output format when prompted.
# Example:
# AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
# AWS Secret   Access Key [None]: YOUR_SECRET_ACCESS_KEY
# Default region name [None]: us-west-2 
# Default output format [None]: json

# create a new s3 bucket
aws s3api create-bucket --bucket <bucket-name-entry> --region <region-name> --create-bucket-configuration LocationConstraint=<region-name>
# Example:
# aws s3api create-bucket --bucket my-new-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
# {
#   "Location": "http://freewillhayford1357.s3.amazonaws.com/"
# }

aws iam create-user --user-name awsS3user
aws iam create-login-profile --user-name awsS3user --password Training123!

# AWS managed policy that grants full access to Amazon S3
aws iam list-policies --query "Policies[?contains(PolicyName,'S3')]"


# To grant the awsS3user user full access to the S3 bucket
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/<policyYouFound> --user-name awsS3user
# Example:
# aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --user-name awsS3user


aws s3 website s3://freewillhayford1357/ --index-document index.html

# upload the files to the bucket
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ s3://<my-bucket>/ --recursive --acl public-read
# Example:
# aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ s3://freewillhayford1357/ --recursive --acl public-read

aws s3 ls <my-bucket>
# Example:
# aws s3 ls freewillhayford1357


#!/bin/bash
 aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ s3://<my-bucket>/ --recursive --acl public-read


# https://freewillhayford1357.s3.us-west-2.amazonaws.com/index.html