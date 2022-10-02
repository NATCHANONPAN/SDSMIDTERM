resource "aws_eip" "wordpress" {
    vpc =true  
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.wordpress.id
  allocation_id = aws_eip.wordpress.id
}

