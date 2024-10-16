




###

http://85.215.98.243:30000
http://85.215.98.243:31000
http://85.215.98.243:32000

###

100 - (max(irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)

stress --cpu 2 --timeout 30

###

cd
sudo rm -r petclinic-jul24
kubectl delete namespace dev
kubectl create namespace dev
REPO_URL="https://github.com/AlexStue/petclinic-jul24.git"
DIR_NAME="petclinic-jul24"
DEFAULT_BRANCH="dev-branch"

if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Pulling the latest changes from $DEFAULT_BRANCH ..."
  cd "$DIR_NAME" || exit
  sudo git pull origin "$DEFAULT_BRANCH"
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  sudo git clone --branch "$DEFAULT_BRANCH" "$REPO_URL"
fi
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-ConfigMap.yml
sudo nano /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/7-monitoring/mon-pmth-ClusterRole.yml 
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/7-monitoring/mon-pmth-exp-NodeExporter.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/7-monitoring/mon-pmth-svr-comb.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/7-monitoring/mon-pmth-almg-comb.yml
kubectl get pods -n dev

###

















#