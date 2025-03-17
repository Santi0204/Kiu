resource "aws_eks_cluster" "kiu" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.kiu_role.arn

  vpc_config {
    subnet_ids = aws_subnet.kiu_subnet_public[*].id  
  }
}

resource "aws_eks_node_group" "kiu_nodes" {
  cluster_name    = aws_eks_cluster.kiu.name
  node_group_name = "kiu-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn  
  subnet_ids      = aws_subnet.kiu_subnet_public[*].id
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Name = "kiu-node-group"
  }
}

