provider "aws" {
  region = var.region
}


resource "aws_key_pair" "midterm-key" {
  key_name   = "midterm-key"
  public_key = file(var.ssh_key)

}

data "template_file" "mariaUserData" {
  template = file("files/mariadb.sh")

  vars = {
    db_name = var.database_name
    db_user = var.database_user
    db_pass = var.database_pass
  }  
}

data "template_file" "wordPressUserData" {
  template = file("files/wordpress2.sh")

  vars = {
    public_ip = aws_eip.wordpress.public_ip
    admin_user = var.admin_user
    admin_pass = var.admin_pass
  }
  
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

resource "aws_instance" "wordpress" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"

  #run script when terraform apply
  user_data = data.template_file.wordPressUserData.rendered

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
}




resource "aws_instance" "mariadb"{
  ami = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.mariadb.id]
  associate_public_ip_address = true

  key_name = "midterm-key"

  user_data = data.template_file.mariaUserData.rendered

  tags = {
    Name = "mariadb"
  }
}