terraform { 
  cloud { 
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}


terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}


# Step 4: Use the kubernetes_manifest resource to apply the Kubernetes manifest
resource "kubernetes_manifest" "mon_grfa_depl" {
  manifest = yamldecode(file("${path.module}/manifests/mon-grfa-depl.yml"))
}


