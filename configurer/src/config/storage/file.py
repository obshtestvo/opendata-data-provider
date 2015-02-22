import json

def read(path):
    return json.load(open(path))

def write(data, path):
    with open(path, 'w') as outfile:
        json.dump(data, outfile)