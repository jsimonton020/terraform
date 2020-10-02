provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name  = each.value
}

# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via 'terraform init -backend-config=/home/jsimonton/terraform/setup/backend.hcl'
terraform {
  backend "s3" {
    key = "global/iam/terraform.tfstate"
  }
}