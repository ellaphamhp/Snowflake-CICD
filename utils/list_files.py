import os
import glob
import datetime

def get_latest_file(directory):
    list_of_files = glob.glob(f'{directory}/*')
    if not list_of_files:
        return None

    latest_file = max(list_of_files, key=os.path.getctime)
    creation_time = os.path.getctime(latest_file)
    creation_date = datetime.datetime.fromtimestamp(creation_time).date()

    print(f" Folder contain the following files: {list_of_files}")
    print(f" The lastest file was created on: {creation_date}")

    return latest_file, creation_date

if __name__ == '__main__':
   get_latest_file()