#1. Provider Configuration:
provider "aws" {
  region = "ap-south-1"
}
#2. Create a Security Group:
resource "aws_security_group" "all_traffic" {
  name = "all_traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { 
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#3. Create resource block to launch server:
resource "aws_instance" "prometheus_grafana" {
  ami                    = "ami-06b6e5225d1db5f46"
  instance_type          = "t2.medium"
  key_name               = "project-key"
  vpc_security_group_ids = [aws_security_group.all_traffic.id]
  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "prometheus_grafana"
  }
}
#3. Output block:
output "prometheus_grafana_public_ip" {
  description = "Public IP of server"
  value       = aws_instance.prometheus_grafana.public_ip
}
