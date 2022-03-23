terraform {
  backend "local" {
    path          = "terraform.tfstate"
    workspace_dir = "workspace"
  }
}

# Module that defines the VPC
module "vpc" {
 source = "./modules/vpc"

 cidr_block = "${var.cidr_block}"
 project = "${var.project}"
 env = "${var.env}"
 
}

#module that defines the public subnet, routing table and internet gateway

module "public_subnet" {
 source = "./modules/subnet"
 vpc_id = "${module.vpc.vpc_id}"
 azs = "${var.azs}"
 subnets = "${var.public_cidr}"
 project = "${var.project}"
 env = "${var.env}"
 
}

#module to create internet gateway, routing table and associations

module "routing_table_public" {
  source = "./modules/route_table"
  vpc_id = "${module.vpc.vpc_id}"
  azs = "${var.azs}"
  subnet_ids = "${module.public_subnet.subnet_ids}"
  project = "${var.project}"
  env = "${var.env}"
}


# dynamic list of the public subnets created above
data "aws_subnet_ids" "public" {
  depends_on = [module.public_subnet]
  vpc_id     = "${module.vpc.vpc_id}"
}


#module for EC2 instance security  group
module "ec2_sg" {
  source = "./modules/ec2_sg"
  vpc_id = "${module.vpc.vpc_id}"
  project = var.project
  env = var.env
}


#module to create instance in public subnets
module "ec2_instance_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.0"
  depends_on = [module.ec2_sg.id]
  count = length(var.azs)
  subnet_id = element(concat(module.public_subnet.subnet_ids, [""]), count.index)

#  for_each = { for idx, subnet_id in tolist(data.aws_subnet_ids.public.ids): subnet_id => idx}  
  name = "instance-${count.index}"
  ami                    = "${lookup(var.ec2_amis, var.aws_region)}"
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = ["${module.ec2_sg.public_subnet_sg}"]
 
#  subnet_id              = each.key
  user_data    = "${file("user_data.sh")}"
  tags = {
      Name = "${var.project}-nginx-instance-${count.index}-${var.env}"
  }
}


#module to create private subnets
module "private_subnet" {
 source = "./modules/subnet"
 vpc_id = "${module.vpc.vpc_id}"
 azs = "${var.azs}"
 subnets = "${var.private_cidr}"
 project = "${var.project}"
 env = "${var.env}" 
}

#module to create rds securty group and rds instance in private subnets
module "rds" {
 source = "./modules/rds"
 vpc_id = "${module.vpc.vpc_id}"
 project = "${var.project}"
 env = "${var.env}"
 region = "${var.region}"
 subnet_ids = "${module.private_subnet.subnet_ids}"
 }

#module to create instance in private subnets that connects to rds
module "ec2_instance_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.0"
  depends_on = [module.rds]
  count = length(var.azs)
  subnet_id = element(concat(module.private_subnet.subnet_ids, [""]), count.index)

  name = "instance-${count.index}"
  ami                    = "${lookup(var.ec2_amis, var.aws_region)}"
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = ["${module.ec2_sg.public_subnet_sg}"]
 
  user_data    = "${file("user_data.sh")}"
  tags = {
      Name = "${var.project}-nginx-instance-${count.index}-${var.env}"
  }
}