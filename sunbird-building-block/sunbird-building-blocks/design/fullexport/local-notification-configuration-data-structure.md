# Local-Notification-Configuration-Data-Structure

### Overview

Local notification purpose is to notify users to sue the mobile app for better learning experience.

Here user will get notification on timely basis, and the notification will be purely locally generated. For this, when the user installs the application and run it for the first time,  based on certain  configurations a notification event will be set on a particular date\* and time\*, which will be triggered at specified time with some message\*.

### Proposed Design

We're proposing the data structure for configuring the local notification.

Solution 1:A notification will be triggered on every Tuesday at 7:30 PM (19:30) from the next coming Tuesday onwards.

And will be repeated 4 time only, after which there won't be any notification.

```
[
  {
     time: "19:30",
     day: "Tuesday",
	 repeat: 7
     occurrence: 4,
     title: "{\"en\":\"Message\"}",
     msg: "{\"en\":\"Description for Notification\"}"
  }
]] ]></ac:plain-text-body></ac:structured-macro><p class="auto-cursor-target"><br /></p><table class="wrapped"><colgroup><col /><col /><col /><col /></colgroup><tbody><tr><th>Property</th><th>type</th><th>Value (Example)</th><th>Description</th></tr><tr><td>time</td><td>string</td><td>20:15</td><td>time in 24 hours</td></tr><tr><td>day</td><td>string</td><td>&quot;Tuesday&quot;</td><td><p>any day of week [&quot;Moday&quot;, &quot;Tuesday&quot;... &quot;Sunday&quot;]</p><p>Note: either of <code>day</code> or <code>date</code></p></td></tr><tr><td>date</td><td>int</td><td>14</td><td><p>date of the month [1-31]</p><p>Note: either of <code>day</code> or <code>date</code></p></td></tr><tr><td colspan="1">repeat</td><td colspan="1">int</td><td colspan="1">5</td><td colspan="1">number of days notification to be repeated</td></tr><tr><td colspan="1">occurrence</td><td colspan="1">int</td><td colspan="1">10</td><td colspan="1">number of time to repeat the notification</td></tr><tr><td colspan="1">title</td><td colspan="1">string</td><td colspan="1"><br /></td><td colspan="1">Tittle for notification</td></tr><tr><td colspan="1">msg</td><td colspan="1">string</td><td colspan="1"><br /></td><td colspan="1">Description of notification</td></tr></tbody></table><p><br /></p><h4>Solution 2:</h4><p><strong>A)</strong></p><p>A notification will be triggered on every month 20th at 7:00 PM (19:00) from the next coming date.</p><p>And will be repeated monthly, till the given date in `endRepeat` i.e <time datetime="2019-05-20" /> </p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="a32edcf9-0867-4280-9cf1-965dd2cb01f7"><ac:plain-text-body><![CDATA[{
  time: "19:00",
  date: 20,
  repeat: "monthly",
  endRepeat: {
    date: "20/05/2019"
  }
  title: "{\"en\":\"Message\"}",
  msg: "{\"en\":\"Description for Notification\"}"
}
```

**B)**

A notification will be triggered on every day at an interval of 5 days at 10:00 AM (10:00).

And will be occurring for next 6 weeks, after which notification will stop.

```
{
  time: "10:00",
  interval: 5,
  endRepeat: {
    weeks: 6
  }
  title: "{\"en\":\"Message\"}",
  msg: "{\"en\":\"Description for Notification\"}"
}
```

| Property  | type   | Value (Example) | Description                                                                   |
| --------- | ------ | --------------- | ----------------------------------------------------------------------------- |
| time      | string | 20:15           | time in 24 hours                                                              |
| day       | string | "Tuesday"       | any day of week \["Monday", "Tuesday"... "Sunday"]Note: either of day or date |
| date      | int    | 14              | date of the month \[1-31]Note: either of day or date                          |
| repeat    | string | monthly         | repeat pattern                                                                |
|           | string | weekly          |                                                                               |
|           | string | yearly          |                                                                               |
|           | string | daily           |                                                                               |
| title     | string |                 | Tittle for notification                                                       |
| msg       | string |                 | Description of notification                                                   |
| endRepeat | object |                 | object with some properties                                                   |

For repeat object:

| Property    | type | Value (Example) | Description                                                                                                      |
| ----------- | ---- | --------------- | ---------------------------------------------------------------------------------------------------------------- |
| months      | int  | 4               | after N number of months should stop notificationNote: if given then day should be a date of a month,example: 20 |
| weeks       | int  | 5               | after N number of weeks should stop notificationNote: if given then day should be in weekday,example: "Tuesday"  |
| days        | int  | 3               | after N number of days should stop notificationNote: if given then day and repeat should not be provided         |
| repeatCount | int  | 10              | should be repeated for N number of times only                                                                    |

### Pros and Cons

| Solution | Pros                                                                                                 | Cons                                                                                                                                           |
| -------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | Simple logic not too many conditions for calculating date.                                           | While setting passing the values we've to calculate the number of occurrences based on when and how long we want to continue the notification. |
| 2        | Has just have to pass the values it'll automatically calculate the occurrences and stop if required. | Logic will be complex and have to take care of each every value which needs to be passed.                                                      |

### Using In App Notification Payload

After the discussion, we'll be using the same payload structure as described in [In App Notification](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/780894209/In+app+notifications?atlOrigin=eyJpIjoiZDE0YTIzOTc0YmQ2NDJjMDk0YzZhYjUyMWQ1Nzc0MTQiLCJwIjoiYyJ9).

```
{
"id": 14, // id of the notification will be integer, which will be unique
"type": 1, // Notification type will be integer - Their can different notification types, like DOWNTIME, GREETINGS, NON-DISPLAY and OTHERS
"data":{ // action data contains all the information related to type of the notification, start, msg, notification title
	start: '2019/05/20 19:00' // first triggered on specified date, and onwards weekly
	interval: 'week'
	translations: {
		"en": {
			"title": "Title text",
			"msg": "Descriptive message"
		},
		"default" : { // any default language, if language translation not available then to be used
			"title": "Title text",
			"msg": "Descriptive message"
		}
	}
}
}
```

| Property | type     | Value (Example)                                                                                                                                                                   | Description                                                                                                                  |
| -------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| id       | int      |                                                                                                                                                                                   | id of the notification will be integer, which will be unique                                                                 |
| type     | enum     |                                                                                                                                                                                   | Notification type will be integer - Their can different notification types, like DOWNTIME, GREETINGS, NON-DISPLAY and OTHERS |
| data     | obj      | translations                                                                                                                                                                      | Object specifying the language, Example en                                                                                   |
| obj      | interval | Interval specifies the time interval difference between 2 notification. Example, for weekly once on a specific weekdayEx: "interval": "weekday"  should go with 2 format of start |                                                                                                                              |
| obj      | start    | Date and time from when the notification will be triggered for the first time.                                                                                                    |                                                                                                                              |

1. Format "2019/05/14 12:00"
2. "4 19:00" \[days 1-7, i.e Monday(1), ... Sunday(7)]

\| | obj | occurrence | Number of times the notification should be triggered, if null then notification will be shown infinite times on the specified date and time or weekday |

Translations object contains object with these properties with key specifying language code

| Property | type | Value (Example) | Description                                   |
| -------- | ---- | --------------- | --------------------------------------------- |
| en       | obj  | title           | Title of notification, should be string       |
|          | obj  | msg             | Description of notification, should be string |
| hi       | obj  | title           | Title of notification, should be string       |
|          | obj  | msg             | Description of notification, should be string |
| default  | obj  | title           | Title in any default language                 |
|          | obj  | msg             | Message in any default language               |

***

\[\[category.storage-team]] \[\[category.confluence]]
