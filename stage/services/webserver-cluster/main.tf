provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  source = "git@github.com:jsimonton020/terraform_modules.git?ref=v0.0.1"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "js020-terraform-state"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}

output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value = module.webserver_cluster.alb_dns_name
}

# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via 'terraform init -backend-config=/home/jsimonton/terraform/setup/backend.hcl'
terraform {
  backend "s3" {
    key = "stage/services/webserver-cluster/terraform.tfstate"
  }
}