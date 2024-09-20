# View-course-stats

Problem Statement 1As of now we are showing all records , once we have more data api call , page loading will take more time, so we need to introduce pagination here

Previous Implementation GET  /v1/dashboard/progress/course/:batchId?Period=LAST7/LAST14

New ImplementationApproach 1GET /v1/dashboard/progress/course/:batchId?limit=200\&offset=0

1. With the help of limit we can define the data size.
2. offset will help in getting the starting point.

With the help of limit and offset the details of the user progress in the desired batch will be fetched and calculate the progress of user&#x20;

Pros

1. Limit will be dynamic, so we can change limit anytime

&#x20;    Cons

1. If new data comes up in between of next query then data will be mismatch&#x20;

Output

```
"result" :{ data :  [{
	batchEndsOn: "2019-02-04"
	enrolledOn: "2019-01-29 06:51:36:440+0000"
	firstName: "User"
	lastAccessTime: null
	lastName: "twotwo"
	org: "Sunbird"
	progress: 0
	user: "c06222b0-e17e-4763-a8e9-371f30e51886"
	orgName:""
	phoneNumber:""
}]
offset:
totalCount:
totalCompletionCount:
startDate:
endDate:

}
```

Issues: Portal team is not working on this ticket and we are changing the parameters so to support both&#x20;

1. We can create a v2 request.&#x20;
2. We can keep the earlier code itself and add extra code to handle both parameters.

Problem Statement 2In the current process, the download extract is sent to the course mentor’s email ID. We will continue sharing the extract in the email mode to the course mentors' email id.

The current csv file has the following fields:

| Previous fields in CSV |
| ---------------------- |
| Loginid                |
| Name                   |
| CreatedDate            |
| Language               |
| Subject                |
| Grade                  |
| Progress               |

Now updated CSV will have&#x20;

| Fields in CSV   | Values for it                                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------------------------- |
| User Name       | This field captures user’s full name                                                                                |
| Org Name        | If the user is mapped to multiple Org Names, please show all the org names separated by a comma in the same row.    |
| School Name     | If the user is mapped to multiple school names then show all the school names separated by a comma in the same row. |
| Enrollment Date | In this field show the date when the user was enrolled into the course batch                                        |
| Progress        | User’s course progress in that specific batch                                                                       |
| Date time stamp | Date timestamp of when the report was generated                                                                     |

***

\[\[category.storage-team]] \[\[category.confluence]]
