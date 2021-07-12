provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "project-alfa-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_key_pair" "key" {
  key_name   = "pb_key"
  public_key = file(var.pb_key)
}

resource "aws_instance" "Jenkins" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_servers.id]
  key_name               = aws_key_pair.key.key_name
  provisioner "remote-exec" {
    inline = ["echo 'Start conecting to server'"]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.pr_key)
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.pr_key} -e 'pub_key=${var.pb_key}' Jenkins.yml"

  }
  tags = {
    Name  = "Jenkins Project Alfa - ${terraform.workspace}"
    Owner = "Roman"
  }
}

resource "aws_instance" "APP" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_servers.id]
  key_name               = aws_key_pair.key.key_name
  provisioner "remote-exec" {
    inline = ["echo 'Start conecting to server'"]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.pr_key)
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.pr_key} -e 'pub_key=${var.pb_key}' APP.yml"

  }
  tags = {
    Name  = "APP Project Alfa - ${terraform.workspace}"
    Owner = "Roman"
  }
}

resource "aws_security_group" "my_servers" {
  name = "My Security Group - ${terraform.workspace}"
  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "Project Alfa  - ${terraform.workspace}"
    Owner = "Roman"
  }
}
