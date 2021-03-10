terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
        tls = {
            source = "hashicorp/tls"
        }
    }
}

provider "aws" {
    profile = "default"
    region = "eu-west-1"
}

provider "tls" {}

data "aws_ami" "ami_ubuntu" {
    most_recent      = true
    owners           = ["099720109477"]

  filter {
    name   = "name"
    values = [ "*ubuntu-xenial-16.04-amd64-server-*" ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "mi-maquina-bonat" {
    ami = data.aws_ami.ami_ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.claves_aws.key_name
    security_groups = [aws_security_group.reglas_red_bonat.name]
    
    tags = {
        Name = "MaquinaBonat"
    }
    
    provisioner "local-exec" {
        command = "echo \"${self.public_ip} ansible_connection=ssh ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file=./clave_privada.pem\" > inventario.ini"
    }
    
    provisioner "local-exec" {
        command = "ansible-playbook -i inventario.ini mi-playbook.yaml"
    }
    
    # user_data = <<-EOF
        #!/bin/bash
        # sudo apt update - y
        # EOF
    
    # connection { 
    #     type = "ssh"
    #     host = self.public_ip
    #     user = "ubuntu"
    #     private_key = tls_private_key.clave_privada.private_key_pem
    #     port = 22
    # }
    
    # provisioner "remote-exec" {
    #     inline = [ "docker run -p 8080:8080 -d bitnami/tomcat" ]
    # }
}

resource "tls_private_key" "clave_privada" {
    algorithm = "RSA"
    rsa_bits = "4096"
    
    provisioner "local-exec" {
        command = "echo \"${self.private_key_pem}\" > clave_privada.pem && echo \"${self.public_key_pem}\" > clave_publica.pem"
    }
}

resource "aws_key_pair" "claves_aws" {
    key_name = "mi-clave-bonat"
    public_key = tls_private_key.clave_privada.public_key_openssh
    
}


resource "aws_security_group" "reglas_red_bonat" {
    name    = "reglas_red_bonat"
    description    = "Reglas de red de Bonat"
    
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}
