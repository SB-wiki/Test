Adding the Dockerfile used to build the custom prometheus image with azcopy on ubuntu for reference


```
FROM quay.io/prometheus/prometheus:v2.17.2

FROM ubuntu:latest
RUN apt-get update && apt-get install -y wget vim curl && wget https://aka.ms/downloadazcopy-v10-linux -O /tmp/downloadazcopy-v10-linux && tar -xf /tmp/downloadazcopy-v10-linux && mv azcopy_linux_amd64_10.16.1/azcopy /bin/ && chmod ugo+x /bin/azcopy
COPY --from=0 /prometheus /prometheus
COPY --from=0 /bin/prometheus /bin/prometheus
COPY --from=0 /etc/prometheus /etc/prometheus
COPY --from=0 /bin/promtool /bin/promtool
COPY --from=0 /usr/share/prometheus /usr/share/prometheus
RUN ln -f -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/
WORKDIR /prometheus
USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]] ]></ac:plain-text-body></ac:structured-macro><p /><p><strong>Prometheus PV Backup and Restore</strong></p><p>On first cluster run the following (cluster where we need to take the backup) </p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="72f08ea2-6c4b-4c42-ae54-7eebaf0a8153"><ac:plain-text-body><![CDATA[kubectl -n monitoring get prometheus
kubectl -n monitoring patch prometheus sunbird-monitoring-prometheus --type merge --patch '{"spec":{"enableAdminAPI":true}}'
kubectl -n monitoring get sts prometheus-sunbird-monitoring-prometheus -o yaml | grep admin
kubectl port-forward -n monitoring prometheus-sunbird-monitoring-prometheus-0 9090:9090
snapshot=$(curl -XPOST http://localhost:9090/api/v2/admin/tsdb/snapshot)
snapshot_dir=$(echo $snapshot | jq -r .data.name)
kubectl exec -it -n monitoring prometheus-sunbird-monitoring-prometheus-0 -c prometheus -- du -shx /prometheus/snapshots/$snapshot_dir
kubectl scale deployment -n monitoring sunbird-monitoring-operator --replicas=0
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "keshavprasad/prometheus-ubuntu:0.0.4"}]'
kubectl get pod -n monitoring prometheus-sunbird-monitoring-prometheus-0 --watch
kubectl exec -it -n monitoring prometheus-sunbird-monitoring-prometheus-0 -c prometheus -- bash -c "HOME=/tmp azcopy cp /prometheus/snapshots/$snapshot_dir 'https://STORAGE_ACCOUNT_URL/prometheus?SAS_TOKEN' --recursive=true"
kubectl scale deployment -n monitoring sunbird-monitoring-operator --replicas=1
```


On second cluster run the following (cluster where we need to restore the backup)


```
kubectl scale deployment -n monitoring sunbird-monitoring-operator --replicas=0
kubectl scale statefulset -n monitoring prometheus-sunbird-monitoring-prometheus --replicas=0
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/3"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/2"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/1"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/0/readinessProbe"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "remove", "path": "/spec/template/spec/containers/0/args"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["sleep", "infinity"]}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "keshavprasad/prometheus-ubuntu:0.0.4"}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "replace", "path": "/spec/template/spec/securityContext/runAsNonRoot", "value": false}]'
kubectl patch statefulsets.apps -n monitoring prometheus-sunbird-monitoring-prometheus --type=json -p '[{"op": "replace", "path": "/spec/template/spec/securityContext/runAsUser", "value": 0}]'
kubectl scale statefulset -n monitoring prometheus-sunbird-monitoring-prometheus --replicas=1
kubectl get pod -n monitoring prometheus-sunbird-monitoring-prometheus-0 --watch
kubectl exec -it -n monitoring prometheus-sunbird-monitoring-prometheus-0 -c prometheus -- bash -c "rm -rf /prometheus/*"
kubectl exec -it -n monitoring prometheus-sunbird-monitoring-prometheus-0 -c prometheus -- bash -c "azcopy cp 'https://STORAGE_ACCOUNT_URL/prometheus/$snapshot_dir/*?SAS_TOKEN' /prometheus --recursive=true"
kubectl scale deployment -n monitoring sunbird-monitoring-operator --replicas=1
```


 **Addition information (for knowledge / debugging purpose only)** 

To manually start prometheus, use the below command (ensure you create the prometheus.env.yaml file in /tmp directory by copying from old pod)


```
/bin/prometheus --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries --config.file=/tmp/prometheus.env.yaml --storage.tsdb.path=/prometheus --storage.tsdb.retention.time=90d --web.enable-lifecycle --storage.tsdb.no-lockfile --web.enable-admin-api --web.external-url=http://sunbird-monitoring-prometheus.monitoring:9090 --web.route-prefix=/
```




*****

[[category.storage-team]] 
[[category.confluence]] 
