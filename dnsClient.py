import requests
import hashlib
import json
import os
import sys

secret=sys.argv[1]
hash=hashlib.sha1(secret.encode('utf-8')).hexdigest()
payload={"secret":secret, "hash":hash}
headers={'content-type':'application/json'}
response=requests.post('http://api.testriot.ml/login',data=json.dumps(payload),headers=headers)
if response.status_code == 200:
    print(response.text)
    response=response.json()
    if response['success']==1:
        print hash
        sys.exit(0)
    else:
        print ''
        sys.exit(0)
else:
    print ''
    sys.exit(0)
