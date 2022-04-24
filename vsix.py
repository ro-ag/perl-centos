import requests
import json
from requests.structures import CaseInsensitiveDict

url = "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery?api-version=5.1-preview"

headers = CaseInsensitiveDict()
headers["Content-Type"] = "application/json"

data = """
{
    "filters": [
        {
        "criteria": [
            {
                "filterType": 8,
                "value": "Microsoft.VisualStudio.Code"
            },
            {
                "filterType": 7,
                "value": "ms-python.python"
            }
        ],
        "pageNumber": 1,
        "pageSize": 10,
        "sortBy": 0,
        "sortOrder": 0
        }
    ],
    "assetTypes": ["Microsoft.VisualStudio.Services.VSIXPackage"],
    "flags": 514
}
"""


resp = requests.post(url, headers=headers, data=data)

print(resp.status_code)
print(resp.content)

jdata = json.loads(resp.content)

print(jdata)