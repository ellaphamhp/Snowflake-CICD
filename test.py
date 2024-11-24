import os
from utils import s3_operations, list_files

# List files
directory_path = "/Users/epham/PycharmProjects/dataproject/data"
file_name, creation_date = list_files.get_latest_file(directory_path)
if file_name:
    print(f"The last created file is: {file_name}, on {creation_date}")
else:
    print("No files found in the directory.")

#Usage example
bucket_name = 'dataproject-jun24'
object_name = 'ports/' + os.path.basename(file_name).split('.')[0] + '_' + str(creation_date)

s3_operations.upload_file(file_name, bucket_name, object_name)