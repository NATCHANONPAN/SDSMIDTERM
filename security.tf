resource "aws_security_group" "link" {
  name = "link-sg"
  description = "Allow only wordpress"
  vpc_id =  aws_vpc.vpc.id


  ingress {
    description = "wordpress traffic"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [aws_subnet.private1.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [aws_subnet.private1.cidr_block]
  }

  tags = {
    Name = "link-secur"
  }
}

resource "aws_security_group" "wordpress" {
  
  name = "wordpress-security-group"
  description = "Allow outside traffic from everywhere"
  vpc_id =  aws_vpc.vpc.id

  ingress {
        description = "SSH"
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
        description = "HTTP"
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol    = -1
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "wordpress-secur"
  }
}

resource "aws_security_group" "mariadb" {
  name = "mariadb-sg"
  description = "only go outside"
  vpc_id =  aws_vpc.vpc.id
  
  ingress {
        description = "SSH"
        protocol = "tcp"
        from_port = 22
      to_port = 22
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mariadb-secur"
  }
}

