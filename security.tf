resource aws_security_group "wordpress"{
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

    ingress {
        description = "HTTPS"
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Ping"
        protocol = "icmp"
        from_port = -1
        to_port = -1
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
  description = "Allow only wordpress"
  vpc_id =  aws_vpc.vpc.id

  ingress {
    description = "wordpress traffic"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.wordpress.id]
  }

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

  depends_on = [
    aws_security_group.wordpress
  ]

  tags = {
    Name = "mariadb-secur"
  }
}