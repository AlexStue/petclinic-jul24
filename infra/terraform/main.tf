terraform { 
  cloud { 
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}

provider "kubernetes" {
  config_path = var.KUBECONFIG  # Reference the environment variable
}


# Step 4: Use the kubernetes_manifest resource to apply the Kubernetes manifest
resource "kubernetes_manifest" "mon_grfa_comb" {
  manifest = yamldecode(file("${path.module}/manifests/mon-grfa-depl.yml"))
}
