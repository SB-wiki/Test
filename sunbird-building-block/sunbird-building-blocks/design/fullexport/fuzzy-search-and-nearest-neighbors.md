# Fuzzy-Search-and-Nearest-Neighbors

**Problem:**

Typical relational database systems are set theoretic in nature. Effectively, the query under consideration defines a set, and each result in the query is a member of that set. These sets are not fuzzy, meaning that a record (a row in a table) belongs to this set or not. There is nothing in between. Consequently, the result set can be empty. This can happen more often than not as the querying dimensions grow and of course it also depends on the how and who generated the data. Due to the brittle nature of the hard partitioning induced by the query, records that are close semantically could be missed out. By relaxing the query, can we have better control the size of the result?

**Scenario**

Consider just three fields (dimensions) we are interested in. Ignore any other fields. They are

1. _temperature_ : a numerical variable with range -10 to 100, representing average temperature measured in degrees.
2. _crops_ : wheat, rice, apples, mangoes, grapes
3. _yield_ : low, medium, high
4. price per 1kg etc..(some other facts)

We have one numerical attribute, one categorical, and another ordinal attribute. One query could be: Get the price per kg where crops=apples, temperature >50, and yield = high. Such combination of dimensions may not exist in the database because apples may not have high yield when the temperature is above 50 degrees. So, the query may get zero results.

Instead, what if the query says, there is no exact match, but I get you the closest to your ask. Here are the result set:

1. crops =apples, temperature >20, yield = high&#x20;
2. crops = mangoes, temperature > 50, yiled = high
3. crops =apples, temperature >50, yield = low&#x20;

**What do we need to do?**

We need some way to evaluate every row-column pair (cell in a table) to a Boolean. Using the conjunction operators in the original query, evaluate the Truth value of every row. The rows with Truth value True - will be returned as the result set. We can define tolerance as a parameter which tells how much of an "tolerance" we can accommodate. If the tolerance is zero, then we execute the query as is and we are ok with accepting 0 results. As the tolerance increases, we allow many closer answers to sneak in. Let us see the mechanics of doing it.&#x20;

* Numerical attributed need little modifications
* Every ordinal variable can be turned into a numerical variable. Example: An ordinal variable with three values (low, medium, high) could be turned into a numerical variable in the range (0,1) where low=0.25, medium=0.5, high=0.75
* Categorical variables will be represented by some p-dimensional vectors which capture the semantics, where p is at least the size of the number of distinct levels of that categorical variable. For example, we know that rice and wheat are closer to each other than to apples, grapes and mangoes. In fact, we know the that the former are cereal crops, and later are fruits (example follows).&#x20;

In effect, we turn every filed into numerical vector. We then define some functions on them which will accept a tolerance parameter, the comparator operators, and return a boolean value. We can then take the query, progressively vary the tolerance parameter around the query fields until we get a desired size of the result set. This can be accommodated in a standard k-nearest neighbor search algorithms with some customization.

**Flow:**

1. **Define the Vectors**
   1. Crops: it is a five dimensional vector
   2. Wheat =(1,0.8,0.01,0.01.0.01)
   3. Apple =(0.01,0.01,1,0.8.0.8)
   4. ...
   5. Temperature: as is
   6. Yield: convert into a numerical variable
   7. high = 0.75
   8. medium = 0.5
   9. low = 0.25
2. **Map the query to its feature vector**
3. **Run the query**
   1. If result set is empty or minimum set size is not met
   2. Find k-nearest neighbors, for a given k. Standard k-nearest neighbor can be customized to&#x20;
   3. Otherwise, return the set as is

***

\[\[category.storage-team]] \[\[category.confluence]]
