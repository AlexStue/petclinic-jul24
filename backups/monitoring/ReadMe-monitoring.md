
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

---

kubectl apply -f grfa-ConfigMap.yml
kubectl get pods -n monitoring

kubectl rollout restart deployment grafana-deployment -n monitoring

stress --cpu 2 --timeout 10s

kubectl top nodes
kubectl top pods -n monitoring

kubectl top nodes
kubectl top pods -n monitoring
kubectl describe node localhost







#