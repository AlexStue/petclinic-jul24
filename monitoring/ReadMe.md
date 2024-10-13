aktuell:
https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

0. kubectl create namespace monitoring

1. access to metrics: https://github.com/techiescamp/kubernetes-prometheus.git
    - pmth-ClusterRole.yml
        - ClusterRole
        - ClusterRoleBinding
    - kubectl apply -f pmth-ClusterRole.yml

2.  NodeExporter as daemonset: https://github.com/bibinwilson/kubernetes-node-exporter.git
    - pmth-exp-NodeExporter.yml
    - kubectl apply  -f pmth-NodeExporter.yml 

3. prometheus config:
    - pmth-svr-ConfigMap.yml
    - kubectl apply -f pmth-svr-ConfigMap.yml

4. prometheus server:
    - pmth-svr-comb.yml
        - pvc missing
        - Exposing Prometheus as NodePort: 30000
    - kubectl apply  -f pmth-svr-comb.yml

5. AlertManager config: https://devopscube.com/alert-manager-kubernetes-guide/
    - pmth-almg-ConfigMap.yml
    - kubectl apply  -f pmth-almg-ConfigMap.yml

6. AlertManager server:
    - pmth-almg-comb.yml
        - exposing AlertManager as Nodeport: 31000
    - kubectl apply  -f pmth-almg-comb.yml

7. Grafana config: https://github.com/bibinwilson/kubernetes-grafana
    - grfa-ConfigMap.yml
    - kubectl apply  -f grfa-ConfigMap.yml

8. Grafana server:
    - grfa-comb.yml
        - pvc missing
        - Exposing Prometheus as NodePort: 32000
        - User: admin, Pw: admin
    - kubectl apply  -f grfa-comb.yml


99. ToDo
    - k3s deply and services to infra
    - only configs in monitoring
    - 
    - 

kubectl apply -f grfa-ConfigMap.yml
kubectl get pods -n monitoring

kubectl rollout restart deployment grafana-deployment -n monitoring

100 - (max(irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)
stress --cpu 2 --timeout 10s

kubectl top nodes
kubectl top pods -n monitoring

kubectl describe node <node-name>

-----------

kubectl top nodes
NAME        CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
localhost   209m         10%    1214Mi          62%       

kubectl top pods -n monitoring
NAME                                       CPU    req    max        MEMORY     req     max
alertmanager-deployment-5677d4d585-bj6nw   2m      10m    30m         27Mi      50Mi   100Mi  
grafana-deployment-5df86d4c7-fl6q7         4m      20m    50m        107Mi     150Mi   200Mi
node-exporter-q5nnx                        11m     20m    50m         13Mi      30Mi    50Mi
prometheus-deployment-c45b5cfd-rzm8v       65m     80m   100m        263Mi     300Mi   500Mi

kubectl describe node localhost
  Resource           Requests          Limits
  --------           --------          ------
  cpu                1502m (75%)       3250m (162%)
  memory             1884120320 (92%)  3422Mi (176%)
  ephemeral-storage  0 (0%)            0 (0%)
  hugepages-1Gi      0 (0%)            0 (0%)
  hugepages-2Mi      0 (0%)            0 (0%)

  Namespace                   Name                                        CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                        ------------  ----------  ---------------  -------------  ---
  kube-system                 coredns-7b98449c4-44ljw                     100m (5%)     0 (0%)      70Mi (3%)        170Mi (8%)     8d
  kube-system                 local-path-provisioner-6795b5f9d8-fqrq4     0 (0%)        0 (0%)      0 (0%)           0 (0%)         8d
  kube-system                 metrics-server-cdcc87586-nvxsn              100m (5%)     0 (0%)      70Mi (3%)        0 (0%)         8d
  kube-system                 svclb-traefik-3066e353-w6kpb                0 (0%)        0 (0%)      0 (0%)           0 (0%)         8d
  kube-system                 traefik-67f6c94c47-8rmb7                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         8d
  monitoring                  alertmanager-deployment-5677d4d585-bj6nw    500m (25%)    1 (50%)     500Mi (25%)      1Gi (52%)      12m
  monitoring                  grafana-deployment-5df86d4c7-fl6q7          500m (25%)    1 (50%)     500M (24%)       1Gi (52%)      12m
  monitoring                  node-exporter-q5nnx                         102m (5%)     250m (12%)  180Mi (9%)       180Mi (9%)     17h
  monitoring                  prometheus-deployment-c45b5cfd-rzm8v        200m (10%)    1 (50%)     500Mi (25%)      1Gi (52%)      17h





---------------------
alt:


How Prometheus as k8s-Operator is structured:

- rometheus: defines desired Prometheus deployments as StatefulSet
- Alertmanager: defines a desired Alertmanager deployment
- ServiceMonitor: declaratively specifies how Kubernetes service groups are to be monitored
- PodMonitor: declaratively specifies how pod groups should be monitored
- Probe: declaratively specifies how input groups or static targets are to be monitored
- PrometheusRule: defines a desired set of Prometheus alert and/or registration rules
- AlertmanagerConfig: declaratively specifies subsections of the Alertmanager configuration

- prometheus-node-exporter exposes hardware and operating system metrics
- kube-state- metrics listens to the Kubernetes API server and generates object state metrics



1. namespace xxx
2. clusterRole.yaml
    Note: In the role, given below, you can see that we have added get, list, and watch permissions to nodes, services endpoints, pods, and ingresses. The role binding is bound to the monitoring namespace. If you have any use case to retrieve metrics from any other object, you need to add that in this cluster role.
    create role:
    kubectl create -f clusterRole.yaml 

3. prometheus-configmap.yml
    - prometheus.yml
        This is the main Prometheus configuration which holds all the scrape configs, service discovery details, storage locations, data retention configs, etc
    - prometheus-rules.yml

###

old:
1. Exporter of Server (App or Database)
    - m

2. Prometheus-Server as Deployment and Service (NodePort)
    - Deployment uses ConfigMap
    - ConfigMap includes 
        - prometheus.yml: scrape_configs & job_name for prometheus and k3s-pod
        - alert.rules.yml: alerts

3. Grafana-Server as Deployment and Service (NodePort) and PVC
    - Deployment uses ConfigMap
    - Check Prometheus integration in Grafana-UI

4. AlertManager
    - 
    - 



ToDo´s:
- Check directories in manifests and files







#