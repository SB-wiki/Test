# Background:

Jira ticket:[ED-1975 System JIRA](https://browse/ED-1975)

**Problem Statement :**

1. The profile can update with any framework categories if the server allows it.
2. We have to upgrade DB with dynamic keys and remove BMGS from local DB, then for existing users it will throw error.
3. Guest users use the BMGS framework, now login with existing user which framework is different(organisation) than how to handles it?

**Update profile request BMGS to category1, category2, category3 and category4, we are facing some issue from backend.**

Discussion Link: [https://github.com/orgs/Sunbird-Lern/discussions/122](https://github.com/orgs/Sunbird-Lern/discussions/122)

```
"request": "request": {
  "userId": "155ce3c5-713e-4749-bc1c-95d09c640914",
  "framework": {
    "id": [
      "framework1"
    ],
    "category1": [
      "Category1 Term1"
    ],
    "category2": [
      "Category2 Term1"
    ],
    "category3": [
      "Category3 Term1"
    ]
  }
}
```

**Response:**

```
{
  "id": "api.user.update",
  "ver": "v3",
  "ts": "2023-05-24 11:20:58:043+0000",
  "params": {
    "resmsgid": "8d9f1be63451afa782c6b65a16c409d8",
    "msgid": "8d9f1be63451afa782c6b65a16c409d8",
    "err": "UOS_USRUPD0051",
    "status": "FAILED",
    "errmsg": "Unsupported field framework.category1."
  },
  "responseCode": "CLIENT_ERROR",
  "result": {
    
  }
}
```

Jira ticket: [ED-2124 System JIRA](https://browse/ED-2124)

**Design:** **Update Profile:**

**a) Server Profile:**

Now we can use category1, category2, category3 and category4 as update user profile request instead of BMGS.

Example of update profile request.

```
"request": "request": {
  "userId": "155ce3c5-713e-4749-bc1c-95d09c640914",
  "framework": {
    "id": [
      "framework1"
    ],
    "category1": [
      "Category1 Term1"
    ],
    "category2": [
      "Category2 Term1"
    ],
    "category3": [
      "Category3 Term1"
    ]
  }
}
```

**Update Profile for Logged In user:**

Update profile request BMGS to category1, category2, category3 and category4

```
 this.profileService.updateServerProfile(req).toPromise()
```

**Update profile with category\[i] for New Logged in USer:**

Update profile request BMGS to category1, category2, category3 and category4

```
 this.profileService.updateServerProfile(req).toPromise()
```

**Edit Logged In User:**

Update profile request BMGS to category1, category2, category3 and category4

```
 const req: UpdateServerProfileInfoRequest = {
      userId: this.profile.uid,
      framework: {
        id: this.frameworkId,
      }
    };
    req.framework['board'] = [this.boardList.find(board => code === board.code).name];
  req.framework['medium'] = medium;
  req.framework['gradeLevel'] = grade;
  req.framework['subject'] = subjects;
   // req.framework['category1'] = 'categories';
    this.profileService.updateServerProfile(req).toPromise()
```

&#x20;

b) **Local profile DB :**

Update local profile DB keys BMGS to category1, category2, category3 and category4.

The new DB will be created for new user with category1,….category4 but _**for existing user we have to write a migrate code for DB update with category\[i]**_

```
export interface Profile {
    uid: string;
    handle: string;
    createdAt?: number;
    medium?: string[];
    board?: string[];
    subject?: string[];
    profileType: ProfileType;
    grade?: string[];
    syllabus?: string[];
    source: ProfileSource;
    gradeValue?: { [key: string]: any };
    serverProfile?: ServerProfile;
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
