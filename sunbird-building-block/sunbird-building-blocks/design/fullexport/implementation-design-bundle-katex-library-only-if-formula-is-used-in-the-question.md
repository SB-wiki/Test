# \[Implementation-Design]---Bundle-Katex-library-only-if-formula-is-used-in-the-question

**Problem Statement** At present when a question is bundled to an ECML content all thee katex library dependencies like CSS, js, fonts etc are getting bundled even though the questions added to the stages does not contain any Formula(Equation) with it. But we need katex library only when a math text or formulas are presented on the question. So Katex library dependencies should be ignored on ECML generation if no questions with formulae are present on any of the stages.

**Proposed Solutions:** The solution consists of 2 parts

1. Adding **formula**  boolean to question body.
2. Bundle/Remove Katex library dependencies from a questionunit plugin.    &#x20;

**Part #1: Adding formula flag to question body on saving the question**  When saving the question data if an equation/formula is added to the question, add a param ' _formula_ ' with value _true_ to the create assessment request body as given in below example:

```js
{
  "request": {
    "assessment_item": {
      "objectType": "AssessmentItem",
      "metadata": {
        "code": "NA",
        "isShuffleOption": false,
        "body": "{\"data\":{\"plugin\":{\"id\":\"org.ekstep.questionunit.mtf\",\"version\":\"1.1\",\"templateId\":\"horizontalMTF\"},\"data\":{\"question\":{\"text\":\"<p>gfggf <span advance=\\\"false\\\" 	  class=\\\"math-text\\\" data-math=\\\"A=\\\\pi r^2A=\\\\pi r^2\\\" style=\\\"display: inline-block;\\\">A=\\\\\\\\pi r^2A=\\\\\\\\pi r^2</span></p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\"},\"option\":{\"optionsLHS\":[{\"text\":\"<p>a</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"index\":1,\"$$hashKey\":\"object:1459\"},{\"text\":\"<p>b</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"index\":2,\"$$hashKey\":\"object:1460\"},{\"text\":\"<p>c</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"index\":3,\"$$hashKey\":\"object:1461\"}],\"optionsRHS\":[{\"text\":\"<p>A</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"mapIndex\":1},{\"text\":\"<p>B</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"mapIndex\":2},{\"text\":\"<p>C</p>\\n\",\"image\":\"\",\"audio\":\"\",\"audioName\":\"\",\"hint\":\"\",\"mapIndex\":3}],\"questionCount\":0},\"media\":[]},\"config\":{\"metadata\":{\"max_score\":1,\"isShuffleOption\":false,\"isPartialScore\":true,\"evalUnordered\":false,\"templateType\":\"Horizontal\",\"name\":\"gfggf A=\\\\\\\\pi r^2A=\\\\\\\\pi r^2\\n\",\"title\":\"gfggf A=\\\\\\\\pi r^2A=\\\\\\\\pi r^2\\n\",\"board\":\"ICSE\",\"medium\":\"English\",\"subject\":\"English\",\"qlevel\":\"MEDIUM\",\"gradeLevel\":[\"Class 1\"],\"category\":\"MTF\"},\"max_time\":0,\"max_score\":1,\"partial_scoring\":true,\"layout\":\"Horizontal\",\"isShuffleOption\":false,\"questionCount\":1,\"evalUnordered\":false},\"media\":[],\"formula\":true}}",
        "itemType": "UNIT",
        "version": 2,
        "category": "MTF",,
        "createdBy": "fd7ef85c-df8f-4504-b502-47d001085e91",
        "channel": "01231711180382208027",
        "type": "mtf",
        "template": "NA",
        "template_id": "NA",
        "framework": "NCF",
        "max_score": 1,
        "isPartialScore": true,
        "evalUnordered": false,
        "templateType": "Horizontal",
        "name": "gfggf A=\\\\pi r^2A=\\\\pi r^2\n",
        "title": "gfggf A=\\\\pi r^2A=\\\\pi r^2\n",
        "board": "ICSE",
        "medium": "English",
        "subject": "English",
        "qlevel": "MEDIUM",
        "gradeLevel": [
          "Class 1"
        ],
        "lhs_options": [
          {
            "value": {
              "type": "mixed",
              "text": "इक",
              "image": "",
              "count": "",
              "audio": "",
              "resvalue": "इक",
              "resindex": 0
            },
            "index": 0
          }
        ],
        "rhs_options": [
          {
            "value": {
              "type": "mixed",
              "text": "इक",
              "image": "",
              "count": "",
              "audio": "",
              "resvalue": "इक",
              "resindex": 0
            },
            "index": 0
          }
        ]
      },
      "outRelations": []
    }
  }
}
```

**Part #2: Bundle/Remove Katex Plugins on Ecml Generation** When generating ECML if questionbody contains the flag  **formula** with value **true** then we should include the katex library dependencies else those dependencies should be removed.

This can be done with any of the 2 approaches:

**1. Remove katex dependencies from QuestionUnit Plugin Manifest and add on demand :** First, remove all katex library dependencies of questionunit plugin in its manifest. When StageManager invokes ECML generation method of questionset plugin for each stage while bundling each question check for the flag  **formula**  in questionbody **,** If the value is true then add the katex library dependencies and generate ecml. If the flag is not present or undefined then also add katex dependencies to support backward compatibility for older questions.

**Drawbacks:**

If we go by this approach then preview plugin requires changes as it will break while rendering question with formula if the katex library is not present.

**2. Remove/Add katex dependencies to QuestionUnit Plugin at runtime without changing manifest:** When StageManager invokes the ECML generation method of questionset plugin and none of the questions present on those stages has the  **formula**  flag  with value true in their body **,** then remove the katex library dependencies and generate ecml.

while removing the katex library dependencies keep a local buffer to hold those values and if any question with formula is added to stage further on the same session then the buffered dependencies should be added to questionunit plugin dependencies.

Among the above 2 approaches, the second one is the better one as it does not break the preview side.

**Conclusion:**

This feature will reduce the size of generated ECML content considerably for the included questions that don't have formulae in it.&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
