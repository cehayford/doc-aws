aws s3 mb s3://cafe-ultra-sweet --region 'us-west-2'

mkdir -p ~/initial-images/

aws s3 sync ~/initial-images/ s3://cafe-ultra-sweet/

aws s3 ls s3://cafe-ultra-sweet/ --human-readable --summarize
# Total Objects: 2
#    Total Size: 22.8 MiB


