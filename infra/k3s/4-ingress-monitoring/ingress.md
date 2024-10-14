

kubectl create namespace ingress-nginx

1. ingress-controller.yml

2. nginx-combined.yml

3. ingress-resource.yml

IP
kubectl get services -o wide -w -n ingress-nginx

4. kubectl edit deployment ingress-nginx-controller -n ingress-nginx
---
spec:
  hostNetwork: true
  dnsPolicy: ClusterFirstWithHostNet
---


4. ingress-account.yml

5. ingress-configmap.yml

6. ingress-sercive.yml

7. ingress-class.yml


























#