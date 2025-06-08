aws configure

# creating a backup in elastic beanstalk
cd ~/sysops-activity-files/starters
cp create-lamp-instance-v2.sh create-lamp-instance.backup

# open the ssh file in view mode
view create-lamp-instance-v2.sh

cat create-lamp-instance-userdata-v2.txt

./create-lamp-instance-v2.sh

# troubleshooting to solve first issue
aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=amzn2-ami-hvm-*" \
              "Name=state,Values=available" \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text
    # output: ami-0c55b159cbfafe1f0

# fix the image id in the script
aws ec2 run-instances --image-id ami-06afbc42f893119e9 --instance-type t3.small \
    --key-name vockey \
    --security-group-ids sg-0457c6128335e3683 \
    --subnet-id subnet-02cb0007cca00d912 \
    --user-data ./create-lamp-instance-v2.sh

# make the changes from the script permanent
view create-lamp-instance-v2.sh
# to quit view, press the ESC key
# and then type :wq! and press Enter


# to fix the second issue:
# go to the instance in the EC2 console, 
# select the newly created instance,
# check the security group settings
# and add the following inbound rule:
# Type: HTTP
# Protocol: TCP
# Port Range: 80
# then run the ip address command to get the public IP address of the instance
# and open it in a web browser to see the default Apache page


sudo yum install -y nmap
nmap -Pn <provided-public-ip>
# log the output of the script
sudo tail -f /var/log/cloud-init-output.log