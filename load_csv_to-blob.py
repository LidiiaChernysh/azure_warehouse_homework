import os
import random
import uuid

from azure.core.exceptions import ResourceExistsError
from azure.storage.filedatalake import DataLakeServiceClient

#connection_string = os.getenv('AZURE_STORAGE_LAKE_CONNECTION_STRING')

account_name = os.getenv("STORAGE_ACCOUNT_NAME")
credential = os.getenv("STORAGE_ACCOUNT_KEY")
account_url = "https://{}.dfs.core.windows.net/".format(account_name)

file_name = 'yellow_tripdata_2020-01.csv'

datalake_service = DataLakeServiceClient(account_url=account_url,
                                         credential=credential)
file_system = "chernysh"   # like container in BlobServiceClient

try:
    filesystem_client = datalake_service.create_file_system(file_system=file_system)

    dir_client = filesystem_client.get_directory_client("folder_yellow")
    dir_client.create_directory()

    with open(file_name, "rb") as data:
        filesystem_client = dir_client.get_file_client(file_name)
        filesystem_client.create_file()
        filesystem_client.append_data(data, 0)
        filesystem_client.flush_data(data.tell())

except ResourceExistsError as ex:
    print('Exception:')
    print(ex)
