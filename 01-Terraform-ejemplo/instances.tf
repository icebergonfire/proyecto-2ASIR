provider "aws" {
  access_key = "ACCESS_KEY"
  secret_key = "SECRET_KEY"
  region     = "us-east-1"
}

resource "aws_instance" "instancia1" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  key_name = "terraform"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"

  provisioner "remote-exec" {
    scripts = [
      "bootstrap.sh"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file("~/.ssh/terraform-proyecto")}"
    }
  }
}
resource "aws_instance" "instancia2" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  key_name = "terraform"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"

  provisioner "remote-exec" {
    scripts = [
      "bootstrap.sh"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file("~/.ssh/terraform-proyecto")}"
    }  
  }
}


