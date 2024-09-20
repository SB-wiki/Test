How to change proxy config dynamically without disrupting traffic


```
// Edit the configmap to add change
kubectl edit cm -n {{namespace}} proxy-default

// Wait for some time to check whether all proxies got the change
// For example, If I'm adding a proxy_set_header MyHeader SuperHeader;
// Below command will check for the string 'MyHeader' in proxy-default.conf in all container.
// Once you got success message from all container, that means the change successfully propagated
// to all containers
kubectl get po -l app=nginx-public-ingress | tail -n +2  | awk '{print $1}' | xargs -I{} kubectl exec {} -- /bin/sh -c "grep -i MyHeader /etc/nginx/defaults.d/proxy-default.conf "

// Reload Nginx containers
kubectl get po -l app=nginx-public-ingress | awk '{print $1}' | tail -n +2 | xargs -I{} kubectl exec {} -- nginx -s reload

```




*****

[[category.storage-team]] 
[[category.confluence]] 
