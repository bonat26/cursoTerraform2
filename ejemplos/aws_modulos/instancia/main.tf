terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

data "aws_ami" "ami_ubuntu" {
    most_recent      = var.is_most_recent_ami
    owners = var.owners_ami
    # owners           = ["099720109477"]

  filter {
    name   = "name"
    values = var.filter_name_ami
    # values = [ "*ubuntu-xenial-16.04-amd64-server-*" ]
  }

  filter {
    name   = "virtualization-type"
    values = var.virtualization_type_ami
    # values = ["hvm"]
  }
}

resource "aws_instance" "mi-maquina-bonat" {
    ami = data.aws_ami.ami_ubuntu.idi
    instance_type = var.instance_type
    # instance_type = "t2.micro"
    key_name = var.id_clave
    security_groups = var.security_groups
    # security_groups = [aws_security_group.reglas_red_bonat.name]
    
    tags = {
        Name = var.instance_name
    }
    
    # provisioner "remote-exec" {
    #     inline = ["sudo apt-get update && sudo apt-get install python -y"]
    # }
    
    # provisioner "local-exec" {
    #     command = "echo \"${self.public_ip} ansible_connection=ssh ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file=./clave_privada.pem\" > inventario.ini"
    # }
    
    # provisioner "local-exec" {
    #     command = "ansible-playbook -i inventario.ini mi-playbook.yaml"
    # }
    
    
    
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

resource "aws_ebs_volume" "mi_volumen" {
    availability_zone = aws_instance.mi-maquina-bonat.availability_zone
    size              = var.volume_size
    
    tags = {
        Name = "${aws_instance.mi-maquina-bonat.tags.Name}_vol2"
    }
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = var.volume_device_name
    # device_name = "/dev/sdh"
    volume_id   = aws_ebs_volume.mi_volumen.id
    instance_id = aws_instance.mi-maquina-bonat.id
}