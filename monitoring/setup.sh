
# install k3s
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
kubectl version
kubectl get nodes

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# installing kube-prometheus-stack with Helm
mkdir .kube
kubectl config view --raw >.kube/config # export kubernetes config file so helm can talk to kubernetes api
chmod 600 .kube/config
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --set grafana.service.type=NodePort --set promotheus.service.type=NodePort
kubectl get crds -n monitoring | grep monitoring
kubectl get pods -n monitoring






