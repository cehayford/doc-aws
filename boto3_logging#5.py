import boto3
import logging

# Set up logging
logging.basicConfig(level=logging.DEBUG)

# Initialize the boto3 S3 resource
s3 = boto3.resource('s3')

# Apply the AWS debug logging filter
boto3.set_stream_logger('boto3', logging.DEBUG)

# Create a new bucket as the initial setup is empty
s3.create_bucket(Bucket='my-logging-test-bucket')

# List buckets to show logging output
for bucket in s3.buckets.all():
    print(bucket.name)





# import boto3
# import logging

# # Hint: Configure logging using Python’s logging module and boto3.set_stream_logger() for S3 at DEBUG level
# logging.basicConfig(level=logging.DEBUG)
# s3 = boto3.client('s3')
# boto3.set_stream_logger(name='botocore.client.s3', level=logging.DEBUG)

# # Attempt an S3 operation to generate and capture detailed logs
# try:
#     s3.list_buckets()
# except Exception as e:
#     # Use logging to report errors
#     logging.error("An error occurred: ", exc_info=e)