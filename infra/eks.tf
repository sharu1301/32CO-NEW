module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" 

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  # IAM Role for Service Accounts (IRSA)
  enable_irsa = true

  # Node Group Configuration
  eks_managed_node_groups = {
    nodejs = {
      min_size     = 2
      max_size     = 5
      desired_size = 2
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  tags = {
    Environment = "prod"
  }
}

resource "aws_ecr_repository" "nodejs_app" {
  name                 = "nodejs-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
