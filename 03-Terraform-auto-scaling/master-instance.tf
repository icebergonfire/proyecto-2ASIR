resource "aws_instance" "main" {
  ami           = "ami-b14ba7a7"
  availability_zone = "us-east-1a"
  instance_type = "t2.micro"
  key_name = "terraform"

  lifecycle {
        ignore_changes = ["*"]
  }

  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${aws_subnet.default.id}"

  provisioner "file" {
    source = "${var.provisioning-folder}"
    destination = "/tmp/vagrant"
  }

  provisioner "file" {
    source = "credentials.tf"
    destination = "/tmp/vagrant/credentials.tf"
  }
  provisioner "file" {
    source = "network-setup.tf"
    destination = "/tmp/vagrant/network-setup.tf"
  }
  provisioner "file" {
    source = "master-instance.tf"
    destination = "/tmp/vagrant/master-instance.tf"
  }
  provisioner "file" {
    source = "variables.tf"
    destination = "/tmp/vagrant/variables.tf"
  }

  provisioner "remote-exec" {
    scripts = [
      "${var.provisioning-folder}/cloud-vagrant-glue.sh",
      "${var.provisioning-folder}/base-provisioning.sh",
      "${var.provisioning-folder}/control-provisioning.sh",
      "${var.provisioning-folder}/haproxy-provisioning.sh",
      "${var.provisioning-folder}/nagios-server.sh",
      "${var.provisioning-folder}/autoNodeScan-provisioning.sh",
      "${var.provisioning-folder}/ddclient-provisioning.sh",
      "${var.provisioning-folder}/terraform-autoresize-provisioner.sh"
    ]
  }


  connection {
    type     = "ssh"
    user     = "admin"
    private_key = "${file("${var.provisioning-folder}/provisioning-key")}"
  }
}



