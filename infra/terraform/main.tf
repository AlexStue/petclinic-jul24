provider "local" {}
resource "null_resource" "apply_k3s_manifests" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Applying Kubernetes deployments"
      
      ### Configs ###

      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/grfa-ConfigMap.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/pmth-svr-ConfigMap.yml

      ### Deployments ###
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/secrets/db-secret.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/vp/app-combined.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/vp/ingress-combined.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/vp/db-config.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/vp/db-combined.yml      
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/8-App-mon-ingr/mon-pmth-ClusterRole.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/8-App-mon-ingr/mon-pmth-exp-NodeExporter.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/8-App-mon-ingr/mon-pmth-svr-comb.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/8-App-mon-ingr/mon-pmth-almg-comb.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/8-App-mon-ingr/mon-grfa-comb.yml

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
