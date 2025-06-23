# recall bucket names
aws s3 ls

# recall bucket names with region
aws s3 ls --region <region>

# extract logs that are zipped
gunzip *.gz

# read the json file format
cat <filename.json> | python -m json.tool

# structure command that returns the 'sourceIPAddress'
for i in $(ls); do echo $i && cat $i | python -m json.tool | grep sourceIPAddress ; done

# structure command that returns the 'eventName'
for i in $(ls); do echo $i && cat $i | python -m json.tool | grep eventName ; done

# console login events
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=ConsoleLogin


# console login events with region
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=Console


# SELECT DISTINCT useridentity.userName, eventName, eventSource FROM cloudtrail_logs_monitoring5313 
# WHERE from_iso8601_timestamp(eventtime) > date_add('day', -1, now()) ORDER BY eventSource;

# find out the logged operating system
sudo aureport --auth

# find out the logged user
who

# remove the logged user
# Note: This command will delete the user and their home directory, so use with caution.
# Make sure to replace <logged_user> with the actual username you want to delete.
sudo userdel -r <logged_user>

sudo kill -9 ProcNum

# find out the logged user
who

# verify the user is removed
sudo cat /etc/passwd | grep -v <logged_user>



# Update the SSH configuration instance
sudo ls -l /etc/ssh/sshd_config
sudo vi /etc/ssh/sshd_config

