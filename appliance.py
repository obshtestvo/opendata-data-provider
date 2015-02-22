#!/usr/bin/env python3

import urllib.parse
import urllib.request
import json
import pprint
import random
import requests

# constants
HOST = "https://opendata.government.bg/"
CREATE_PACKAGA_URL = HOST + "api/3/action/package_create"
CREATE_RESOURCE_URL = HOST + "api/3/action/resource_create"

# config
api_key = "..."
dataset_name = "a" + str(random.randrange(1, 23232333333332))
dataset_title = '...'

# Put the details of the dataset we're going to create into a dict.
dataset_dict = {
    'name': dataset_name,
    'title': dataset_title,
    'owner_org': organization
}

# Use the json module to dump the dictionary to a string for posting.
data_string = urllib.parse.quote(json.dumps(dataset_dict))

# We'll use the package_create function to create a new dataset.
request = urllib.request.Request(CREATE_PACKAGA_URL)

# Creating a dataset requires an authorization header.
request.add_header('Authorization', api_key)

# Make the HTTP request.
response = urllib.request.urlopen(request, data_string.encode())
assert response.code == 200

response_dict = json.loads(response.read().decode())

# Check the contents of the response.
assert response_dict['success'] is True
result = response_dict['result']

package_id = result['id']

response_file = requests.post(CREATE_RESOURCE_URL,
              data={
                  "package_id": package_id,
                  "name": "a" + str(random.randrange(1, 232321)),
                  "url": "upload"
                  },
              headers={ "Authorization": api_key },
              files=[('upload', open('/Users/petko/repos/opendata-data-provider/bla.csv'))])

assert response_file.status_code == 200

response_file_json = response_file.json()

if response_file_json['success']:
    pprint.pprint('Resource ' + response_file_json['result']['name'] +
            ' uploaded to: ' + response_file_json['result']['url'])


