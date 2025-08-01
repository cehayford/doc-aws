sudo dnf install mysql-community-server -y


{
  "dbUrl": "ec2-34-216-220-240.us-west-2.compute.amazonaws.com",
  "dbName": "cafe_db",
  "dbUser": "root",
  "dbPassword": "Re:Start!9"
}


# arn:aws:iam::585282832708:role/salesAnalysisReportRole

arn:aws:iam::585282832708:role/salesAnalysisReportRole

aws lambda create-function \
--function-name salesAnalysisReport \
--runtime python3.9 \
--zip-file fileb://salesAnalysisReport-v2.zip \
--handler salesAnalysisReport.lambda_handler \
--region us-west-2 \
--role arn:aws:iam::585282832708:role/salesAnalysisReportRole

# {
#     "FunctionName": "salesAnalysisReport", 
#     "LastModified": "2025-06-11T14:59:37.744+0000", 
#     "RevisionId": "77a1aee0-6e7c-4553-a2c5-677c2877e969", 
#     "MemorySize": 128, 
#     "State": "Pending", 
#     "Version": "$LATEST", 
#     "Role": "arn:aws:iam::585282832708:role/salesAnalysisReportRole", 
#     "Timeout": 3, 
#     "StateReason": "The function is being created.", 
#     "Runtime": "python3.9", 
#     "StateReasonCode": "Creating", 
#     "TracingConfig": {
#         "Mode": "PassThrough"
#     }, 
#     "CodeSha256": "FOQaNphpQr/canEnzctygYFVreHKiABxYNh8X8lOpnE=", 
#     "Description": "", 
#     "CodeSize": 1643, 
#     "FunctionArn": "arn:aws:lambda:us-west-2:585282832708:function:salesAnalysisReport", 
#     "Handler": "salesAnalysisReport.lambda_handler"
# }



import boto3
import os
import json
import io
import datetime

def setTabsFor(productName):
    # Determine the required number of tabs between Item Name and Quantity based on the item name's length.

    nameLength = len(productName)

    if nameLength < 20:
        tabs='\t\t\t'
    elif 20 <= nameLength <= 37:
        tabs = '\t\t'
    else:
        tabs = '\t'

    return tabs

def lambda_handler(event, context):
  # Retrieve the topic ARN and the region where the lambda function is running from the environment variables.
                        # The topic ARN is set in the Lambda function configuration.
                        # It is in need of the SNS ARN  not the IAM ARN. 
                        # Example of a topic ARN: 
                          # arn:aws:sns:us-west-2:585282832708:salesAnalysisReportTopic
    TOPIC_ARN = os.environ['topicARN']
    FUNCTION_REGION = os.environ['AWS_REGION']

    # Extract the topic region from the topic ARN.

    # arnParts = TOPIC_ARN.split(':')
    TOPIC_REGION = "us-west-2"

    # Get the database connection information from the Systems Manager Parameter Store.

    # Create an SSM client.

    ssmClient = boto3.client('ssm', region_name=FUNCTION_REGION)

    # Retrieve the database URL and credentials.

    parm = ssmClient.get_parameter(Name='/cafe/dbUrl')
    dbUrl = parm['Parameter']['Value']

    parm = ssmClient.get_parameter(Name='/cafe/dbName')
    dbName = parm['Parameter']['Value']

    parm = ssmClient.get_parameter(Name='/cafe/dbUser')
    dbUser = parm['Parameter']['Value']

    parm = ssmClient.get_parameter(Name='/cafe/dbPassword')
    dbPassword = parm['Parameter']['Value']

    # Create a lambda client and invoke the lambda function to extract the daily sales analysis report data from the database.

    lambdaClient = boto3.client('lambda', region_name=FUNCTION_REGION)

    dbParameters = {"dbUrl": dbUrl, "dbName": dbName, "dbUser": dbUser, "dbPassword": dbPassword}
    response = lambdaClient.invoke(FunctionName = 'salesAnalysisReportDataExtractor', InvocationType = 'RequestResponse', Payload = json.dumps(dbParameters))

    # Convert the response payload from bytes to string, then to a Python dictionary in order to retrieve the data in the body.

    reportDataBytes = response['Payload'].read()
    reportDataString = str(reportDataBytes, encoding='utf-8')
    reportData = json.loads(reportDataString)
    reportDataBody = reportData["body"]

    # Create an SNS client, and format and publish a message containing the sales analysis report based on the extracted report data.

    snsClient = boto3.client('sns', region_name=TOPIC_REGION)

    # Create the message.

    # Write the report header first.

    message = io.StringIO()
    message.write('Sales Analysis Report'.center(80))
    message.write('\n')

    today = 'Date: ' + str(datetime.datetime.now().strftime('%Y-%m-%d'))
    message.write(today.center(80))
    message.write('\n')

    if (len(reportDataBody) > 0):

        previousProductGroupNumber = -1

        # Format and write a line for each item row in the report data.

        for productRow in reportDataBody:

            # Check for a product group break.

            if productRow['product_group_number'] != previousProductGroupNumber:

               # Write the product group header.

                message.write('\n')
                message.write('Product Group: ' + productRow['product_group_name'])
                message.write('\n\n')
                message.write('Item Name'.center(40) + '\t\t\t' + 'Quantity' + '\n')
                message.write('*********'.center(40) + '\t\t\t' + '********' + '\n')

                previousProductGroupNumber = productRow['product_group_number']

            # Write the item line.

            productName = productRow['product_name']
            tabs = setTabsFor(productName)

            itemName = productName.center(40)
            quantity = str(productRow['quantity']).center(5)
            message.write(itemName + tabs + quantity + '\n')

    else:

        # Write a message to indicate that there is no report data.

        message.write('\n')
        message.write('There were no orders today.'.center(80))

    # Publish the message to the topic.

    response = snsClient.publish(
        TopicArn = TOPIC_ARN,
        Subject = 'Daily Sales Analysis Report',
        Message = message.getvalue()
    )

    # Return a successful function execution message.

    return {
        'statusCode': 200,
        'body': json.dumps('Sale Analysis Report sent.')
    }


# If you are in London (UTC time zone), 
# and the current time is 11:30 AM, enter the following expression:
# cron(35 11 ? * MON-SAT *)

# If you are in New York (UTC time zone -5 during Eastern Standard Time), 
# and the current time is 11:30 AM, enter the following expression:
# cron(35 16 ? * MON-SAT *)