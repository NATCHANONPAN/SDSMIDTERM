provider "aws" {
  region = var.region
}


resource "aws_key_pair" "midterm-key" {
  key_name   = "midterm-key"
  public_key = file(var.ssh_key)

}

data "template_file" "phpconfig" {
  template = file("files/conf.wp-config.php")

  vars = {
    db_port = 3306
    db_host = aws_instance.mariadb.private_ip
    db_user = var.database_user
    db_pass = var.database_pass
    db_name = var.database_name
  }
 
}

# data "template_file" "dbinit" {
#   template = file("files/setup.sql")

#   vars = {
#     db_user = var.database_user
#     db_pass = var.database_pass
#     db_name = var.database_name
#     db_admin = var.admin_user
#     db_admin_pass = var.admin_pass
#   }
# }

resource "aws_instance" "wordpress" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"

  #run script when terraform apply
  user_data = file("files/wordpress2.sh")

  key_name = "midterm-key"

  vpc_security_group_ids = [aws_security_group.wordpress.id]

  subnet_id = aws_subnet.public1.id
  associate_public_ip_address = true

  tags = {
    Name = "WordPress"
  }

  provisioner "file" {
    content = data.template_file.phpconfig.rendered
    destination = "/tmp/wp-config.php"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host = self.public_ip
      private_key = file(var.ssh_priv_key)
    }
  }

  # provisioner "file" {
  #   content = data.template_file.dbinit.rendered
  #   destination = "/tmp/dbinit.sql"

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }
  
  # provisioner "remote-exec" {
  #   inline = ["sudo mv /tmp/wp-config.php /var/www/html/wordpress/"] 
    

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }
}




resource "aws_instance" "mariadb"{
  ami = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.mariadb.id]
  associate_public_ip_address = true

  key_name = "midterm-key"

  user_data = file("files/mariadb.sh")

  tags = {
    Name = "mariadb"
  }
}