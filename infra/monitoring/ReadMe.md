How Prometheus is structured:

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


ToDo´s:
- Check directories in manifests and files







#