aktuell:
https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

https://github.com/techiescamp/kubernetes-prometheus.git

1. access to metrics from Nodes, Pods, Deployments, etc:
    - pmth-ClusterRole.yml
        - ClusterRole
        - ClusterRoleBinding
    - kubectl apply -f pmth-ClusterRole.yml

2. prometheus config:
    - pmth-svr-ConfigMap.yml
        - pmth-svr-Rules.yml
        - pmth-svr-Scrape.yml
        - pmth-svr-Alert.yml (missing)
    - kubectl apply -f pmth-svr-ConfigMap.yml

3. prometheus server:
    - pmth-svr-comb.yml
        - pvc missing
        - Exposing Prometheus as NodePort: 30000
    - kubectl apply  -f pmth-svr-comb.yml

4.  NodeExporter incl kube-state-metrics as daemonset:
    - pmth-exp-NodeExporter.yml
        - https://github.com/bibinwilson/kubernetes-node-exporter.git
        - is 1. then still needed?
    - kubectl apply  -f pmth-NodeExporter.yml 



5. ToDo





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