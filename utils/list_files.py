import os
import glob
import datetime
import sys

def get_latest_file(directory):
    list_of_files = glob.glob(f'{directory}/*')
    if not list_of_files:
        return "No file found", 0

    latest_file = max(list_of_files, key=os.path.getctime)
    creation_time = os.path.getctime(latest_file)
    creation_date = datetime.datetime.fromtimestamp(creation_time).date()
    #
    # if not latest_file:
    #     return "No new file", 0
    # else:
    return latest_file, creation_date

if __name__ == '__main__':
   get_latest_file()
