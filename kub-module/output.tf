output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "IDs des subnets publics"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs des subnets privés"
  value       = aws_subnet.private_subnet[*].id
}

output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.eks.name
}

output "cluster_id" {
  description = "ID du cluster EKS"
  value       = aws_eks_cluster.eks.id
}
