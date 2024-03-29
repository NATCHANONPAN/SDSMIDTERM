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
    db_host = aws_network_interface.link2.private_ip
    db_user = var.database_user
    db_pass = var.database_pass
    db_name = var.database_name
    iam_user_access_key = aws_iam_access_key.my_iam_access_key.id
    iam_user_secret = aws_iam_access_key.my_iam_access_key.secret
    bucket_name = var.bucket_name
    region = var.region
  }
  
}
# data "template_file" "phpconfig" {
#   template = file("files/conf.wp-config.php")

#   vars = {
#     db_port = 3306
#     db_host = aws_instance.mariadb.private_ip
#     db_user = var.database_user
#     db_pass = var.database_pass
#     db_name = var.database_name
#     access_key = aws_iam_access_key.my_iam_access_key
#     secret_key = aws_iam_access_key.my_iam_access_key.secret
#   }
 
# }

resource "aws_instance" "wordpress" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"

  #run script when terraform apply
  user_data = data.template_file.wordPressUserData.rendered

  key_name = "midterm-key"

  # vpc_security_group_ids = [aws_security_group.wordpress.id]
  # vpc_security_group_ids = [aws_security_group.wordpress.id,aws_security_group.link.id]

  # subnet_id = aws_subnet.public1.id
  # associate_public_ip_address = true

  network_interface {
      device_index = 0
      network_interface_id = aws_network_interface.public1.id
  }
  network_interface {
      device_index = 1
      network_interface_id = aws_network_interface.link1.id
  }
  

  
  

  tags = {
    Name = "WordPress"
  }

}




resource "aws_instance" "mariadb"{
  ami = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"
  # subnet_id = aws_subnet.public1.id
  # vpc_security_group_ids = [aws_security_group.mariadb.id]
  # vpc_security_group_ids = [aws_security_group.mariadb.id,aws_security_group.link.id]
  # associate_public_ip_address = true

  key_name = "midterm-key"

  user_data = data.template_file.mariaUserData.rendered

  network_interface {
      device_index = 1
      network_interface_id = aws_network_interface.link2.id
  }

  network_interface {
      device_index = 0
      network_interface_id = aws_network_interface.private2.id
  }
  tags = {
    Name = "mariadb"
  }
}