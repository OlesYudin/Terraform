# Build AWS instance

provider "aws" {
  region  = var.region # instant region
  profile = "student"
}

module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/Security-group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  public_subnet     = module.vpc.public_subnet
  subnet_id         = module.vpc.subnet_id
  sg_id             = module.sg.sg_id
  igw               = module.vpc.igw
  availability_zone = module.vpc.availability_zone
}
