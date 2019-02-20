resource "aws_default_vpc" "default" {}

resource "aws_security_group" "mscontest-sg" {
  name   = "mscontest-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "mscontest_key" {
  key_name   = "aws_ssh_key"
  public_key = "${file("./aws_ssh_key.pub")}"
}

resource "aws_instance" "mscontest" {
  ami                         = "${var.os-image}"
  key_name                    = "${aws_key_pair.mscontest_key.key_name}"
  instance_type               = "${var.instance-type}"
  security_groups             = ["${aws_security_group.mscontest-sg.name}"]
  associate_public_ip_address = true
  source_dest_check = false

connection {
  type = "ssh"
  host = "${aws_instance.mscontest.public_ip}"
  user = "ec2-user"
  private_key = "${file("./aws_ssh_key")}"
  timeout = "1m"
}

provisioner "remote-exec" {
  inline = [
	"sudo yum update -y",
	"sudo yum install -y wget git unzip zip"
	]
}
}

output "mscontest_public_ip" {
  value = "${aws_instance.mscontest.public_ip}"
}

output "mscontest_public_dns" {
  value = "${aws_instance.mscontest.public_dns}"
}

