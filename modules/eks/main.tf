resource "aws_eks_cluster" "this" {
  name = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  version = "1.32"

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [ var.eks_cluster_role_arn ]
}

resource "aws_eks_node_group" "this" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn = var.node_role_arn
  subnet_ids = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }

  instance_types = [ var.instance_types ]
}