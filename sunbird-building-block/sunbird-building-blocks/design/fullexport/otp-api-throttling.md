# OTP-API-Throttling

**Overview** We need to restrict number of OTP message generated for particular e-mail or mobile.

Purpose is simply to avoid misuse through

**Approach 1** Create one table, otp\_throttling with columns (type, key, count)

Each time generate OTP is called:

* Check if user exists → throw exception - user already exists with Mobile/Email.
* Check if there is an entry with same type, userkey in the table
* if no entry, then add entry with TTL as per configuration.
* if entry is found then, check if threshold is already reached.
* if threshold is reached → Generate error with message, that user has reached max OTP generation, and is blocked for 24 hours.
* If threshold is not reached → increment the counter as well as ttl, and proceed to OTP generation.

**Pros:**

* Easy to implement and clean solution, as both data are for seperate purpose
* We can use ttl at table level for both tables, and row will get deleted automatically.

**Cons:**

* Additional data storage.

**Approach 2** It is same as approach 1, except existing OTP table should be used.

**Pros:**

* No additional table will be required

**Cons:**

* Both data will be stored in same table.
* Need to use  TTL at column level

**Open Questions**

* 5 OTP in 24 hours limit is from first generation of otp or from last usage. i.e. say first generation was done at 09:00 AM → till 09:00 AM next morning - user cannot generate more than 5 OTP, or each time OTP is generated we update the timestamp, say 5th otp was generated at 05:00PM - then user cannot generate OTP till 05:00 PM next day.

***

\[\[category.storage-team]] \[\[category.confluence]]
