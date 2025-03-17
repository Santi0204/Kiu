output "eks_cluster_id" {
  value = aws_eks_cluster.kiu.id
}

output "rds_endpoint" {
  value = aws_db_instance.db_kiu.endpoint
}

output "load_balancer_dns" {
  value = aws_lb.kiu_lb.dns_name
}
