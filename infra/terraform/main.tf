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
resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Creating Kubernetes dev"
      #export KUBECONFIG=~/.kube/config
      kubectl create namespace dev || echo "Namespace 'dev' already exists"
      kubectl create namespace monitoring || echo "Namespace 'dev' already exists"
      echo "Applying Kubernetes deployment" | tee -a /tmp/kubectl-apply.log
      
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/1-basic-way/petclinic-combined.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/1-basic-way/nginx-combined.yml
      
      # kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/nginx-comb.yml | tee -a /tmp/kubectl-apply.log
      # kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/ingress-comb.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-ClusterRole.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-exp-NodeExporter.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/grfa-ConfigMap.yml | tee -a /tmp/kubectl-apply.log
      kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-comb.yml | tee -a /tmp/kubectl-apply.log
      # kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-comb.yml | tee -a /tmp/kubectl-apply.log
      # kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/grfa-comb.yml | tee -a /tmp/kubectl-apply.log

      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/tls-secret.yml | tee -a /tmp/kubectl-apply.log
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/ingress-traefik.yml | tee -a /tmp/kubectl-apply.log

    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [null_resource.k3s_setup]
}
