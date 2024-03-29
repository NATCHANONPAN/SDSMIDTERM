resource "aws_network_interface" "public1" {
  subnet_id = aws_subnet.public1.id
  security_groups = [aws_security_group.wordpress.id]

}
resource "aws_network_interface" "public2" {
  subnet_id = aws_subnet.public2.id
}
resource "aws_network_interface" "link1" {
  subnet_id = aws_subnet.private1.id
  security_groups = [aws_security_group.link.id]
}

resource "aws_network_interface" "link2" {
  subnet_id = aws_subnet.private1.id
  security_groups = [aws_security_group.link.id]

}

resource "aws_network_interface" "private2" {
  subnet_id = aws_subnet.private2.id
  security_groups = [aws_security_group.mariadb.id]

}