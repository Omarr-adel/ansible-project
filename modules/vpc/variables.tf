# VPC Module
variable "cidr" {
  description = "vpc cider"
  default       = "10.0.0.0/16"
}
variable "public_subnets" {
  description = "List of pub subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "private_subnets" {
  description = "List of pri subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]  
  }