variable "is_most_recent_ami" {
    description = "Indicador de si se obtiene el AMI mas reciente"
    type = bool
    default = true
}

variable "owners_ami" {
    description = "Propietarios del AMI"
    type = list(string)
}

variable "filter_name_ami" {
    description = "Nombres para filtrar busqueda del AMI"
    type = list(string)
}

variable "virtualization_type_ami" {
    description = "Tipos de virtualizacion para filtrar busqueda del AMI"
    type = list(string)
    default = ["hvm"]
}

variable "instance_type" {
    description = "Tipo de instancia de maquina de AWS"
    type = string
    default = "t2.micro"
}

variable "id_clave" {
    description = "Identificador de la clave"
    type = string
}

variable "security_groups" {
    description = "Grupos de seguridad"
    type = list(string)
}

variable "instance_name" {
    description = "Nombre de la instancia"
    type = string
}

variable "volume_size" {
    description = "Tamaño del volumen"
    type = number
}

variable "volume_device_name" {
    description = "Ruta donde se enlazará el volumen"
    type = string
}
