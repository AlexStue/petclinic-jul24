terraform { 
  cloud { 
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}

variable "KUBECONFIG" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"  # You can set a default path, if needed
}

provider "kubernetes" {
  config_path = var.KUBECONFIG  # Reference the environment variable
}

# Step 4: Use the kubernetes_manifest resource to apply the Kubernetes manifest
resource "kubernetes_manifest" "mon_grfa_comb" {
  manifest = yamldecode(file("${path.module}/manifests/mon-grfa-depl.yml"))
}
