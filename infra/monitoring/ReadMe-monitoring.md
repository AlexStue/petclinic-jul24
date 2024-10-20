
# ReadMe of Monitoring

kubectl apply -f grfa-ConfigMap.yml
kubectl get pods -n monitoring

kubectl rollout restart deployment grafana-deployment -n monitoring

stress --cpu 2 --timeout 60s

