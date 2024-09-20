# \[Design]-QuestionSet-Assessment-score-report

\*\*Introduction: \*\* The user’s assessment is taken a score report for a question-set. The scores were calculated for question set/s and the latest attempted score was displayed as part of the report.

\*\*Overview: \*\* However now that, a new content type called "Self-Assess” has been introduced, there are some minor changes to do as part of the report. The scores of “Question set” will no more be included as part of the Score report. Instead, the scores of content-type **“Self-Assess”** alone will be included as part of the Score report

As a State Admin, I would want to have access to scores of self-assessment/s of all users within a batch of a course, So that I can get some insights on the quality of the contents within a course.

**Solution I:** Every question units having evaluation logic and plugin knows the question attempted or not. This data we are not sending as part of Telemetry.

After evaluation, there is a callback to the question-set plugin. so while returning data from question unit plugins will send \*\*attempted: true/false and questionId:"do\_id" \*\* as part of the result. This data will carry to question-set and dispatch event to **org.ekstep.questionset:summary.**

So it will help to know the score report of the assessment.

Example:&#x20;

MCQ state data

```js
{
"attempted":true,
"eval": true,
"state": {
"val": 0,
"options": [
{
"text": "<p>True</p>\n",
"image": "",
"audio": "",
"audioName": "",
"hint": "",
"isCorrect": true,
"$$hashKey": "object:1456"
},
{
"text": "<p>False</p>\n",
"image": "",
"audio": "",
"audioName": "",
"hint": "",
"isCorrect": false,
"$$hashKey": "object:1457"
}
]
},
"score": 1,
"params": [
{
"1": "{\"text\":\"True\\n\"}"
},
{
"2": "{\"text\":\"False\\n\"}"
},
{
"answer": "{\"correct\":[\"1\"]}"
}
],
"values": [
{
"1": "{\"text\":\"True\\n\"}"
}
],
"type": "mcq",
"questionId":"do_11287200486896435214"
}
```

**Solution II:** As part of the question-set/assessment, we are generating the "ASSESS" telemetry event for all questions during the evaluation of the question. So each ASSESS event contains question \*\*params and resValues. \*\*

So looking into telemetry Assess event resValues empty or contains data in an array based on this data will consider **Question attempted or skipped.**

|                        | FTB | MCQ | MTF | Sequence | Reorder |
| ---------------------- | --- | --- | --- | -------- | ------- |
| ASSESS Event resvalues |     |     |     |          |         |
|                        |     |     |     |          |         |

Skipped question"edata": { "item": { "id": "do\_11286000975564800011904", "maxscore": 1, "type": "ftb", "exlength": 0, "params": \[ { "1": "{"text":"1"}" }, { "eval": "order" } ], "uri": "", "title": "FTB: QuestionService fix\_\_\_\_\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 1, "pass": "No", "score": 0, "resvalues": \[], "duration": 26 }

|

Skipped question"edata": { "item": { "id": "do\_11286000940202393611903", "maxscore": 1, "type": "mcq", "exlength": 0, "params": \[ { "1": "{"text":"True\n"}" }, { "2": "{"text":"False\n"}" }, { "answer": "{"correct":\["1"]}" } ], "uri": "", "title": "MCQ: QuestionService fix\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 2, "pass": "No", "score": 0, "resvalues": \[ {} ], "duration": 6 }

|

Skipped question"edata": { "item": { "id": "do\_11286000903443251211902", "maxscore": 1, "type": "mtf", "exlength": 0, "params": \[ { "lhs": "\[{"1":"{\\"text\\":\\"A\\\n\\"}"},{"2":"{\\"text\\":\\"B\\\n\\"}"},{"3":"{\\"text\\":\\"C\\\n\\"}"}]" }, { "rhs": "\[{"1":"{\\"text\\":\\"b\\\n\\"}"},{"2":"{\\"text\\":\\"c\\\n\\"}"},{"3":"{\\"text\\":\\"a\\\n\\"}"}]" }, { "answer": "{"lhs":\["1","2","3"],"rhs":\["3","1","2"]}" } ], "uri": "", "title": "MTF:QuestionService fix\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 3, "pass": "No", "score": 0, "resvalues": \[ { "lhs": "\[{"1":"{\\"text\\":\\"A\\\n\\"}"},{"2":"{\\"text\\":\\"B\\\n\\"}"},{"3":"{\\"text\\":\\"C\\\n\\"}"}]" }, { "rhs": "\[{"1":"{\\"text\\":\\"b\\\n\\"}"},{"2":"{\\"text\\":\\"c\\\n\\"}"},{"3":"{\\"text\\":\\"a\\\n\\"}"}]" } ], "duration": 3 }

|

Skipped question"edata": { "item": { "id": "do\_11286001060099686411906", "maxscore": 1, "type": "sequence", "exlength": 0, "params": \[ { "1": "{"text":"Two"}" }, { "2": "{"text":"One"}" }, { "answer": "{"seq":\["2","1"]}" } ], "uri": "", "title": "Question service fix \n", "mmc": \[], "mc": \[], "desc": "" }, "index": 4, "pass": "No", "score": 0, "resvalues": \[ { "1": "{"text":"Two"}" }, { "2": "{"text":"One"}" } ], "duration": 3 }

|

Skipped question"edata": { "item": { "id": "do\_11286001026143846411905", "maxscore": 1, "type": "reorder", "exlength": 0, "params": \[ { "1": "{"text":"4"}" }, { "2": "{"text":"8"}" }, { "3": "{"text":"6"}" }, { "4": "{"text":"5"}" }, { "5": "{"text":"2"}" }, { "6": "{"text":"7"}" }, { "7": "{"text":"1"}" }, { "answer": "{"seq":\["3","7","5","4","2","6","1"]}" } ], "uri": "", "title": "QuestionService fixArrange the given words in proper order to form a sentence.\n\n \n", "mmc": \[], "mc": \[], "desc": "" }, "index": 5, "pass": "No", "score": 0, "resvalues": \[], "duration": 3 }

\| | |

Attempted question"edata": { "item": { "id": "do\_11286000975564800011904", "maxscore": 1, "type": "ftb", "exlength": 0, "params": \[ { "1": "{"text":"1"}" }, { "eval": "order" } ], "uri": "", "title": "FTB: QuestionService fix\_\_\_\_\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 1, "pass": "Yes", "score": 1, "resvalues": \[ { "1": "{"text":"1"}" } ], "duration": 588 }

|

Attempted question"edata": { "item": { "id": "do\_11286000940202393611903", "maxscore": 1, "type": "mcq", "exlength": 0, "params": \[ { "1": "{"text":"True\n"}" }, { "2": "{"text":"False\n"}" }, { "answer": "{"correct":\["1"]}" } ], "uri": "", "title": "MCQ: QuestionService fix\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 2, "pass": "Yes", "score": 1, "resvalues": \[ { "1": "{"text":"True\n"}" } ], "duration": 293 }

|

Attempted question"edata": { "item": { "id": "do\_11286000903443251211902", "maxscore": 1, "type": "mtf", "exlength": 0, "params": \[ { "lhs": "\[{"1":"{\\"text\\":\\"A\\\n\\"}"},{"2":"{\\"text\\":\\"B\\\n\\"}"},{"3":"{\\"text\\":\\"C\\\n\\"}"}]" }, { "rhs": "\[{"1":"{\\"text\\":\\"b\\\n\\"}"},{"2":"{\\"text\\":\\"c\\\n\\"}"},{"3":"{\\"text\\":\\"a\\\n\\"}"}]" }, { "answer": "{"lhs":\["1","2","3"],"rhs":\["3","1","2"]}" } ], "uri": "", "title": "MTF:QuestionService fix\n", "mmc": \[], "mc": \[], "desc": "" }, "index": 3, "pass": "No", "score": 0.33, "resvalues": \[ { "lhs": "\[{"1":"{\\"text\\":\\"A\\\n\\"}"},{"2":"{\\"text\\":\\"B\\\n\\"}"},{"3":"{\\"text\\":\\"C\\\n\\"}"}]" }, { "rhs": "\[{"1":"{\\"text\\":\\"c\\\n\\"}"},{"2":"{\\"text\\":\\"b\\\n\\"}"},{"3":"{\\"text\\":\\"a\\\n\\"}"}]" } ], "duration": 63 }

|

Attempted question"edata": { "item": { "id": "do\_11286001060099686411906", "maxscore": 1, "type": "sequence", "exlength": 0, "params": \[ { "1": "{"text":"Two"}" }, { "2": "{"text":"One"}" }, { "answer": "{"seq":\["2","1"]}" } ], "uri": "", "title": "Question service fix \n", "mmc": \[], "mc": \[], "desc": "" }, "index": 4, "pass": "Yes", "score": 1, "resvalues": \[ { "2": "{"text":"One"}" }, { "1": "{"text":"Two"}" } ], "duration": 62 }

|

Attempted question"edata": { "item": { "id": "do\_11286001026143846411905", "maxscore": 1, "type": "reorder", "exlength": 0, "params": \[ { "1": "{"text":"4"}" }, { "2": "{"text":"8"}" }, { "3": "{"text":"6"}" }, { "4": "{"text":"5"}" }, { "5": "{"text":"2"}" }, { "6": "{"text":"7"}" }, { "7": "{"text":"1"}" }, { "answer": "{"seq":\["3","7","5","4","2","6","1"]}" } ], "uri": "", "title": "QuestionService fixArrange the given words in proper order to form a sentence.\n\n \n", "mmc": \[], "mc": \[], "desc": "" }, "index": 5, "pass": "No", "score": 0, "resvalues": \[ { "2": "{"text":"8"}" }, { "3": "{"text":"6"}" } ], "duration": 55 }

|

**Solution III:** Based on \*\*Telemetry Response event. \*\* Currently, MCQ type of questions only generating a Response event.

If the response event generates so it is considered as an attempted question.

|                | MCQ | FTB | MTF | Sequence | Reorder |
| -------------- | --- | --- | --- | -------- | ------- |
| Response event |     |     |     |          |         |

Attempted question{ "eid": "RESPONSE", "ets": 1571385741820, "ver": "3.0", "mid": "RESPONSE:c35bb556e3920e6a5b287ac699d96448", "actor": { "id": "874ed8a5-782e-4f6c-8f36-e0288455901e", "type": "User" }, "context": { "channel": "b00bc992ef25f1a9a8d63291e20efc8d", "pdata": { "id": "dev.sunbird.portal", "ver": "2.4.0", "pid": "sunbird-portal.contenteditor.contentplayer" }, "env": "contentplayer", "sid": "nm-dQSSXROxfJpbONAmdXSmY\_2ttSA6C", "did": "d1b3344d6b8d8b5441c3b47842b61abd", "cdata": \[ { "id": "f799686c9c913589cf270153edf8dbf6", "type": "ContentSession" } ], "rollup": {} }, "object": { "id": "do\_11287200486896435214", "type": "Content", "ver": "1.0", "rollup": {} }, "tags": \[], "edata": { "target": { "id": "org.ekstep.questionunit.mcq", "ver": "1.3", "type": "plugin" }, "type": "CHOOSE", "values": \[ { "option0": "

True

\n" } ] } }

\| | | | |

**Solution IV:** In questionSet when the user selects or filled the answer, we are preserving the answers for state management. So this data will store in  evaluated result we call state data.

For example: MCQ: result:state:value => if attempted => selected option **index**

&#x20;                                result:state:value=> if skipped => result:state:value: **undefined**

&#x20;                     FTB: result:state:value => if attempted => **array of answers** (result:state:value\['apple','mango'])

&#x20;                                result:state:value=> if skipped => result:state:value **:\[]**

&#x20;                    reorder: result:state:value => if attempted => **array of selected answers** (result:state:value\['apple','mango'])

&#x20;                                result:state:value=> if skipped => result:state:value **:\[]**

**Evaluated result state** **object**

|           | MCQ | FTB | Reorder | Sequence | MTF |
| --------- | --- | --- | ------- | -------- | --- |
| Attempted |     |     |         |          |     |
| Skipped   |     |     |         |          |     |

***

\[\[category.storage-team]] \[\[category.confluence]]
