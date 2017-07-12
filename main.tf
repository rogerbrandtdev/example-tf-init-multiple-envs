terraform {
  backend "atlas" {
    address = "https://deploy.rd.elliemae.io"
  }
}

provider "atlas" {
  address = "https://deploy.rd.elliemae.io"
}


data "atlas_artifact" "web-server" {
name = "developer_2/web-server"
type = "amazon.image"
version = "latest"
}

resource "aws_instance" "web-server" {
  ami = "${data.atlas_artifact.web-server.metadata_full.region-us-west-2}"
  instance_type = "t2.micro"

  tags {
    Name = "web-server"
  }
}

variable "key_name" {}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
