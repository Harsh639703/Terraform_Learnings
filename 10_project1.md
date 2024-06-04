
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

output first_repo{
  value="first_repo.html_url   //this will print the  url of the repository
}


## provider.tf
provider "github" {
  token= "${var.token}"
}

## terraform.tfvars

token="your github token"





