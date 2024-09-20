 **Problem Statement:-** 

How to record any insert/update/delete i.e.(write) operation in cassandra as an event?

 **Proposed Solution 1** 



Cassandra trigger can be used for this purpose. We need to create trigger on particular table which will write into another table for audit or write into file on any such write operations.



To create a trigger, you must first build a jar( **with all dependencies** ) with a class implementing the ITrigger and put it into the triggers directory on every node, then perform a CQL3 CREATE TRIGGER request to tie your trigger to a Cassandra table (or several tables). 

Once the trigger is set, restart the cassandra so that the new trigger is implied to the subjected table.



Source Code:-




```
public class AuditTrigger implements ITrigger
{
    //private Properties properties = loadProperties();

	@SuppressWarnings("unchecked")
    public Collection<Mutation> augment(Partition update) 
    {
        String auditKeyspace = "practice";
        String auditTable = "audit_emp";

        //TableMetadata metadata = Schema.instance.getCFMetaData(auditKeyspace, auditTable);
        CFMetaData metadata = Schema.instance.getCFMetaData(auditKeyspace, auditTable);
        PartitionUpdate.SimpleBuilder audit = PartitionUpdate.simpleBuilder(metadata, UUIDGen.getTimeUUID());
        String id = null;
        try {
        	id = new String(update.partitionKey().getKey().array(), "ASCII");
        audit.row()
             .add("keyspace_name", update.metadata().ksName)
             .add("table_name", update.metadata().cfName)
           
             .add("primary_key" , 
            		 new String(update.partitionKey().getKey().array(), "ASCII")
            		 );
    //  .add("primary_key", "emp_id");
            //.add("primary_key", update.metadata().partitionKeyType.getString(update.partitionKey().getKey()));
        }
        catch(UnsupportedEncodingException e) {
        	System.out.println("Exception Occured");
        }
        JSONObject obj = new JSONObject();
		obj.put("id", id);
		obj.put("keyspace_name", update.metadata().ksName);
		obj.put("table_name", update.metadata().cfName);
		FileWriter file = null;
		// try-with-resources statement based on post comment below :)
		try {
			file = new FileWriter("/home/sudhirgiri/triggerFile.txt") ;
			file.write(obj.toJSONString());
			System.out.println("Successfully Copied JSON Object to File...");
			System.out.println("\nJSON Object: " + obj);
			file.close();
		}catch(IOException e) {
		System.out.println("ExceptionOccured");	
		}
        return Collections.singletonList(audit.buildAsMutation());
    }
}
```


 **Questions:-** 


1. How to differentiate between Insert and update in cassandra trigger as there is no way we could distinguish during trigger creation. We can only get the recent data which is acceptable in case of insert but couldn’t retrieve the field and its values on which update operation is applied.


1. Cassandra trigger is deprecated in the version 5.4 and hence it would be futile exercise if we migrate to the latest cassandra install.





*****

[[category.storage-team]] 
[[category.confluence]] 
