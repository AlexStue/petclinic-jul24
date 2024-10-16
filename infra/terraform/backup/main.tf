provider "local" {}

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

      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/grfa-ConfigMap.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-svr-ConfigMap.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-ConfigMap.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/monitoring/pmth-almg-templ-ConfigMap.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/ingress-secret.yml

      ### Deployments ###

      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/petclinic-comb.yml
      
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-ClusterRole.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-exp-NodeExporter.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-svr-comb.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-pmth-almg-comb.yml
      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/mon-grfa-comb.yml

      #kubectl apply -f /home/ubuntu/petclinic-jul24/infra/k3s/4-ingress-monitoring/infra/k3s/4-ingress-monitoring/ingress-traefik.yml

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
}
