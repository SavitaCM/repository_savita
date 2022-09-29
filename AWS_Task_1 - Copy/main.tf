provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAU4CZYEPPWRMYIQRF"
  secret_key = "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"
}

module "network_module" {
  source    = "./network_module"
  namespace = var.namespace
}

module "Keypair_module" {
  source    = "./Keypair_module"
  namespace = var.namespace
}

module "ec2_module" {
  source     = "./ec2_module"
  namespace  = var.namespace
  vpc        = module.network_module.vpc
  sg_pub_id  = module.network_module.sg_pub_id
  sg_priv_id = module.network_module.sg_priv_id
  key_name   = module.Keypair_module.key_name
}

module "alb_module" {
  source    = "./alb_module"
  namespace = var.namespace
  vpc       = module.network_module.vpc
  sg_pub_id = module.network_module.sg_pub_id

}
