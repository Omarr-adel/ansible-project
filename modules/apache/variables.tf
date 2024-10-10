 # EC2 Module
variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_type" {
  default = "t2.micro"
}
#variable "image_id" {}
variable "name" {
    default = "web-EC2"
}
variable "countt" {
  default = "2"
}

/*variable "user-data" {
  default = <<-EOT
#!/bin/bash
sudo yum update -y  
sudo yum install -y httpd  
sudo systemctl start httpd  
sudo systemctl enable httpd  

INSTANCE_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname)

# Create an HTML file with the hostname
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instance Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding-top: 50px;
        }
        h1 {
            color: #0056b3;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            margin: 0 auto;
            width: 50%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to EC2 Instance</h1>
        <p><strong>Hostname:</strong> $INSTANCE_HOSTNAME</p>
        <p>This page is served by an Apache web server running on this EC2 instance.</p>
    </div>
</body>
</html>
EOF
EOT
}*/
