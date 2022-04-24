#!/bin/bash

tag=$(curl -X POST https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery?api-version=5.1-preview -H "Content-Type: application/json" --data-binary @- <<DATA
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
DATA 
)

