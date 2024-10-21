# resource "server_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }

provider "null" {}

resource "null_resource" "remote_exec" {
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, Server!' > /tmp/hello.txt", # Example command
    ]

    connection {
      type     = "ssh"
      host     = var.SSH_ALEX_SERVER_IP_TF
      user     = var.SSH_ALEX_SERVER_UN_TF
      password = var.SSH_ALEX_SERVER_PW_TF
    }
  }
}





# provider "local" {}
# resource "null_resource" "apply_k3s_manifests" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       echo "Applying Kubernetes deployments"
      
#       ### Configs ###

#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/grfa-ConfigMap.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/monitoring/pmth-svr-ConfigMap.yml

#       ### Deployments ###

#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/app-combined.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/ingress-resource.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-ClusterRole.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-exp-NodeExporter.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-svr-comb.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-pmth-almg-comb.yml
#       kubectl apply -f /home/ubuntu/petclinic-jul24-deploy/k3s/mon-grfa-comb.yml

#       ### restarts ###

#       #kubectl rollout restart deployment mysqlserver-deployment -n dev
#       #kubectl rollout restart deployment petclinic-deployment -n dev
#       #kubectl rollout restart deployment prometheus-deployment -n dev
#       #kubectl rollout restart deployment alertmanager-deployment -n dev
#       #kubectl rollout restart deployment grafana-deployment -n dev

#     EOT
#   }
#   triggers = {
#     always_run = "${timestamp()}"
#   }
# }
