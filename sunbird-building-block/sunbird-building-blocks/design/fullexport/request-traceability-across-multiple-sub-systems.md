# Request-traceability-across-multiple-sub-systems

* [Introduction:](request-traceability-across-multiple-sub-systems.md#introduction:)
* [Background:](request-traceability-across-multiple-sub-systems.md#background:)
* [Problem Statement:](request-traceability-across-multiple-sub-systems.md#problem-statement:)
* [Key design problems:](request-traceability-across-multiple-sub-systems.md#key-design-problems:)
* [Solution 1:](request-traceability-across-multiple-sub-systems.md#solution-1:)
  * [Pros:](request-traceability-across-multiple-sub-systems.md#pros:)
  * [Cons:](request-traceability-across-multiple-sub-systems.md#cons:)
* [Solution 2:](request-traceability-across-multiple-sub-systems.md#solution-2:)
  * [font-end implementation:](request-traceability-across-multiple-sub-systems.md#font-end-implementation:)
* [Solution 3:](request-traceability-across-multiple-sub-systems.md#solution-3:)
* [Related articles](request-traceability-across-multiple-sub-systems.md#related-articles)

### Introduction:

This document describes how to trace/map the request across multiple sub-systems involved in process of serving/showing the details.

### Background:

Jira Issue [https://project-sunbird.atlassian.net/browse/SB-17028](https://project-sunbird.atlassian.net/browse/SB-17028)

### Problem Statement:

1. How to analyze the time spent to serve the request?
2. How to analyze in which sub-system request is failing in the workflow?

### Key design problems:

1. How to associate/relate the request across multiple sub-systems?

**Workflow of QR-Code scan:** ![](<../../../../Design/FullExport/images/storage/Request Tracebility.jpg>)

### Solution 1:

Use existing telemetry events

```
{
  ...
  "cdata": [
    ...
    { 
      "type": "Trace"
      "id": "2d4fd89a-5ed9-44ed-8efd-9fabedbe0f03" //UUID
    }
  ],
  ...
}
```

or

```
{
  ...
  "eid": "IMPRESSION"
  "traceid": "2d4fd89a-5ed9-44ed-8efd-9fabedbe0f03" //UUID
  ...
}
```

#### Pros:

1. Easy to implement, because each sub-system is already logging the telemetry events
2. With minimal efforts, we achieve visualization in Druid/Superset

#### Cons:

1. The timestamp should be the same from all sub-systems ([epoch time](https://www.epochconverter.com/))
2. The finding of origin/root module of the trace depends on timestamp only. If any mismatch will lose the data.
3. Can’t send additional information required for request trace
4. Chances of losing traceability if any sub-system is failed to send trace unique id
5. Code change may impact on the existing traceability
6. Defining workflows, where the trace is going to end.

### Solution 2:

Define a new telemetry event for trace information(similar to the LOG telemetry event). This is because along with traceID we should able to log additional information to track the request.

Trace object should contain( **Span object should be similar to OpenTracing spec** )

```
"edata": {
  "id": {UUID}, // TraceId. Common for all sub-systems(this is to track entire workflow front-end to back-end)
  "name": "qr-scan" // service/module name to identify
  "span" {
     "traceID": {UUID},
     "operationName": {string}  //ex: "qr-scan" for the qr scan workflow. Use some unique string for each workflow/span
     "spanID": {worflowId}, // UniqueId for this workflow. Always same for multiple scans
     "parentSpanId": {span.id} // Optional: This is to track who is the parent of the request. Helps to create the tree structure of the trace
     "context": [{ "type":"", "key":"", "value":""}] // Context of the workflow, ex: "dialcode": "4XJG3F" on scan of this dial code workflow started
     "tags": [{"key":"", "type":"", "value":""}]  // https://github.com/opentracing/specification/blob/master/semantic_conventions.md#span-tags-table
   }  
}
```

**OpenTracing API “SPAN“ spec:**

```
{
  "traceID": "73abf3be4c32c2b8",
  "spanID": "73abf3be4c32c2b8",
  "flags": 1,
  "operationName": "operation",
  "references": [],
  "startTime": 1531757144093000,
  "duration": 9888,
  "parentSpanId": 0,
  "tags": [
    {
      "key": "sampler.type",
      "type": "string",
      "value": "const"
    },
    {
      "key": "sampler.param",
      "type": "bool",
      "value": true
    }
  ],
  "logs": [],
  "processID": "p1",
  "warnings": null
}
```

Use [OpenTracing](https://opentracing.io/docs/overview/what-is-tracing/) API to generate [Trace](https://opentracing.io/docs/overview/tracers/) & [Span](https://opentracing.io/docs/overview/spans/) objects. Jenkins & Jaeger have built on top of these API’s.

Sample Data to Analyze: [https://docs.google.com/spreadsheets/d/1v96dZ0m21OVHswfZU84frOcymYd1kVqD7SqYLCyguFE/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1v96dZ0m21OVHswfZU84frOcymYd1kVqD7SqYLCyguFE/edit?usp=sharing)

#### font-end implementation:

Use Javascript NPM module for front-end:

[https://github.com/opentracing/opentracing-javascript](https://github.com/opentracing/opentracing-javascript)

```
npm install --save opentracing
```

The singleton service/module which can hold only 1 trace workflow at any time. Angular components will use the below service to start & end the trace by sending action/workflow name. The trace can contain multiple span objects(which will be an enhancement of the below single-span implementation).

```

import { Injectable, Optional, OnDestroy } from '@angular/core';
import * as opentracing from 'opentracing';

export class TraceServiceConfig {
    action = 'qr-scan';
  }

@Injectable({
    providedIn: 'root'
})


export class TraceService {
    /**
	 * Single trace object for the action
     * Only 1 trace object created for 1 workflow. 
     * Any new worflow starts, end the current trace & create the new trace
	*/
    private _tracer:opentracing.Tracer;

    /**
	 * Span object for specific action. 
     * One trace can have multiple span objects
	*/
    private _span:opentracing.Span;

    constructor() {
        console.log('TraceService instance created.');    
    }

    /**
	 * Start new trace
	*/
    public startTrace(action) {
        if(action) {
            this._tracer = new opentracing.Tracer();
            this._span = this._tracer.startSpan(action);
            console.log("==> Trace Start", this._tracer);
        }
    }

    /**
	 * Start new span
	*/
    public startSpan(action) {
        if(this._span) {
            this._span.finish();
        }
        this._span = this._tracer.startSpan(action);
    }

    /**
	 * End span
	*/
    public endTrace() {
        this._span.finish();
        console.log("==> Trace End", this._tracer);
    }

    get trace() {
        return this._tracer;
    }

    get span() {
        return this._span;
    }
}

```

When the user scans/search with dial-code call **TraceService.startTrace('qr-scan')** method from the respective angular component. This will starts the new trace object.

```
TraceService.startTrace('qr-scan')
```

After getting the response from API, call the below method to end the trace.

```
TraceService.endTrace()
```

Use the decorator design pattern to add trace information in the requests. Call the

![](<../../../../Design/FullExport/images/storage/Screenshot from 2020-02-11 11-26-42.png>)Back-end implementation:refer: Best practices of open-tracing back-end implementation [https://opentracing.io/docs/best-practices/](https://opentracing.io/docs/best-practices/)

Any API is called from front-end pass the below details in the request headers.

OpenTacing API implementation in JAVA

[https://github.com/opentracing/opentracing-java](https://github.com/opentracing/opentracing-java)

```
"traceId": { UUID }
"name": "qr-code" // for QR code scane. Name of the workflow to trace. 
"context": [{ "type": "key", "value":""}]] ]></ac:plain-text-body></ac:structured-macro><h4>Tracing Server Endpoints</h4><p>When a server wants to trace execution of a request, it generally needs to go through these steps:</p><ol><li><p>Attempt to extract a SpanContext that’s been propagated alongside the incoming request (in case the trace has already been started by the client), or start a new trace if no such propagated SpanContext could be found.</p></li><li><p>Store the newly created Span in some <em>request context</em> that is propagated throughout the application, either by application code, or by the RPC framework.</p></li><li><p>Finally, close the Span using <code>span.finish()</code> when the server has finished processing the request.</p></li></ol><h4>Extracting a SpanContext from an Incoming Request</h4><p>Let’s assume that we have an HTTP server, and the SpanContext is propagated from the client via HTTP headers, accessible via <code>request.headers</code>:</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="30544aa0-8836-45e1-a610-e9fa7795082b"><ac:plain-text-body><![CDATA[extracted_context = tracer.extract(
    format=opentracing.HTTP_HEADER_FORMAT,
    carrier=request.headers
)
```

Here we use the headers map as the carrier. The Tracer object knows which headers it needs to read in order to reconstruct the tracer state and any Baggage.

Pros:

1. Can able to find the time taken on each sub-modules easily based on SpanId
2. Time spent of each sub-system will be available directly in the event itself
3. In sub-systems, we can add multiple spans
4.

Cons:

1. More efforts required compared to Solution1.
2. Multiple telemetry events will be logged for the same workflow(like impression & trace)
3.

### Solution 3:

Integrate with external distributed tracing tools like [Zipkin](https://zipkin.io/),[ Jaeger](https://www.jaegertracing.io/) etc..

**JAEGER:** Architecture diagram:

![](<../../../../Design/FullExport/images/storage/Screenshot from 2020-02-11 13-09-28.png>)

* Integration with spring application: Video- [https://www.youtube.com/watch?v=hpnLUFRY4\_Y](https://www.youtube.com/watch?v=hpnLUFRY4\_Y)
* Integration with NodeJs application: [https://blog.risingstack.com/distributed-tracing-opentracing-node-js/](https://blog.risingstack.com/distributed-tracing-opentracing-node-js/)

Pros:

1. The simple configuration code changes will handle the request traceability.
2. Jaegar UI can be used to visualize the trace events.

Cons:

1. Workflows can’t be traceable. Each API will be considered as one trace.
2. Connecting multiple applications/servers to the single jaeger instance to trace the workflow of the API has to explore.

**Reference links:**

* Opentracing specifications:

[https://github.com/opentracing/specification/blob/master/specification.md](https://github.com/opentracing/specification/blob/master/specification.md)

* Span: Opentracing definition

[https://opentracing.io/docs/overview/spans/](https://opentracing.io/docs/overview/spans/)

*   Open tracing Javascript implementation sample

    [https://github.com/opentracing/opentracing-javascript](https://github.com/opentracing/opentracing-javascript)
* Best practices:

[https://opentracing.io/docs/best-practices/](https://opentracing.io/docs/best-practices/)

* Jaeger related link

[https://github.com/open-telemetry](https://github.com/open-telemetry)

Jaeger UI setup: [https://www.scalyr.com/blog/jaeger-tracing-tutorial/](https://www.scalyr.com/blog/jaeger-tracing-tutorial/)

Jaeger Client node: [https://github.com/jaegertracing/jaeger-client-node](https://github.com/jaegertracing/jaeger-client-node)

![](<../../../../Design/FullExport/images/storage/Screenshot from 2020-02-11 13-09-11.png>) ![](<../../../../Design/FullExport/images/storage/Screenshot from 2020-02-11 13-09-28.png>)

### Related articles

\[\[Trace ability of request across subsystems|Trace-ability-of-request-across-subsystems]]

***

\[\[category.storage-team]] \[\[category.confluence]]
