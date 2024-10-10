# NLB and ALB Modules
variable "lb_name" {}
variable "subnets" {}
variable "vpc_id" {}
variable "instance1_id" {
  description = "ID of the first EC2 instance"
}

variable "instance2_id" {
  description = "ID of the second EC2 instance"
}
