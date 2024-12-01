output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.eks.name
}

output "cluster_id" {
  description = "ID du cluster EKS"
  value       = aws_eks_cluster.eks.id
}
