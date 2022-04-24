resource "aws_instance" "main" {
  ami = "ami-0a3d21ec6281df8cb"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id = aws_subnet.public-a.id
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh_key.id

  tags = {
    Name = var.ec2_name
  }
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.allowed_ip}/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_key"
  public_key = file("~/.ssh/dotnet_test.pub")
}