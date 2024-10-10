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
kubectl rollout restart deployment grafana-deployment -n monitoring




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