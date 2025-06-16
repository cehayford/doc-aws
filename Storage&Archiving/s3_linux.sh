aws s3 mb s3://cafe-freeze-cult --region 'us-west-2'


# loading images
aws s3 sync ~/initial-images/ s3://cafe-freeze-cult/images


# lista all syncing files
aws s3 ls s3://cafe-freeze-cult/images/ --human-readable --summarize

# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:ChangePassword"
#             ],
#             "Resource": [
#                 "arn:aws:iam::*:user/${aws:username}",
#                 "arn:aws:iam::*:user/*/${aws:username}"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:GetAccountPasswordPolicy"
#             ],
#             "Resource": "*"
#         }
#     ]
# }


# Access Key User ID: AKIAXRVH6VSO2U6BBEAG
# Secret Access Key User ID: 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
# Console Sign-in Link: https://518969535645.signin.aws.amazon.com/console



# s3NotificationTopic ARN: arn:aws:sns:us-west-2:518969535645:s3NotificationTopic


{
  "Version": "2008-10-17",
  "Id": "S3PublishPolicy",
  "Statement": [
    {
      "Sid": "AllowPublishFromS3",
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:us-west-2:518969535645:s3NotificationTopic",
    #   "Resource": "<ARN of s3NotificationTopic>",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:s3:*:*:cafe-freeze-cult"
        #   "aws:SourceArn": "arn:aws:s3:*:*:<cafe-xxxnnn>"
        }
        }
    }
  ]
}



{
    "TopicConfigurations": [
      {
        "TopicArn": "arn:aws:sns:us-west-2:518969535645:s3NotificationTopic",
        "Events": ["s3:ObjectCreated:*","s3:ObjectRemoved:*"],
        "Filter": {
          "Key": {
            "FilterRules": [
              {
                "Name": "prefix",
                "Value": "images/"
              }
            ]
          }
        }
      }
    ]
  }


# configuring files with the s3 bucket
# aws s3api put-bucket-notification-configuration --bucket <cafe-xxxnnn> --notification-configuration file://s3EventNotification.json
aws s3api put-bucket-notification-configuration --bucket cafe-freeze-cult --notification-configuration file://s3EventNotification.json


# working with the aws cli of mediacouser
aws s3api put-object --bucket cafe-freeze-cult --key images/Caramel-Delight.jpg --body ~/new-images/Caramel-Delight.jpg
# {
#     "ETag": "\"31ac30da619244b0ce786f106e4f3df7\"", 
#     "ServerSideEncryption": "AES256"
# }


# geting the object Doughnut.jpg from the bucket
aws s3api get-object --bucket cafe-freeze-cult --key images/Donuts.jpg Donuts.jpg
# {
#     "AcceptRanges": "bytes", 
#     "ContentType": "image/jpeg", 
#     "LastModified": "Mon, 16 Jun 2025 13:06:40 GMT", 
#     "ContentLength": 380753, 
#     "ETag": "\"405b0bcc53cb5ab713c967dc1422b4f4\"", 
#     "ServerSideEncryption": "AES256", 
#     "Metadata": {}
# }


# deleting the object Strawberry-Tarts.jpg from the bucket
aws s3api delete-object --bucket cafe-freeze-cult --key images/Strawberry-Tarts.jpg


# changing permissions of the object
# An error occurred (AccessDenied) when calling the PutObjectAcl operation: Access Denied
aws s3api put-object-acl --bucket cafe-freeze-cult --key images/Donuts.jpg --acl public-read