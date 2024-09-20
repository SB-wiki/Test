 **Overview** As sunbird platform gets deployed by different users, they may have specific requirement around which profile fields they want to allow user to edit, which fields re mandatory, what is display name for fields etc.

Currently we have the ability to control - mandatory fields, displaynames, private vs public fields for profile. We can adapt and extend the same solution to include which profile fields are read-only.



 **Solution** We will update the existing System Settings for User Profile Configuration, to support read-only fields settings.



 **Current User Profile Config** 

````
{
  "fields": \[
    "firstName",
    "lastName", ...
  ],
  "publicFields": \[
    "firstName",
    "lastName",
    "profileSummary"
  ],
  "privateFields": \[
    "email",
    "phone"
  ],
  "csv": {
    "supportedColumns": {
      "NAME": "firstName", ...
    },
    "outputColumns": {
      "userId": "USER ID", ...
    },
    "outputColumnsOrder": \[
      "userId", ...
    ],
    "mandatoryColumns": \[
      "firstName", ...
    ]
  },
  "framework": {
    "fields": \[
      "board",
      "id", ...
    ],
    "mandatoryFields": \[
      "board",
      "id", ...
    ]
  }
}

````

 **New Structure** 


```
{
  "fields": \[
    "firstName",
    "lastName",
    ...
  ],
  "publicFields": \[
    "firstName",
    "lastName",
    "profileSummary"
  ],
  "privateFields": \[
    "email",
    "phone"
  ],
  "readOnly" : \[
    "phone", ...
  ],
  "csv": {
    "supportedColumns": {
      "NAME": "firstName",
      ...
    },
    "outputColumns": {
      "userId": "USER ID",
      ...
    },
    "outputColumnsOrder": \[
      "userId",
      ...
    ],
    "mandatoryColumns": \[
      "firstName",
      ...
    ]
  },
  "framework": {
    "fields": \[
      "board",
      "id",
      ...
    ],
    "mandatoryFields": \[
      "board",
      "id",
      ...
    ]
  }
}


```


 **Solution** 

While doing update, we will refer the read-only fields, and check the user-update operation. 

Portal can use the same data to mark fields read-only on UI, by fetching data from system-settings.





*****

[[category.storage-team]] 
[[category.confluence]] 
