# Dashlets-Design-Doc

\| **Title** | Dashlet | | **Selector** | | | **Use Case** | Dashlets are reporting widgets that can be embedded in any contextual workflow - whether on a consumption, creation or administration screen. Any solution that needs to use dashlets can configure the dashlet with a data source, type of visualisation (bar, line, pi, table, map etc), legends, filters etc. | | **Description** | This generic component/widget will be used to render a **chart** , **table** , **dataset** , **map** or any other report type. It can make use of multiple libraries & also support building custom components with a common interface. |

## Interface Design

### Interface Diagrams

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.png>) **IBase** if the base interface providing common properties and behaviours.

**IChart** , **ITable** or any report Type interface will extend the **IBase** interface and will add it’s own properties and behaviours with respect to it’s use case.

Any Chart Component will implement **IChart** interface whereas table Components will implement **ITable** interface and will provide their own implementation of the specified properties and methods.

### Detailed Explaination of the Interfaces

#### IBase Interface

* IBase. - This is the base interface that every report Type component should implement.
* It provides the common attributes and behaviours for each dashlet component like height, width , fetching the data , initialization of the component.

```js
interface IBase <T extends object> {

    reportType: IReportType;

    readonly _defaultConfig: object; // default configurations as per the reportType

    height?: string; 
    
    width?: string;
    
    id: string;
    
    config: object; // input configuration for the dashlets component. It should be as per the report type. Refer to next sections for more details as per the report Type

    data: obejct[]; //

    state: EventEmitter<IReportState>;
    events: EventEmitter<CustomEvent>;

    initialize(config: InputParams); // Get the initialisation options used for rendering.

    reset(): void; // resets the component to initial view

    destroy(): void; // performs cleanup post the component is destroyed;

    update(config: UpdateInputParams); // updates and re renders the view

    fetchData<T>(config: IData): Promise<T[]> | Observable<T[]>;
}


/*
##########################################################################
*
*.         depenedent interfaces are as follows:-
*
##########################################################################
*/

type IReportType = "chart" | "table" | "etc"

type methodType = "GET" | "POST";

interface IApiConfig {
  body: object | null;
  headers?: {
    [header: string]: string | string[];
  };
  params?: {
    [param: string]: string | string[];
  };
  responseType?: 'arraybuffer' | 'blob' | 'json' | 'text';
  reportProgress?: boolean;
  response: {
    path: string;
  };
  [key: string]: any
}

interface IDataSchema {
    type: string,
    enum?: string[],
    default?: string,
    format?: string; //url, date etc
    items?: IDataSchema // if type is array
}

interface IData {
  values?: unknown[];
  location?: {
    options?: Partial<IApiConfig>;
    url?: string;
    method?: string;
  },
  dataSchema?: {
    [key: string]: IDataSchema;
  }
}

type IReportState = "initialized" | "rendered" | "destroyed" | "etc";  // pending or done state;

interface EventEmitter<T>{
    emit(value? : T);
    subscribe(next?: (value: T) => void, error?: (error: any) => void, complete?: () => void): Subscription;
}

type InputParams = {
  type: string;
  config: object;
  data: IData
}

type UpdateInputParams = {
  type: string;
  config: object;
  data: object[]
}

```

#### IChart Interface - Base Interface for Chart Components. \<ReportType = Chart>

* This is the interface that every chart component should implement and extends the IBase interface
* **config** takes the required metadata to render a chart like label datasets/series, tooltips legend, title, axes detailes etc. **Please refer to the below image to know most commonly used chart concepts** . Interface also allows additional metadata if required.
* **labelExpr** - refers to the column name or key in the JSON which can be used as x axis labels
* **dataExpr** - refers to the key in the JSON to be used on y axis as dataset.

![](<../../../../Design/FullExport/images/storage/Screenshot 2021-03-19 at 12.06.51 PM.png>)

```

interface IChart extends IBase {
    
    readonly reportType: IReportType = "chart"
  
    readonly _defaultConfig: IChartConfig; // default config for tooltips colors legend etc.
    
    type: IChartType;

    config: IChartOptions; 

    chartClick: EventEmitter<any>;
    chartHover: EventEmitter<any>;

    builder(config); // (prepares / converts) input chart config as per the underlying chart library used.
    
    update(input: Partial<UpdateInputParams>);
    
    refreshChart(); // refreshes and updates the chart either at specific interval or explicitly triggerd

    addData({ label, data, config }); //appends the label and data at the end;

    removeData(); //pops the last data and label
    removeData(label: string) // removes a specific label

    getTelemetry();

    // mergeData(data1, data2, ...dataN): any[];

    getCurrentSelection(); 
    
    exportAs(format: string);
    
    getDatasetAtIndex(index: number);
}

/*
##########################################################################
*
*.         depenedent interfaces are as follows:-
*
##########################################################################
*/


type IChartType = "bar" | "line" | "pie" | "etc";

type IChartOptions = {
    labels? : string[], // if labels are passed explicitely
    labelExpr ? : string; // column name to use as x-axis labels;
    datasets: IDataset[]; // datasets - y axis data
    tooltip?: object;
    legend?: object
    animation?: object;
    colors?: object;
    title?: string | object;
    description?: string;
    subtitle?: string;
    caption?: object;
    filters?: IFilterConfig;
    scales?: {
        axes: any;
        [key: string]: any;
    };
    [key: string]: any;
};

type IDataset  = {
    label: string;
    dataExpr?: string;
    data: any[];
}
```

#### ITable Interface - Base Interface for Table Components. \<ReportType = Table>

* This interface is implemented by every table report type and extends the IBase Interface.

```

interface ITable extends IBase {

    readonly reportType: IReportType = "table"

    readonly _defaultConfiguration: ITableConfig;

    config: ITableConfig;

    getRowsCount(); // rows count
    getRowAtIndex(index: number);   //get row at index number
    rowSelector(selectors); //fetch first row matching the config
    rowSelectorAll(selectors); // fetch rows matching a config

    addRow(data: object); // add a new row to the table by passing row configuration
    removeRow(index?: string); //removes row from the end or  at specific index;
    addColumn(config: ITableConfiguration); // adds a new column at the end
    removeColumn(columnName: string); // removes a column

    rowClick: EventEmitter<any>; // row click  event emitter
    rowHover: EventEmitter<any>; // mouse over event emitter

    exportTable(exportType: string); // exports the table into a type
    sortTable(sortByColumnName: string, orderBy: "asc" | "desc");
}


/*
##########################################################################
*
*.         depenedent interfaces are as follows:-
*
##########################################################################
*/

interface ITableConfig {
  paging: boolean; // to show pagination below the table
  info: boolean; // to show count or other info below the table
  [otherTableLevelConfig: string]: any;
  columnConfig: {
      title?: string;    // header name for the column
      searchable?: boolean; // if the column is searchable or not - will be used by the search bar at the top
      orderable?: boolean;  // if the column can be ordered or sorted in asecending or descending fashion
      data?: string;  // key in the input JSON to be used as column
      visible?: boolean; // hides or shows a column within a table
      render?: () => any;  // method to override the view and customise it like showing a button or chip instead of normal text
      autoWidth?: boolean;
      widthSize?: string; // customised width either in percentage or fixed width
      [key: string]: any; //any other metadata
      }
}
```

#### How To Pass Data Into The Component

There are 3 ways to pass data into the Components

1. pass JSON directly into the component
2. use a url to point to fetch the JSON file
3. pass API config into the component

\*\*\*\* The property implements the IData interface\*\*

```
data: IData;
```

```json
interface IData <T extends object> {
    values?: T[];
    location: {
        apiConfig?: IApiConfig;
        url?: string;
    };
    dataSchema?: {
        [key: string]: IDataSchema;
    }
}
```

```
interface IApiConfig {
    url: string;
    headers: {
        [header: string]: string | string[];
    };
    methodType: methodType;
    params: {
        [param: string]: string | string[];
    };
    response: {
        path: string;  //Gets the value at path of response object;
    }
}
```

```
interface interface IDataSchema {
    type: string,
    enum?: string[],
    default?: string,
    format?: string; //url, date etc
    items?: IDataSchema // if type is array
}
```

| **Attribute Name**      | **Description**                                                                                                                                                                                                                    |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| values: Array           | if JSON needs to be passed directly Ex- \[{"":"", "":""}]                                                                                                                                                                          |
| apiConfig: IApiConfig   | This property is used to pass API configuration like url, headers, params, methodType etc to the component. Component will fetch the response and \<reponse.path> is used to get the JSON value at the path of the response object |
| url: string             | Url to point to the JSON file if apiConfig isn’t specified                                                                                                                                                                         |
| dataSchema: IDataSchema | data schema can also be passed for the component for validation purposes.                                                                                                                                                          |

#### Filters Config and Component Design

This component and interface it to make a generic filter which will serve all for all the reportTypes.

This will also handle nested filters implementation or heirarchical filters implementation.

```js
abstract class Filter<T> {

    data: T[];

    config: IFilterConfig[];

    filteredDataEventEmitter: EventEmitter<T[]>

    abstract init(config: IFilterConfig); //Get the initialisation options to render the filters;

    abstract filterData(data: T, config): object[];
}


interface IFilterConfig {
    reference: string;
    label: string;
    placeholder: string;
    controlType: "single-select" | "multi-select" | "date";
    searchable?: boolean;
    filters: IFilterConfig[];
    default?: string;
}

/* Questions

    Nested Filter Capability..

*/
```

## Implemenation Approach

### Dashlet Main Component Proposed Structure

**Selector** - sb-dashlet

**Description -** This is the main component will exposes certain Input properties and events Handlers to the end user to render a. certain chart or table.

Attributes -

| **Property**    | **Description**                                                      |
| --------------- | -------------------------------------------------------------------- |
| type            | chartType like bar, line, pie etc                                    |
| config          | config JSON as per the interfaces mentioned in the previous sections |
| data            | pass data as per IData interface mentioned in the previous Section   |
| id              | unique id. If not passed a uuid is assigned by the component         |
| height or Width | If not passed 100% is assumed                                        |
| events          | certain event listeners exposed by the component                     |

```html
<sb-dashlet [type]="string" [config]="config" [data]="data | IDataLocation" [id?]="string | uuid" (events)="eventListener($event)">

</sb-dashlet>
```

## Examples Of Using this component

\*\* Please Note that for the next couple of examples we’ll be be passing data/JSON directly into the component.

The data will be as follows and has metrics for Tamil Nadu state Unique Devices Count :-

```json
let data =  [
        {
            "District": "Ariyalur",
            "Unique Devices on app": "6443.0",
            "Unique Devices on portal": "1332.0"
        },
        {
            "District": "Chennai",
            "Unique Devices on app": "81222.0",
            "Unique Devices on portal": "12349.0"
        },
        {
            "District": "Coimbatore",
            "Unique Devices on app": "49100.0",
            "Unique Devices on portal": "5690.0"
        },
        {
            "District": "Cuddalore",
            "Unique Devices on app": "4330.0",
            "Unique Devices on portal": "6524.0"
        },
        {
            "District": "Dharmapuri",
            "Unique Devices on app": "7133.0",
            "Unique Devices on portal": "8236.0"
        }
    ]

```

### Example of a Line Chart using the Component

Brief Description:- In this chart we’ll plot District on the x-axis and Unique Devices on app & Unique Devices on portal keys on the y-axis from the above dataset.

Chart with Config is as follows:-

![](<../../../../Design/FullExport/images/storage/Screenshot 2021-03-24 at 4.59.59 PM.png>)

```html
<sb-dashlet [type]="'line'" [data]="data" [config]="config" (chartClick)="chartClickHandler($event)" (chartHover)="chartHoverHandler($event)"></sb-dashlet>
```

```js
let config: IChartConfig = {
    "title": {
        "text": "Unique Count on App and Portal",
        "display": true,
        "fontSize": 16
    },
    "legend": {
        "display": true
    },
    "tooltips": {
        "bodySpacing": 5,
        "titleSpacing": 5
    },
    "responsive": true,
    "colors": [
        {
            "backgroundColor": "rgba(148,159,177,0.2)",
            "borderColor": "rgba(148,159,177,1)",
            "pointBackgroundColor": "rgba(148,159,177,1)"
        }
    ],
    "datasets": [
        {
            "label": "Total unique plays on App",
            "dataExpr": "Unique Devices on app"
        },
        {
            "label": "Total unique plays on Portal",
            "dataExpr": "Unique Devices on portal" 
        }
    ],
    "labelsExpr": "District"
}
```

More Information :-

**labelExpr** - key in the JSON which will act as x-axis labels.

**dataExpr** - key in the JSON which will act as y-axis dataset/Series

### Map Using Dashlet Component

Brief Description :- We’ll plot the districts and corresponding info on the Tamil Nadu state map.

Same can be extended to show complete India Map as well with different states information

![](<../../../../Design/FullExport/images/storage/Screenshot 2021-03-24 at 5.01.27 PM.png>)

```html
<sb-dashlet [type]="'map'" [data]="data" [config]="config" (featureClicked)="eventListener($event)">
</sb-dashlet>

<script>

    let config = {
        state: 'Tamil Nadu',
        districts: ['Ariyalur', 'Chennai', 'Coimbatore', 'Cuddalore', 'Dharmapuri'],
        metrics: ['Unique Devices on app', Unique Devices on portal],
        title: 'Tamil Nadu Weekly Usage'
        // country: 'India', // Optional - to show india map with states
        // states: ['Karnataka'], // Optional - list of states to show on the map
        // other Options 
    }


  // default config can be overridden with new configurations...

    let otherOptions = {
        initialCoordinate: [20, 78],
        latBounds: [6.4626999, 68.1097],
        lonBounds: [35.513327, 97.39535869999999],
        initialZoomLevel: 5,
        controlTitle: 'Tamil Nadu Weekly Usage',
        tileLayer: {
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            options: {
                attributions: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }
        },
        rootStyle: {
            fillColor: '#007cbe'
        },
        otherOptions: any
    };
</script>
```

Other Examples of using India map are as follows:-

\| ![](<../../../../Design/FullExport/images/storage/Screenshot 2020-10-01 at 4.57.04 PM.png>) | ![](<../../../../Design/FullExport/images/storage/Screenshot 2021-01-26 at 2.31.53 PM.png>) |

### Table Example using Dashlet Component

This Example will plot the same datasource in Table format as shown in the image below

![](<../../../../Design/FullExport/images/storage/Screenshot 2021-03-24 at 5.24.53 PM.png>)

```html
<sb-dashlet type="'table'" [data]="data" [config]="config" (rowClickHandler)="eventListener($click)"> 
</sb-dashlet>

<script>

    let columnsConfiguration = {
          ...globalTableConfig, //optional to override certain config
          columnConfig: [
              { title: "District", data: "District" },
              { title: "Unique App Count", data: "Unique},
              { title: "Unique Portal Count", data: "Unique Devices on portal", searchable: true, orderable: true, autoWidth: true, visible: true },
          ]
    }

</script>
```

## Notes

* If there are more charts in a single report, then each graph should be lazy-loaded to improve page performance.
* client-side caching for the datasets.

***

\[\[category.storage-team]] \[\[category.confluence]]
