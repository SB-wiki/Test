# Vocabulary-Design-Brainstorm

**Introduction** Different Contents can be created with multiple terms with the same meaning. As part of search API, we should provide contents which satisfies the filter criteria as well as the relevant content which are relatively nearer to the search criteria.

**Background & Problem Statement** Before implementation of Framework, content creation were having very limited set of generic term which were utilised to categorise content. These were very much generic at LP layer. Later, it was realised that - there should be an infrastructure which can be utilised to make the terms specific to the instance. This requirement brought the concept of Framework APIs.

But with availability and ease of framework terms creation, it is becoming easy to create large numbers of terms that may lead to duplication of terms, terms with same meaning, terms with incomplete metadata, no association or no translation.

Vocabulary layer is considered a dictionary of terms, which will be independent of framework. It holds the association among the terms. Each term can be part of set of related terms and have associationship with other terms.

The main target of vocabulary is to enrich framework terms and enhancement of search service.

**The vocabulary layer should have following component**

* \*\*Vocabulary terms: \*\* Basic building block of the vocabulary layer. Will be considered as individual word.
* \*\*Sets: \*\* Logical grouping of terms holding similar property.
* &#x20; \*\*Associations and relations: \*\* Type of associations between two terms, like synonyms, derived from same root, morphological variant, antonyms, co-occur, precedes etc.

**Proposed Design:** **Data Model:** Vocabulary layer model meant for enriching framework functionality and improving the content search capability. Vocabulary data will not be directly associated with any of the framework or content data model. These vocabulary terms will be linked as tags to the framework terms.

![](../../../../Design/FullExport/images/storage)

***

\[\[category.storage-team]] \[\[category.confluence]]
