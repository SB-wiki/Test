[Common Attributes](https://project-sunbird.atlassian.net/wiki/spaces/CO/pages/1572536374/Object+Types#Common-Attributes)



|  **Attribute**  |  **Definition**  |  **Details**  | 
|  --- |  --- |  --- | 
| HierarchyStructure | type: “json”, format: “<[TBD](https://project-sunbird.atlassian.net/wiki/spaces/CO/pages/1572732949/Collection+Definition#Hierarchy-Structure)>“ | Hierarchy structure of the collection. It contains information like what object types and categories are allowed at each level. This information will be used by editors & players for rendering and by the platform for enforcing the structure. | 
| Composition | <ul><li>mimeTypesCount - count of objects in the collection by each mimetype

</li><li>categoriesCount - count of objects in the collection by each category

</li><li>childNodes - list of child nodes

</li><li>leafNodesCount - count of leaf nodes

</li><li>leafNodes - list of lead nodes

</li><li>depth - total depth of the collection

</li></ul> | These details are computed by the platform on every publish. | 

Enum Values:

|  **Attribute**  |  **Enum Values**  | 
|  --- |  --- | 
| Status | "Draft", "Review", "Flagged", "Live", "Unlisted", "Retired", "Processing", "FlagDraft", "FlagReview", "Failed" | 
| MimeType | "application/vnd.ekstep.content-collection" | 

Hierarchy Structure
```json
{
"minDepth": 2, // this collection must have atleast two levels of units
"maxDepth": 2, // this collection can have upto two levels of units
"hierarchy": {
  "1": {
    "unit": "Chapter", // first level units will have category as "Chapter"
    "metadata": {
      // metadata definition (similar to primary category definition, for this unit)
    }
    "children": ["Quiz", "RevisionTest"] // objects of "Quiz" and "Revision" categories can be added to level 1 units
  },
  "2": {
    "unit": "Sub-Chapter", // second level units category should be "Sub-Chapter"
    "children": ["ExplanationResource", "LessonPlan", "PracticeSet"]
  }
},
"children": ["eTextbook", "QuestionPaper"] // objects of "eTextbook" and "QuestionPaper" categories can be added to root node
}
```
Q: do we need to support units of different types in one level? i.e. will there be a scenario where a collection will have some units as “modules” & some units as “sections” in one level?


```json
{
"maxDepth": 2, // no minDepth defined, hence the collection have 0, 1 or 2 levels of units
"hierarchy": {
  "1": {
    "unit": "Chapter",
    "children": null // no child resources allowed
  },
  "2": {
    "unit": "Sub-Chapter",
    "children": "*" // any object can be added
  }
},
"children": ["eTextbook", "QuestionPaper"]
}
```



```json
{
// minDepth and maxDepth are not defined, collection can have any number of levels 
"hierarchy": {
  "*": {
    "unit": "Module", // units in any level will have the category as "Module"
    "children": "*" // any object can be added as a child at all the levels
  }
},
"children": ["Assessment"]
}
```



```json
{
"maxDepth": 4, // this collection can have upto four levels of units
"hierarchy": {
  "1": {
    "unit": "Module", // units in first level will have the category as "Module"
    "children": null // no children can be added to first level units
  },
  "*": {
    "unit": "Sub-Module", // all units in levels other than the first level will have the category as "Sub-Module"
    "children": "*" // any object can be added as a child for units in levels 2, 3 & 4 (as maxDepth is set to 4)
  }
},
"children": ["Assessment"]
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
