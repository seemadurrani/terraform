provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ubuntu_ec2" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 in us-east-1 (as of June 2025)
  instance_type = "t2.micro"
  key_name      = "my-key"  # Replace with the name of your existing key pair in AWS

  tags = {
    Name = "Ubuntu-Instance"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider using a more secure IP range in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

