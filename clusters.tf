module "cluster1" {
  source               = "./kub-module"
  cluster_name         = "cluster1"
  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  eks_role_arn         = "arn:aws:iam::123456789012:role/EKSClusterRole"
  node_role_arn        = "arn:aws:iam::123456789012:role/EKSNodeRole"
  node_count           = 2
  instance_type        = "t3.medium"
  environment          = "dev"
}

module "cluster2" {
  source               = "./kub-module"
  cluster_name         = "cluster2"
  vpc_cidr_block       = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  eks_role_arn         = "arn:aws:iam::123456789012:role/EKSClusterRole"
  node_role_arn        = "arn:aws:iam::123456789012:role/EKSNodeRole"
  node_count           = 3
  instance_type        = "t3.large"
  environment          = "prod"
}
