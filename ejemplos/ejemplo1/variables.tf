variable "imagen_de_contenedor" {
    description = "Imagen de contenedor para la creacion del mismo"
    type = string
    default = "nginx:latest"
}

variable "contenedores" {
    description = "Mis contenedores"
    type = list(string)
    default = ["azul", "verde"]
}
