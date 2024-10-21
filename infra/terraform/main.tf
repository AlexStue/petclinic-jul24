terraform { 
  cloud { 
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}

# Step 1: Configure the Kubernetes provider
provider "kubernetes" {
  config_path = "~/.kube/config" # Use the path to your kubeconfig file
}

# Step 4: Use the kubernetes_manifest resource to apply the Kubernetes manifest
resource "kubernetes_manifest" "mon_grfa_comb" {
  manifest = yamldecode(file("/home/ubuntu/petclinic-jul24-deploy/k3s/mon-grfa-comb.yml"))
}
