module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Endpoint access settings
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  enable_irsa = true

  eks_managed_node_groups = {
    nodejs = {
      min_size       = 2
      max_size       = 5
      desired_size   = 2
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }

  cluster_addons = {
    coredns   = { resolve_conflicts = "OVERWRITE" }
    kube-proxy = {}
    vpc-cni   = { resolve_conflicts = "OVERWRITE" }
  }

  tags = {
    Environment = "prod"
  }
}

