terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"  # Check the latest version
    }
  }

  backend "remote" {
    organization = "alexstue-petclinic-jul24"  # Your Terraform Cloud organization name

    workspaces {
      name = "petclinic-jul24"  # Your Terraform Cloud workspace name
    }
  }
}

provider "null" {}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Hello from Terraform!'"
  }
}

output "message" {
  value = "This is an output from Terraform."
}
