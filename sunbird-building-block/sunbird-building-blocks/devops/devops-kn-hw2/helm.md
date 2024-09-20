# Helm

* Helm is a kubernetes native application package manager
* It allows describing the application structure through convenient helm-charts and managing it with simple commands
* Helm helps to manage Kubernetes applications
* Helm Charts help to define, install, and upgrade even the most complex Kubernetes applications
* Charts are easy to create, version, share, and publish&#x20;

### The Chart File Structure

A chart is organized as a collection of files inside of a directory.

The directory name is the name of the chart (without versioning information).

Thus, a chart describing player-service would be stored in the player-service/ directory.

Following structure depicts structure of Helm chart for a service :

```
player-service/
  Chart.yaml          # A YAML file containing information about the chart
  LICENSE             # OPTIONAL: A plain text file containing the license for the chart
  README.md           # OPTIONAL: A human-readable README file
  requirements.yaml   # OPTIONAL: A YAML file listing dependencies for the chart
  values.yaml         # The default configuration values for this chart
  charts/             # A directory containing any charts upon which this chart depends.
  templates/          # A directory of templates that, when combined with values,
                      # will generate valid Kubernetes manifest files.
  templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes
```

![Image result for helm deployment diagram](../../../../DevOps/devops-kn-hw2/images/storage)

***

\[\[category.storage-team]] \[\[category.confluence]]
