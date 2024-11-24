import boto3
from botocore.exceptions import ClientError


# funtion to upload  a local file to s3 buckets
def upload_file(file_name, bucket, object_name=None):
    # If S3 object_name was not specified, use file_name
    if object_name is None:
        object_name = file_name

    # Create an S3 client
    s3_client = boto3.client('s3')
    try:
        s3_client.upload_file(file_name, bucket, object_name)
        print(f"File {file_name} uploaded successfully to {bucket}/{object_name}")
        return True
    except ClientError as e:
        print(f"Error uploading file: {e}")
        return False

if __name__ == '__main__':
   upload_file()