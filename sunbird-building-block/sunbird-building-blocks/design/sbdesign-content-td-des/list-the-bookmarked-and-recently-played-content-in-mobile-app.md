# List-the-Bookmarked-and-Recently-Played-Content-in-Mobile-App

**Problem Statement:**

* User can can bookmark the content. Content/collections inside of other collections (include courses, textbooks etc.) can also be bookmarked.
* User can see recently viewed content. Only leaf-node content that was actually PLAYED should be displayed in this row (not collections/books/courses etc.)
* The display should be shown based on which was used latest by the current user.

\*\*Solution :   \*\* Create a new table called **content\_markers**  to store the bookmarked and online played content. Schema of the table will be as follows:

| Column Name      | Type    | Value              |
| ---------------- | ------- | ------------------ |
| identifier       | text    | content identifier |
| data             | text    | Content json       |
| marker           | integer |                    |
| visibility       | text    | Default / Parent   |
| epoch\_timestamp | integer |                    |
| uid              | text    | User id            |
|                  |         |                    |
|                  |         |                    |

Values for marker00 - NONE (0)

01 - PREVIEWED (1)

10 - BOOKMARKED (2)

Will do the bitwise operation while storing and retrieving the value for **marker** .

**OR** - While storing the data

**AND** - While retrieving the data

SQLite Bitwise Operators:Bitwise operator works on bits and performs bit-by-bit operation. Following is the truth table for **&** and **|** .

\| p | q | p\&q | p|q | | --- | --- | --- | --- | | 0 | 0 | 0 | 0 | | 0 | 1 | 0 | 1 | | 1 | 1 | 1 | 1 | | 1 | 0 | 0 | 1 | | | | | |

A = 0001

B = 0010

***

A|B = 0011

A\&B = 0000

**When to add the row in this table?**

* When user bookmarks any content
* When user played any content

**When to delete the row from this table?**

* When user remove bookmark then check in **content\_access** table that in content is not played than remove else not.

#### Query to get the bookmarked contents

```sql
Select * from content_markers where (marker&BOOKMARKED) == BOOKMARKED;
```

#### Query to get the recently play contents

```sql
```

**Conclusion**

\*\*  \*\*

***

\[\[category.storage-team]] \[\[category.confluence]]
