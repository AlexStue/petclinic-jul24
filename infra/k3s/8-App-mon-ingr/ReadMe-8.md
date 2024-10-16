
###

http://85.215.98.243:30000
http://85.215.98.243:31000
http://85.215.98.243:32000

https://petclinic-dev.simply-stu.de

###

sudo mv /home/ubuntu/petclinic-jul24/SSL.zip /home/ubuntu/
sudo mv *.simply-stu.de_private_key.key .simply-stu.de_private_key.key

###

stress --cpu 2 --timeout 60

###

cd
sudo rm -r petclinic-jul24
kubectl delete namespace dev
kubectl create namespace dev
#
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
#
cd
kubectl create secret tls petclinic-tls --cert=simply-stu.de_ssl_certificate.cer --key=.simply-stu.de_private_key.key --namespace=dev
#
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/app-combined.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/ingress-resource.yml
#
# insert WebHook URL https://api.slack.com/apps/A07S01W6P1S/install-on-team?
sudo nano /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/grfa-ConfigMap.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/mon-pmth-ClusterRole.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/mon-pmth-exp-NodeExporter.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/mon-pmth-svr-comb.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/mon-pmth-almg-comb.yml
kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/8-App-mon-ingr/mon-grfa-comb.yml
#
kubectl get pods -n dev

###














#