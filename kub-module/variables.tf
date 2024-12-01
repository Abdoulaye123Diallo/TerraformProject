# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block pour le VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks pour les subnets publics"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks pour les subnets privés"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zones de disponibilité pour les subnets"
  type        = list(string)
}

# EKS Configuration
variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
}

variable "eks_role_arn" {
  description = "ARN du rôle IAM pour le cluster EKS"
  type        = string
}

variable "node_role_arn" {
  description = "ARN du rôle IAM pour les nœuds"
  type        = string
}

variable "node_count" {
  description = "Nombre de nœuds dans le groupe"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Type d'instance pour les nœuds"
  type        = string
  default     = "t3.medium"
}

variable "environment" {
  description = "Environnement du cluster (dev, prod, etc.)"
  type        = string
  default     = "dev"
}
