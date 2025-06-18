# Get region
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFAULT_REGION=${AZ::-1}


# List information about EC2 instances
aws ec2 describe-instances
aws ec2 dwscribe-instance-types
aws ec2 describe-instance-status