provider "aws" {
  region = "us-west-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "stage-tf-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "stagedb"
  username = "admin"
  password = var.db_password
  skip_final_snapshot = true
}


# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via 'terraform init -backend-config=/home/jsimonton/terraform/setup/backend.hcl'
terraform {
  backend "s3" {
    key = "stage/data-stores/mysql/terraform.tfstate"
  }
}
