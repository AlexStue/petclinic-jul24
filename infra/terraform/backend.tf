terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "alexstue-petclinic-jul24"

    workspaces {
      name = "petclinic-jul24"
    }
  }
}
