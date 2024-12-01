#provider
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "fake-access-key"
  secret_key                  = "fake-secret-key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}


# Création du VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.cluster_name}-vpc"
    Environment = var.environment
  }
}

# Création de subnets publics
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.cluster_name}-public-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Création de subnets privés
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.cluster_name}-private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Création du cluster AWS EKS
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = concat(
      aws_subnet.public_subnet[*].id,
      aws_subnet.private_subnet[*].id
    )
  }

  version = "1.24"

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}

# Groupe de nœuds pour le cluster
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = aws_subnet.private_subnet[*].id

  scaling_config {
    desired_size = var.node_count
    min_size     = 1
    max_size     = 5
  }

  instance_types = [var.instance_type]

  tags = {
    Name        = "${var.cluster_name}-node-group"
    Environment = var.environment
  }
}
