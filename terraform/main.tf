# bulut sağlayıcısını seç
provider "aws" {
  region = "eu-central-1" # Frankfurt 
}

# internet ve ağ ayarları
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "mern-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
}

# kubernets clusteri oluştur
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0"

  cluster_name    = "mern-cluster"
  cluster_version = "1.27"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # sunucu özellikleri
  eks_managed_node_groups = {
    general = {
      desired_size = 2 # 2 adet makine istiyoruz
      min_size     = 1
      max_size     = 3

      instance_types = ["t3.medium"] # Orta halli, yeterli bir sunucu tipi
    }
  }
}
