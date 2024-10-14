

kubectl create namespace ingress-nginx

1. ingress-controller.yml

2. nginx-combined.yml

3. ingress-resource.yml

IP
kubectl get services -o wide -w -n ingress-nginx
---
NAME                                 TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE     SELECTOR
ingress-nginx-controller             LoadBalancer   10.43.89.162   <pending>     80:31144/TCP,443:30620/TCP   5m27s   
ingress-nginx-controller-admission   ClusterIP      10.43.32.229   <none>        443/TCP                      5m27s   
---

4. kubectl edit deployment ingress-nginx-controller -n ingress-nginx
---
spec:
  hostNetwork: true
  dnsPolicy: ClusterFirstWithHostNet
---

sudo apt-get update
sudo apt-get install -y curl
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
sudo chmod 644 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml


http://85.215.98.243:30308
http://85.215.98.243:32457
http://85.215.98.243:30100
http://85.215.98.243/web-app

















#