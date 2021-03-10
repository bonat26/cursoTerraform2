terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
        null = {
            source = "hashicorp/null"
        }
    }
}

provider docker {
    
}

provider null {
    
}

# resource "docker_container" "contenedor_nginx"{
#     name = "mi-contenedor-de-nginx"
#     image = docker_image.imagen_nginx.latest
    
    # provisioner "local-exec" {
    #     command = "echo ${self.name}=${self.network_data[0].ip_address} >> inventory.txt"
    # }
    
#     connection {
#         type        = "ssh"
#         host        = self.network_data[0].ip_address
#         user        = "root"
#         password    = "root"
#         port        = 22
#     }
    
#     provisioner "remote-exec" {
#         inline = [
#             "echo ${self.name}=${self.network_data[0].ip_address} >> inventory.txt"
#             ]
#     }
# }

resource "null_resource" "inventario" {
    triggers = {
        disparador = docker_image.imagen_nginx.name
    }
    provisioner "local-exec" {
        command = "rm -f inventory.txt"
    }
}

resource "docker_container" "contenedores" {
    for_each = toset(var.contenedores)
    name = each.key
    image = docker_image.imagen_nginx.latest
    
    provisioner "local-exec" {
        command = "echo ${self.name}=${self.network_data[0].ip_address} >> inventory.txt"
    }
}

resource "docker_image" "imagen_nginx" {
    name = var.imagen_de_contenedor
}
