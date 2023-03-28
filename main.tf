module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "first-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "vm1" {
  ami                     = "ami-00c39f71452c08778"
  instance_type           = "t2.micro"
  subnet_id = "subnet-0e67c0ce622d56a0f"
  key_name = "aws-practice"

  user_data = "${file("user-data.sh")}"
  
  tags = {
    "Name" = "vm1"
  }
}