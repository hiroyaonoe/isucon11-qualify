resource "aws_instance" "webapp1" {
  ami                    = var.isucon11q_ami
  vpc_security_group_ids = [aws_security_group.sg_allow_subnet.id, aws_security_group.sg_my_home_ssh.id]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  private_ip             = "192.168.0.11"
  user_data              = local.init_instance_script

  tags = {
    Name = "terraform-webapp1"
  }
}

resource "aws_instance" "webapp2" {
  ami                    = var.isucon11q_ami
  vpc_security_group_ids = [aws_security_group.sg_allow_subnet.id, aws_security_group.sg_my_home_ssh.id]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  private_ip             = "192.168.0.12"
  user_data              = local.init_instance_script

  tags = {
    Name = "terraform-webapp2"
  }
}

resource "aws_instance" "webapp3" {
  ami                    = var.isucon11q_ami
  vpc_security_group_ids = [aws_security_group.sg_allow_subnet.id, aws_security_group.sg_my_home_ssh.id]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  private_ip             = "192.168.0.13"
  user_data              = local.init_instance_script

  tags = {
    Name = "terraform-webapp3"
  }
}

resource "aws_instance" "bench" {
  ami                    = var.isucon11q_ami
  vpc_security_group_ids = [aws_security_group.sg_allow_subnet.id, aws_security_group.sg_my_home_ssh.id]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  private_ip             = "192.168.0.14"
  user_data              = local.init_instance_script

  tags = {
    Name = "terraform-bench"
  }
}

resource "aws_security_group" "sg_allow_subnet" {
  name   = "allow_subnet"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.subnet.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-isucon11q"
  }
}

resource "aws_security_group" "sg_my_home_ssh" {
  name   = "my_home_ssh"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_home_ip}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-isucon11q"
  }
}
