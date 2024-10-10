resource "aws_instance" "proxy" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = "omar"
  security_groups = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "${var.name}"
  }


  # SSH connection block for the provisioners
  /*connection {
    type        = "ssh"
    user        = "ec2-user"                     # Change based on the AMI (e.g., "ec2-user" for Amazon Linux, "ubuntu" for Ubuntu)
    private_key = file(var.private_key_path)    # Path to your SSH private key
    host        = self.public_ip                # Public IP for connection
  }

  provisioner "file" {
    source      = var.file_source  # File source (HTML page or other files)
    destination = var.file_dest    # Destination path
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y ",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
    ]
  }*/
  # Use local-exec to retrieve ALB DNS and inject into Nginx config
  provisioner "local-exec" {
    command = <<EOT
      echo "Instance Name: ${var.name}" >> all-ips.txt
      echo "Public IP: ${self.public_ip}" >> all-ips.txt
      echo "Private IP: ${self.private_ip}" >> all-ips.txt
      echo "" >> all-ips.txt # Adds a blank line between instances
    EOT
  }
  
  
}



output "instance_id" {
  value = aws_instance.proxy[*].id
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

