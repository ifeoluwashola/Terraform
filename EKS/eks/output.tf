#########################################
# Core Cluster Information
#########################################

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "API server endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  value       = module.eks.cluster_version
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "OIDC provider URL for IRSA integration"
  value       = module.eks.oidc_provider
}

#########################################
# Networking and Security Groups
#########################################

output "vpc_id" {
  description = "VPC ID where EKS is deployed"
  value       = var.vpc_id
}

output "cluster_security_group_id" {
  description = "Security group ID of the EKS control plane"
  value       = aws_security_group.eks_cluster_sg.id
}

output "node_security_group_id" {
  description = "Security group ID of the EKS worker nodes"
  value       = aws_security_group.eks_nodes_sg.id
}

output "subnet_ids" {
  description = "Private subnet IDs associated with the cluster"
  value       = var.private_subnets
}

#########################################
# IAM Roles
#########################################

output "cluster_role_arn" {
  description = "IAM role ARN used by the EKS control plane"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "IAM role ARN used by the worker nodes"
  value       = aws_iam_role.node_group_role.arn
}

#########################################
# Node Groups
#########################################

output "node_group_names" {
  description = "Names of the managed node groups"
  value       = keys(module.eks.eks_managed_node_groups)
}

output "node_group_arns" {
  description = "ARNs of the node group IAM roles"
  value       = [for ng in module.eks.eks_managed_node_groups : ng.iam_role_arn]
}

output "node_group_instance_types" {
  description = "Instance types used in node groups"
  value       = [for ng in module.eks.eks_managed_node_groups : ng.instance_types]
}

#########################################
# Additional Useful Info
#########################################

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to connect via kubectl"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_identity_oidc_issuer" {
  description = "OIDC issuer URL of the EKS cluster"
  value       = module.eks.cluster_identity[0].oidc[0].issuer
}
 