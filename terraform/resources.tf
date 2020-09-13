
# Specify the provider and access details
provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    assume_role {
        role_arn     = "${var.aws_role_arn}"
    }
}

 resource "aws_security_group" "elastic-sg" {
    name = "tf-elastic-sg"
    description = "Allow incoming rules connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["157.33.149.77/32"]
    }
    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 9300
        to_port = 9300
        protocol = "tcp"
        cidr_blocks = ["157.33.149.77/32"]
    }
    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["10.20.0.0/16"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    
    vpc_id = "vpc-305e42522323"
    tags {
        "Name" = "tf-elastic-sg"
        "cm:engg:application" = "ES|Security Group"
      
    }
  }

resource "aws_instance" "elasticsearch-cluster" {
  count = "${var.instance_count}"

  #ami = "${lookup(var.amis,var.region)}"
  ami           = "${var.ami}"
  instance_type = "${var.instance}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = [ "sg-0044645c1420c67ec", "${aws_security_group.elastic-sg.id}" ]
  key_name = "${var.key_name}"  
  connection {
    private_key = "${file(var.private_key)}"
    user        = "${var.ansible_user}"
  }

  provisioner "remote-exec" {
    inline = [ "sudo apt-get update",
               "sudo add-apt-repository ppa:jonathonf/python-3.6 -y",
               "sudo apt-get update",
               "sudo apt-get install -y python3.6",
               "sudo apt-get install -y python3-pip",
               "add-apt-repository -r ppa:jonathonf/python-3.6",
               "sudo apt-get update"
             ]
  }
  # This is where we configure the instance with ansible-playbook
  
  # This is where we configure the instance with ansible-playbook

  provisioner "local-exec" {
    command = <<EOT
      sleep 300;
	  >elasticsearch-cluster.ini;
	  echo "[elasticsearch-cluster]" | tee -a elasticsearch-cluster.ini;
	  echo "${aws_instance.elasticsearch-cluster.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a elasticsearch-cluster.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i elasticsearch-cluster.ini ../ansible_workspace/site.yml
   EOT
  }
  tags {
    Name = "elasticsearch-cluster-${count.index +1 }"
    Subsystem = "Elasticsearch"
    Location = "colifornia"
  }

