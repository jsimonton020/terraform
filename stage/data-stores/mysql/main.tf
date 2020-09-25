provider "aws" {
  region = "us-west-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"
  password = var.db_password
}


# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via 'terraform init -backend-config=/home/jsimonton/terraform/setup/backend.hcl'
terraform {
  backend "s3" {
    key = "stage/data-stores/mysql/terraform.tfstate"
  }
}
