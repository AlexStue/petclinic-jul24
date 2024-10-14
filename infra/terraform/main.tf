provider "local" {}

#-----------------------------------------------------------------
# Install k3s
resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Provisioning local Ubuntu machine"
      sudo apt-get update
      sudo apt-get install -y curl
      curl -sfL https://get.k3s.io | sh -
      mkdir -p ~/.kube
      sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
      sudo chown $USER:$USER ~/.kube/config
      sudo chmod 644 ~/.kube/config
      sudo chmod 644 /etc/rancher/k3s/k3s.yaml
    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

#-----------------------------------------------------------------
# Deploy k3s namespace DEV
resource "null_resource" "apply_k3s_manifests" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Creating Kubernetes dev"
      #export KUBECONFIG=~/.kube/config
      kubectl create namespace dev || echo "Namespace 'dev' already exists"
      echo "Applying Kubernetes deployments" | tee -a /tmp/kubectl-apply.log
      
      ### Configs ###

      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/grfa-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/ingress-secret.yml | tee -a /tmp/kubectl-apply.log

      ### Deployments ###

      kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/petclinic-comb.yml | tee -a /tmp/kubectl-apply.log

      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-ClusterRole.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-exp-NodeExporter.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-svr-comb.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-almg-comb.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-grfa-comb.yml | tee -a /tmp/kubectl-apply.log

      kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/infra/k3s/4-ingress-monitoring/ingress-traefik.yml | tee -a /tmp/kubectl-apply.log

      ### restarts ###

      #kubectl rollout restart deployment mysqlserver-deployment -n dev
      #kubectl rollout restart deployment petclinic-deployment -n dev
      #kubectl rollout restart deployment prometheus-deployment -n dev
      #kubectl rollout restart deployment alertmanager-deployment -n dev
      #kubectl rollout restart deployment grafana-deployment -n dev

    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [null_resource.k3s_setup]
}
