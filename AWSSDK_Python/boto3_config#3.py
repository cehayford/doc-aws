import boto3
from botocore.config import Config

custom_config = Config(retries={'max_attempts': 3, 'mode': 'standard'})
s3_client = boto3.client('s3', endpoint_url='https://my-test-bucket.com', config=custom_config)




# import boto3
# from botocore.config import Config

# # Setup a boto3 S3 client with a custom retry strategy: set 'max_attempts' to 5 and 'mode' to 'standard'
# retry_strategy = Config(
#     retries={
#         'max_attempts': 5,
#         'mode': 'standard'
#     }
# )
# s3 = boto3.client('s3', config=retry_strategy)
# 
# # Retrieve the list of S3 buckets
# response = s3.list_buckets()
# print(response['Buckets'])