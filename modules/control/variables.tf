 # EC2 Module
variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_type" {
  default = "t2.micro"
}
#variable "image_id" {}
variable "name" {
  default = "control management"
}
/*variable "countt" {
  default = "2"
}*/