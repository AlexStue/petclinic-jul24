terraform { 
  cloud { 
    
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}

provider "local" {}
resource "null_resource" "apply_k3s_manifests" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Applying Kubernetes deployments"
      
      ### Configs ###

      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/grfa-ConfigMap.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/pmth-svr-ConfigMap.yml

      ### Deployments ###

      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/app-combined.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/ingress-resource.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-ClusterRole.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-exp-NodeExporter.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-svr-comb.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-almg-comb.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-grfa-comb.yml

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
