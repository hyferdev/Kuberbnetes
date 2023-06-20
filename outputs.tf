output "EKS_API_Server_Endpoint" {
  description = "EKS API server endpoint"
  value       = aws_eks_cluster.my_cluster.endpoint
}

output "EKS_Certificate_Authority" {
  description = "EKS Certificate Authority (CA) data"
  value       = aws_eks_cluster.my_cluster.certificate_authority[0].data
}

