




###

http://85.215.98.243:30000
http://85.215.98.243:31000

###

kubectl rollout restart deployment prometheus-deployment -n dev
kubectl rollout restart deployment alertmanager-deployment -n dev

100 - (max(irate(node_cpu_seconds_total{mode=\"idle\"}[1m])) * 100)
100 - (max(irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)

curl -X POST -H 'Content-type: application/json' --data '{"text":"Test message"}' https://hooks.slack.com/services/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


kubectl logs alertmanager-deployment-77dcc94fdb-x2xpb -n dev




















#