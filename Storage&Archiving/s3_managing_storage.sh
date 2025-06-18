aws ec2 describe-instances --filter 'Name=tag:Name,Values=Processor' --query 'Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.{VolumeId:VolumeId}'
# {
#     "VolumeId": "vol-0f8b6d8d1815d8157"
# }


aws ec2 describe-instances --filters 'Name=tag:Name,Values=Processor' --query 'Reservations[0].Instances[0].InstanceId'
# "i-0b977c72590c9c839"


aws ec2 stop-instances --instance-ids i-0b977c72590c9c839
# {
#     "StoppingInstances": [
#         {
#             "InstanceId": "i-0b977c72590c9c839",
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


# Wait for the instance to stop
aws ec2 wait instance-stopped --instance-id i-0b977c72590c9c839


# Create a snapshot of the volume
aws ec2 create-snapshot --volume-id vol-0f8b6d8d1815d8157
# {
#     "Tags": [],
#     "SnapshotId": "snap-0aefab2232e80338f",
#     "VolumeId": "vol-0f8b6d8d1815d8157",
#     "State": "pending",
#     "StartTime": "2025-06-15T03:31:46.333Z",
#     "Progress": "",
#     "OwnerId": "962663771834",
#     "Description": "",
#     "VolumeSize": 8,
#     "Encrypted": false
# }


# check the status of the snapshot
aws ec2 wait snapshot-completed --snapshot-id snap-0aefab2232e80338f

# Start the instance again
aws ec2 start-instances --instance-ids i-0b977c72590c9c839
# {
#     "StartingInstances": [
#         {
#             "InstanceId": "i-0b977c72590c9c839",
#             "CurrentState": {
#                 "Code": 0,
#                 "Name": "pending"
#             },
#             "PreviousState": {
#                 "Code": 80,
#                 # "Name": "stopped"
#                 "Name": "running"
#             }
#         }
#     ]
# }


# Create a cron job to automate the snapshot creation every minute
echo "* * * * *  aws ec2 create-snapshot --volume-id vol-0f8b6d8d1815d8157 2>&1 >> /tmp/cronlog" > cronjob
crontab cronjob


# filter the snapshots by volume ID
aws ec2 describe-snapshots --filters "Name=volume-id,Values=VOLUME-ID"


crontab -r
more /home/ec2-user/snapshotter_v2.py


# List all snapshots for a specific volume
aws ec2 describe-snapshots --filters "Name=volume-id, Values=VOLUME-ID" --query 'Snapshots[*].SnapshotId'


# # Create a Python script to automate the snapshot creation
python3.8 snapshotter_v2.py
aws ec2 describe-snapshots --filters "Name=volume-id, Values=VOLUME-ID" --query 'Snapshots[*].SnapshotId'


wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RSJAWS-3-124627/183-lab-JAWS-managing-storage/s3/files.zip

unzip files.zip
ls -la files/

aws s3api put-bucket-versioning \
    --bucket your-bucket-name \
    --versioning-configuration Status=Enabled



aws s3 sync files/ s3://s3-storage-asy/

aws s3 ls s3://s3-storage-asy/ --recursive

aws s3 sync files/ s3://s3-storage-asy/ --delete


rm files/file1.txt

aws s3 sync files/ s3://s3-storage-asy/ --delete


# List all versions of objects in the bucket
aws s3api list-object-versions --bucket your-bucket-name
# {
#     "Versions": [
#         {
#             "ETag": "\"b76b2b775023e60be16bc332496f8409\"",
#             "ChecksumAlgorithm": [
#                 "CRC32"
#             ],
#             "ChecksumType": "FULL_OBJECT",
#             "Size": 30318,
#             "StorageClass": "STANDARD",
#             "Key": "file1.txt",
#             "VersionId": "gRKgzaHVIeqJXLrkqqcpmcYNjyrzAmyk",
#             "IsLatest": false,
#             "LastModified": "2025-06-15T04:01:32.000Z",
#             "Owner": {
#                 "DisplayName": "awslabsc0w4692382t1666711049",
#                 "ID": "f3afa506af30c3f1fb3f03f5a91565b8c5934bd8870244d205fbbee47208dbb2"
#             }
#         },
#         {
#             "ETag": "\"3265fc3a6cf0337a5684731be0076dc2\"",
#             "ChecksumAlgorithm": [
#                 "CRC32"
#             ],
#             "ChecksumType": "FULL_OBJECT",
#             "Size": 43784,
#             "StorageClass": "STANDARD",
#             "Key": "file2.txt",
#             "VersionId": "WeXnVJALSb2IvzmoFB9i.4FI_mYkTycL",
#             "IsLatest": true,
#             "LastModified": "2025-06-15T04:01:32.000Z",
#             "Owner": {
#                 "DisplayName": "awslabsc0w4692382t1666711049",
#                 "ID": "f3afa506af30c3f1fb3f03f5a91565b8c5934bd8870244d205fbbee47208dbb2"
#             }
#         },
#         {
#             "ETag": "\"f491957bee64c931c32fc1d39ffc709f\"",
#             "ChecksumAlgorithm": [
#                 "CRC32"
#             ],
#             "ChecksumType": "FULL_OBJECT",
#             "Size": 96675,
#             "StorageClass": "STANDARD",
#             "Key": "file3.txt",
#             "VersionId": "WV39I13mKawbTwrdRUAgLL3ztoaiV0Jb",
#             "IsLatest": true,
#             "LastModified": "2025-06-15T04:01:32.000Z",
#             "Owner": {
#                 "DisplayName": "awslabsc0w4692382t1666711049",
#                 "ID": "f3afa506af30c3f1fb3f03f5a91565b8c5934bd8870244d205fbbee47208dbb2"
#             }
#         }
#     ],
#     "DeleteMarkers": [
#         {
#             "Owner": {
#                 "DisplayName": "awslabsc0w4692382t1666711049",
#                 "ID": "f3afa506af30c3f1fb3f03f5a91565b8c5934bd8870244d205fbbee47208dbb2"
#             },
#             "Key": "file1.txt",
#             "VersionId": "eTQs3su9F8g6tzF_9xBLQj.Y1w60ffey",
#             "IsLatest": true,
#             "LastModified": "2025-06-15T04:16:13.000Z"
#         }
#     ],
#     "RequestCharged": null,
#     "Prefix": ""
# }



aws s3api list-object-versions \
    --bucket s3-storage-asy \
    --prefix files/file1.txt


# activate versioning on the bucket
aws s3api put-bucket-versioning --bucket s3-storage-asy --versioning-configuration Status=Enabled

aws s3 sync files s3://s3-storage-asy/files/

aws s3 ls s3://s3-storage-asy/files/

aws s3api list-object-versions --bucket s3-storage-asy --prefix files/file1.txt
aws s3api get-object --bucket S3-BUCKET-NAME --key files/file1.txt --version-id VERSION-ID files/file1.txt