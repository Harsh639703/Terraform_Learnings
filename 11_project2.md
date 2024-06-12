## In this we are creating the resource from the in aws.
## In this we are creating the  instance using terraform file

## How to make?

# first make a folder in your directory and then make 2 file in it instance.tf and provider.tf
# Now create a IAM user in which you give the policy IAMfullAccess and the FullEC2Access  ------>imporant note(otherwise your terraform file won't work)


## instance.tf

# first we will generate the key using ssh-keygen -i rsa then we will make the key pair to access the instance
# now we create the security group and attach that to the instance


## creating the key pair

resource "aws_key_pair" "test-tf" {
  key_name   = "test-tf"
  public_key = file("${path.module}/id.pub") //using file function takes the path as an argument and access the data in that file 
}

## creating the security group

resource "aws_security_group" "allow_tls" { //creating the security group
  name        = "allow_tls"
  description = "Allow TLS inbound traffic "
  dynamic "ingress" {
    for_each = [80, 22, 443, 27017]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value ///here we are using the for_each loop which is will iterate over the port dynamcally
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}


resource "aws_instance" "web"{
  ami           = "ami-05e00961530ae1b55"
  instance_type = "t2.micro"
  key_name        = "${aws_key_pair.test-tf.key_name}" ## here we are attaching public key with the instance
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"] # here we are attaching the security group with the instance
  tags = {
    Name = "terraform_instance"
  }
    user_data = <<-EOF //this will run the commands that we want to run the our instance
!/bin/bash
 sudo apt-get update
 sudo apt-get install nginx -y                            #this is the another way that you can write your code
 sudo echo "Hi Harsh Vishnoi" >/var/www/html/index.nginx-debian.html
 EOF
 # making provisioner for the instance
connection {
    type="ssh"
    user = "ubuntu"
    private_key = file("${path.module}/id")
    host = "${self.public_ip}"
  }

provisioner "file" {
  source = "readme.md"
  destination = "/tmp/readme.md"
}

provisioner "file" {
  content= "bhai sahaab kia haal hai mai toh terraform padhra hun"
  destination = "/tmp/content.md"
}
# this will run the command on the local pc 
provisioner "local-exec" {
  command = "echo ${self.public_ip} >>  mypublicip.txt"  
}

provisioner "local-exec" {
    on_failure = continue
    working_dir = "/tmp/"
    command     = "echo ${self.public_ip} > mypubliciptmp.txt"
  }

  provisioner "local-exec" {
    on_failure = continue
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('helloworld')"
  }



  provisioner "local-exec" {
    on_failure = continue
    command = "env > env.txt"
    environment = {
      envname = "envvalue"
    }
  }

  provisioner "local-exec" {
    on_failure = continue
    command = "echo 'at Create'"
  }

  provisioner "local-exec" {
    on_failure = continue
    when    = destroy
    command = "echo 'at delete' "

  }
  provisioner "remote-exec" {
    inline = [ 
      "ifconfig -a > /tmp/ifconfig.output",
      "echo 'hello harsh' >/tmp/test.txt"

     ]
  }
  provisioner "remote-exec" {
    script = "./inscripts.sh"    
  }


}

## provider.tf

provider "aws" {
  region     = "ap-south-1"
  access_key = "-------add your access id--------"
  secret_key = "----add your secret key-----"
}

## last step

terraform init
terraform validate
terraform plan
terraform apply


## Note1
terraform taint -> this command the used when we want to create the new resource once we change any thing in that it should alter that resource instead it should create new resource.

how to use this:-
terraforn taint aws_security_groups.alloq_tls




