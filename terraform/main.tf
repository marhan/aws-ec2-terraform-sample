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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  # Canonical
  owners = [
    "099720109477"]
}

resource "aws_instance" "my-experiment-vm" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "experiment"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}