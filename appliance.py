#!/usr/bin/env python3

import urllib.parse
import urllib.request
import json
import pprint
import random
import requests
import os
from configurer.src.config.storage.file import read

class OpenDataProvider(object):

    def __init__(self):
        # Constants
        HOST = "https://opendata.government.bg/"
        self.CREATE_PACKAGA_URL = HOST + "api/3/action/package_create"
        self.CREATE_RESOURCE_URL = HOST + "api/3/action/resource_create"
        self.SUPPORTED_FILE_FORMATS = ["csv", "tsv"]

        # config
        self.api_key = "..."
        self.dataset_name = "a" + str(random.randrange(1, 23232333333332))
        self.dataset_title = "Име"
        self.organization = "hackathonfebruary2015"
        self.source_dir = "..."

    def push_dataset(self):

        # Put the details of the dataset we're going to create into a dict.
        dataset_dict = {
            'name': self.dataset_name,
            'title': self.dataset_title,
            'owner_org': self.organization
        }

        # Use the json module to dump the dictionary to a string for posting.
        data_string = urllib.parse.quote(json.dumps(dataset_dict))

        # We'll use the package_create function to create a new dataset.
        request = urllib.request.Request(self.CREATE_PACKAGA_URL)

        # Creating a dataset requires an authorization header.
        request.add_header('Authorization', self.api_token)

        # Make the HTTP request.
        response = urllib.request.urlopen(request, data_string.encode())
        assert response.code == 200
        response_dict = json.loads(response.read().decode())

        # Check the contents of the response.
        assert response_dict['success'] is True
        return response_dict['result']['id']

    def push_resource(self, package_id, path_to_file):

        response_file = requests.post(self.CREATE_RESOURCE_URL,
              data={
                  "package_id": package_id,
                  "name": "a" + str(random.randrange(1, 232321)),
                  "url": "upload"
                  },
              headers={ "Authorization": self.api_token },
              files=[('upload', open(path_to_file))])

        assert response_file.status_code == 200
        return response_file.json()

    def read_files(self, path_to_files):
        return os.listdir('/Users/petko/repos')

if __name__ == '__main__':
    odp = OpenDataProvider()
    package_id = odp.push_dataset()
    data_files = [x for x in os.listdir(odp.source_path)
                    if x.split('.')[-1] in odp.SUPPORTED_FILE_FORMATS]
    for datafile in data_files:
        odp.push_resource(package_id, odp.source_path + "/" + datafile)
        print("Uploaded " + datafile)


