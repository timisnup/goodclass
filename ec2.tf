resource "aws_instance" "instance" {
  ami                         = var.instance_ami
  key_name                    = "goodclass"
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.my-public-sub-1.id
  vpc_security_group_ids = [aws_security_group.goodclass_sg.id]
  tags = {
    Name = "goodclass"
  }
}


