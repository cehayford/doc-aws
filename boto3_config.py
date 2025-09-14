import boto3
import logging
from botocore.exceptions import BotoCoreError, ClientError

# Set up logging to capture DEBUG information for S3 client interactions
logging.basicConfig(level=logging.DEBUG)
boto3.set_stream_logger('boto3', logging.DEBUG)

def create_bucket_and_list(s3_resource, bucket_name):
    """Create a bucket and list all buckets, with error handling."""
    try:
        # Create a new bucket
        s3_resource.create_bucket(Bucket=bucket_name)
        logging.info(f"Bucket '{bucket_name}' created successfully.")
    except ClientError as e:
        if e.response['Error']['Code'] == 'BucketAlreadyOwnedByYou':
            logging.info(f"Bucket '{bucket_name}' already exists and is owned by you.")
        else:
            logging.error("Failed to create bucket.", exc_info=e)
    except Exception as e:
        logging.error("Unexpected error during bucket creation.", exc_info=e)

    # List buckets to show logging output
    try:
        for bucket in s3_resource.buckets.all():
            print(bucket.name)
    except Exception as e:
        logging.error("Error listing buckets.", exc_info=e)

def list_objects_with_error_handling(s3_client, bucket_name):
    """Try to list objects in a bucket, handling common errors."""
    try:
        response = s3_client.list_objects(Bucket=bucket_name)
        if 'Contents' in response:
            for obj in response['Contents']:
                print(obj['Key'])
        else:
            print(f"No objects found in bucket '{bucket_name}'.")
    except ClientError as e:
        code = e.response['Error']['Code']
        if code == 'NoSuchBucket':
            print("The bucket does not exist.")
        elif code == 'AccessDenied':
            print("You do not have permissions to access the bucket.")
        else:
            print("Unexpected error:", e.response['Error']['Message'])
    except BotoCoreError as e:
        print("Boto3 error:", e)
    except Exception as e:
        logging.error("Unexpected error during object listing.", exc_info=e)

if __name__ == "__main__":
    bucket_name = 'my-logging-test-bucket'
    s3_resource = boto3.resource('s3')
    s3_client = boto3.client('s3')

    create_bucket_and_list(s3_resource, bucket_name)
    list_objects_with_error_handling(s3_client, bucket_name)