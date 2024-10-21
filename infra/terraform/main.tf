terraform { 
  cloud { 
    
    organization = "alexstue-petclinic-jul24" 

    workspaces { 
      name = "petclinic-jul24-cli" 
    } 
  } 
}