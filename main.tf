terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "wordpress" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"

  #run script when terraform apply
  user_data = file("files/wordpress.sh")

  vpc_security_group_ids = [aws_security_group.wordpress.id]

 
}

# resource "aws_instance" "mariadb"{
#   ami = var.ami
# }