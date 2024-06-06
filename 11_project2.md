## In this we are creating the resource from the in aws.
## In this we are creating the  instance using terraform file

## How to make?

# first make a folder in your directory and then make 2 file in it instance.tf and provider.tf
# Now create a IAM user in which you give the policy IAMfullAccess and the FullEC2Access  ------>imporant note(otherwise your terraform file won't work)


## instance.tf

resource "aws_instance" "web"{
  ami           = "ami-05e00961530ae1b55"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform_instance"
  }
}

## provider.tf

provider "aws" {
  region     = "ap-south-1"
  access_key = "-------add your access id---------"
  secret_key = "----add your secret key-----"
}

## last step

terraform init
terraform validate
terraform plan
terraform apply






