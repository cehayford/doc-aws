import boto3
import os

def lambda_handler(event, context):
    # Get S3 bucket and object key from the event
    s3 = boto3.client('s3')
    sns = boto3.client('sns')
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Download the file from S3
    response = s3.get_object(Bucket=bucket, Key=key)
    text = response['Body'].read().decode('utf-8')
    
    # Count words
    word_count = len(text.split())
    
    # Format message
    message = f"The word count in the {key} file is {word_count}."
    subject = "Word Count Result"
    
    # Publish to SNS
    topic_arn = os.environ['SNS_TOPIC_ARN']
    sns.publish(
        TopicArn=topic_arn,
        Message=message,
        Subject=subject
    )
    
    return {'statusCode': 200, 'body': message}


# upload a text file to the S3 bucket named s3sourcedbucket
# and trigger the Lambda function to count the words in the file and publish the result to an SNS topic.
#
# Example of a text file content(textfile.txt):
                # AWS Lambda is a serverless computing service.
                # It runs code without provisioning servers.
                # This makes it perfect for event-driven applications.
                # You only pay for the compute time you consume.
                # AWS Lambda is a serverless computing service.
                # It runs code without provisioning servers.
                # This makes it perfect for event-driven applications.
                # You only pay for the compute time you consume.


# test-case
# {
#   "Records": [
#     {
#       "s3": {
#         "bucket": {
#           "name": "s3sourcedbucket"
#         },
#         "object": {
#           "key": "textfile.txt"
#         }
#       }
#     }
#   ]
# }

# Environment Variables:
# SNS_TOPIC_ARN: arn:aws:sns:us-west-2:232932359389:textfeedtopic