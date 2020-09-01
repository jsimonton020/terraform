provider "aws"{
  region = "us-west-1"
}

resource "aws_instance" "example"{
  ami = "ami-0dd005d3eb03f66e8"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}