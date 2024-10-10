# VPC
module "vpc" {
  source  = "./modules/vpc"
}

# Nginx Proxy EC2 Instances with Dynamic ALB DNS Injection
module "proxy_ec2" {
  source          = "./modules/proxy"
  vpc_id = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnets[0]
}


# Backend EC2 Instances with Apache and NAT access
module "backend_ec2" {
  source          = "./modules/apache"
  vpc_id = module.vpc.vpc_id
  subnet_id       = module.vpc.private_subnets[0]
}
# control EC2 Instance
module "control" {
  source          = "./modules/control"
  vpc_id = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnets[0]
}



# Public Network Load Balancer (NLB)
module "public_nlb" {
  source  = "./modules/nlb"
  vpc_id  = module.vpc.vpc_id
  lb_name = "public-nlb"
  subnets = module.vpc.public_subnets
  instance1_id = module.proxy_ec2.instance1_id
  instance2_id = module.proxy_ec2.instance2_id
}


# Private Application Load Balancer (ALB)
module "private_alb" {
  vpc_id  = module.vpc.vpc_id
  source  = "./modules/alb"
  lb_name = "private-alb"
  subnets = module.vpc.private_subnets
  instance1_id = module.backend_ec2.instance1_id
  instance2_id = module.backend_ec2.instance2_id
}