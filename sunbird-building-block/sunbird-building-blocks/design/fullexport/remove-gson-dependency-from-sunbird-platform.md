# Remove-GSON-dependency-from-Sunbird-Platform

**Overview** Remove GSON dependency from Sunbird Platform. Instead, use Jackson which is used at several places already within Sunbird. The main motivation for this task is to minimize the dependency between Sunbird and Open Saber Client (which uses gson and resulted in exceptions during integration).

**Approach** : Remove dependency of **Gson** ,from each project in Sunbird-Platform , Do code changes required to make functionality exactly same to the previous code written using Gson. Using Jackson will be best Option for doing this, as we are already using Jackson in several places.

**Changes Done :**

**(1) Sunbird-Utils :**

**actor-core/pom.xml :** removed dependency \*\*.  \*\*

**common-util/pom.xml :** removed dependency.

**common-util/src/main/java/org/sunbird/services/sso/impl/KeyCloakRsaKeyFetcher.java** : code changes.

**common-util/src/test/java/org/sunbird/services/sso/impl/KeyCloakRsaKeyFetcherTest.java** : code changes to accommodate the above file changes.( **KeyCloakRsaKeyFetcher.java** )

**common-util/src/main/java/org/sunbird/telemetry/util/SunbirdTelemetryEventConsumer.java** : code changes.

**sunbird-notification/pom.xml :** added Jackson and removed Gson dependency.

**sunbird-notification/src/main/java/org/sunbird/notification/utils/JsonUtil.java** : code changes

**sunbird-notification/src/main/java/org/sunbird/notification/sms/providerimpl/Msg91SmsProvider.java :** code changes to accommodate the above file changes.( **JsonUtil.java** )

**(2)** **Sunbird-lms-mw :**

**actors/badge/src/main/java/org/sunbird/badge/util/BadgingUtil.java** : code changes.

**actors/common/pom.xml** : dependency removed.

**telemetry-core/src/main/java/org/sunbird/util/lmaxdisruptor/SunbirdTelemetryEventConsumer.java** : deleted as not need and not used.

**telemetry-core/src/main/java/org/sunbird/util/lmaxdisruptor/SunbirdTelemetryEventConsumerTest.java** deleted as not need and not used.

**(3) Sunbird-lms-service :**

**service/pom.xml :** dependency removed

**LINK TO THE PULL REQUESTS :**

**sunbird-utils : https://github.com/project-sunbird/sunbird-utils/pull/366**

**sunbird-lms-mw : https://github.com/project-sunbird/sunbird-lms-mw/pull/460**

**sumbird-lms-service : https://github.com/project-sunbird/sunbird-lms-service/pull/193**

### **Code to support to remove Gson and Use Jackson** :

Following code snippets and output  will demonstrate the Changes Done in above files. Basically how old Gson code is replaced with new Jackson Code without any change in the end product.

**Snippet 1:**

```java
public class GsonToJackson {

  public static void main(String[] args) {

    ObjectMapper mapper = new ObjectMapper();
    String response = "{\"request\": { \"firstName\": \"Sso mock user\",\"phone\": \"9663933554\","
        + "  \"phoneVerified\": true,\"channel\": \"INFRA\",       \"orgExternalId\": \"intra111\","
        + "\"externalIds\":" + " [{ \"id\": \"sso_mock_user\", \"provider\": \"INFRA\",\"idType\": \"INFRA\" }] }}";

    try {
      JsonNode res = mapper.readTree(response);
      JsonNode request = res.get("request");
      if (request != null) {
        JsonNode externalIds = request.get("externalIds");
        System.out.println("Using JackSon : value of externalIds " + mapper.writeValueAsString(externalIds));
        JsonNode externalId = externalIds.get(0);
        System.out.println("Using JackSon : value of externalId " + mapper.writeValueAsString(externalId));
        System.out.println("Using JackSon : value of provider in externalId is : " + externalId.get("provider").asText());
      }
    } catch (Exception e) {
      System.out.println("Exception caught");
    }

    JsonParser parser = new JsonParser();
    JsonObject json = (JsonObject) parser.parse(response);

    Object request = json.get("request");
    if (request != null) {
      JsonObject value = (JsonObject) parser.parse(request.toString());
      JsonArray externalIds = (JsonArray) value.get("externalIds");
      System.out.println("Using Gson    : value of externalIds " + externalIds.toString());
      JsonObject externalId = (JsonObject) externalIds.get(0);
      System.out.println("Using Gson    : value of externalId " + externalId.toString());
      System.out.println("Using Gson    : value of provider in externalId is : " + externalId.get("provider").getAsString());
    }
  }
}


```

Output :

```
Using JackSon : value of externalIds [{"id":"sso_mock_user","provider":"INFRA","idType":"INFRA"}]
Using JackSon : value of externalId {"id":"sso_mock_user","provider":"INFRA","idType":"INFRA"}
Using JackSon : value of provider in externalId is : INFRA
Using Gson    : value of externalIds [{"id":"sso_mock_user","provider":"INFRA","idType":"INFRA"}]
Using Gson    : value of externalId {"id":"sso_mock_user","provider":"INFRA","idType":"INFRA"}
Using Gson    : value of provider in externalId is : INFRA
```

Snippet 2 :

```java
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.gson.JsonObject;

public class GsonToJackson_2 {

  public static void main(String[] args) throws JsonProcessingException {
    ObjectMapper mapper = new ObjectMapper();
  
    JsonObject gson = new JsonObject();
    gson.addProperty("revocation_reason", "REVOCATION_REASON");
    gson.addProperty("revocation", false);
    gson.addProperty("reason", "REASON");
    
    System.out.println("Using Gson : Object to Json String conversion :"+ gson.toString());

    JsonNode jackson = mapper.createObjectNode();
    ((ObjectNode) jackson).put("revocation_reason", "REVOCATION_REASON");
    ((ObjectNode) jackson).put("revocation", false);
    ((ObjectNode) jackson).put("reason", "REASON");

    String jjsonString = mapper.writeValueAsString(jackson);
    System.out.println("Using Jackson : Object to Json String conversion : "+ jjsonString);
  }

}



```

Output :

```
Using Gson    : Object to Json String conversion : {"revocation_reason":"REVOCATION_REASON","revocation":false,"reason":"REASON"}
Using Jackson : Object to Json String conversion : {"revocation_reason":"REVOCATION_REASON","revocation":false,"reason":"REASON"}


```

***

\[\[category.storage-team]] \[\[category.confluence]]
