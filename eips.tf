resource "aws_eip" "wordpress" {
    vpc =true
    network_interface =  aws_network_interface.public1.id
}

resource "aws_eip" "natgw" {
    vpc =true
    # network_interface = aws_network_interface.private2.id
}

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_instance.wordpress.id
#   allocation_id = aws_eip.wordpress.id
# }

