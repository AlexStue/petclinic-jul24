




###

http://85.215.98.243:30000
http://85.215.98.243:31000

###

kubectl rollout restart deployment prometheus-deployment -n dev
kubectl rollout restart deployment alertmanager-deployment -n dev

100 - (max(irate(node_cpu_seconds_total{mode=\"idle\"}[1m])) * 100)
100 - (max(irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)

curl -X POST -H 'Content-type: application/json' --data '{"text":"Test message"}' https:


###

sudo nano /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f mon-pmth-almg-comb.yml 
kubectl rollout restart deployment alertmanager-deployment -n monitoring

###

















#