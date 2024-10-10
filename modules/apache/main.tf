/*data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}*/

resource "aws_instance" "apache" {
  count         = var.countt
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = "omar"
  security_groups = [aws_security_group.ec2_sg.id]
  #user_data = var.user-data
  tags = {
    Name = "${var.name}-${count.index}"
  }
 

  # Local-exec provisioner to echo IPs and save to a file with the instance name
  provisioner "local-exec" {
    command = <<EOT
      echo "Instance Name: ${var.name}-${count.index + 1}" >> all-ips.txt
      echo "Public IP: ${self.public_ip}" >> all-ips.txt
      echo "Private IP: ${self.private_ip}" >> all-ips.txt
      echo "" >> all-ips.txt # Adds a blank line between instances
    EOT
  }
}

output "instance1_id" {
  value = aws_instance.apache[0].id
}
output "instance2_id" {
  value = aws_instance.apache[1].id
}
# Security group (for SSH and HTTP)
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-sg"
  vpc_id      = var.vpc_id
  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Adjust as per your security policy
  }

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
