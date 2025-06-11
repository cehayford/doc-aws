sudo dnf install mysql-community-server -y


{
  "dbUrl": "ec2-34-216-220-240.us-west-2.compute.amazonaws.com",
  "dbName": "cafe_db",
  "dbUser": "root",
  "dbPassword": "Re:Start!9"
}


# arn:aws:iam::585282832708:role/salesAnalysisReportRole

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


arn:aws:sns:us-west-2:585282832708:salesAnalysisReportTopic


