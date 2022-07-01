resource "aws_iam_role" "ben-project-3" {
    name = "ben-eks-cluster"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.ben-project-3.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
     policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
     role = aws_iam_role.ben-project-3.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.ben-project-3.name
}

