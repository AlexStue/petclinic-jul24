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
      kubectl create namespace dev
      echo "Applying Kubernetes deployment"
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/1-basic-way/petclinic-combined.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/1-basic-way/nginx-combined.yml
      
      kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/nginx-comb-v2.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/ingress-comb-v2.yml
    EOT
  }
  depends_on = [null_resource.k3s_setup]
}
