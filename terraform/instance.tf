resource "aws_security_group" "assurity-allow-ssh" {
  name        = "assurity-allow-ssh"
  description = "Assurity security group that allows ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "assurity-allow-ssh"
  }
}

resource "aws_key_pair" "assurity_id_rsa" {
  key_name   = "assurity_id_rsa"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "ubuntu" {
  ami                    = "${lookup(var.AMI_ID, var.AWS_REGION)}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.assurity_id_rsa.key_name}"
  vpc_security_group_ids = ["${aws_security_group.assurity-allow-ssh.id}"]

  tags {
    Name = "Ubuntu-16.04"
  }

  provisioner "local-exec" {
    command = "echo \"[ubuntu-server]\n${aws_instance.ubuntu.public_ip} ansible_connection=ssh ansible_ssh_user=ubuntu\"  > ../ansible/hosts"
  }
}
