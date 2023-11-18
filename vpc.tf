module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.vpc 

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
    Name = "Kubernetes"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
    Name = "Kubernetes"
  }

  tags = {
    Name = "Kubernetes"
  }
}

################################################################################
# NETWORKING
################################################################################
resource "aws_internet_gateway" "k8s" {
 vpc_id = module.vpc.vpc_id
 
 tags = {
   Name = "${var.vpc} Internet Gateway"
 }
}

resource "aws_route_table" "k8s" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = {
    Name = "Kubernetes"
  }
}

resource "aws_route_table_association" "k8s" {
  for_each       = toset([for subnet in module.vpc.public_subnets: subnet.id])
  route_table_id = aws_route_table.k8s.id
  subnet_id      = each.value
}