import boto3

# TODO: Use boto3 to initialize an EC2 resource with the default session.
default_session = boto3.Session()
print(f"Default session created. Region: {default_session.region_name}")

# TODO: Create a custom session targeting the 'us-west-2' region.
region_specific_session = boto3.Session(region_name='us-west-2')
print(f"Region-specific session created. Region: {region_specific_session.region_name}")

# TODO: Use the custom session you created to initialize another EC2 resource.
default_ec2_resource, region_specific_ec2_resource = default_session.resource('ec2'), region_specific_session.resource('ec2')
print(f"EC2 resource (default session): {default_ec2_resource}")
print(f"EC2 resource (region-specific session): {region_specific_ec2_resource}")