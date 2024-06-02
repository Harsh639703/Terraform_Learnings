
# in this project we are creating the github repo using terraform destructured file

## variable.tf
variable token{
    
}

## resource.tf
resource "github_repository" "first_repo" {
  name        = "first-repo-using-terraform"
  description = "creating resources using "
  visibility = "public"
}


## provider.tf
provider "github" {
  token= "${var.token}"
}

## terraform.tfvars

token="your github token"