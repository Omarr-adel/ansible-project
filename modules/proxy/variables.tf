 # EC2 Module
variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_type" {
  default = "t2.micro"
}
#variable "image_id" {}
variable "name" {
  default = "Proxy-EC2"
}
variable "countt" {
  default = "2"
}
/*variable "private_key_path" {
default = "./omar.pem"
}
variable "file_source" {
  default = "./test.txt"
}
variable "file_dest" {
  default = "~/test.txt"
}
/*variable "use_file_provisioner" {
  default = false
}
variable "provisioner_commands" {
  default = []
}*/