module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.26.2"
  cluster_name    = local.cluster_name
  cluster_version = "1.23"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-main"
      instance_type                 = "m5.xlarge" # was t4g.xlarge, but we realized ARM instruction set might be problematic
      additional_userdata           = "echo P3 Nodes" 
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
      asg_desired_capacity          = 4
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
