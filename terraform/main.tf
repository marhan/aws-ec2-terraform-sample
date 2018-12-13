variable "profile" {
  # can be empty, if variables file is used
  default = "terraform"
}

variable "region" {
  # can be empty, if variables file is used
  default = "eu-central-1"
}

variable "key_name" {
  # can be empty, if variables file is used
  default = "my-experiment"
}

provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_instance" "web" {
  ami = "ami-086a09d5b9fa35dc7" # ubuntu-xenial-16.04-amd64
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  tags {
    Name = "experiment"
  }
}