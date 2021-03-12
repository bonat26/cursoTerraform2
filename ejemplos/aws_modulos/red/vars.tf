variable "nombre_vpc" {
    description = "Este es el nombre de la VPC"
    type = string
}
variable "cidr_vpc" {
    description = "CIDR de la CPV"
    type = string
}
variable "instance_tenancy" {
    description = "Si quiero infra propia para la VPC."
    type = string
    default = "default"
}
variable "subnets" {
    description = "Subredes que quiero crear en la VPC."
    type = list(map(string)) 
    default = [ ]
}
#
#subnets= [
#    {
#        "subnet_name": "publica",
#        "subnet_cidr": "10.0.1.0/24",
#        "subnet_az_name": null,
#        "subnet_az_id": null,
#        "subnet_public": true
#    },
#    {
#        "subnet_name": "privada",
#        "subnet_cidr": "10.0.2.0/24",
#        "subnet_az_name": null,
#        "subnet_az_id": null,
#        "subnet_public": false
#    }
#]

variable "ingress_list" {
    description = "Lista de ingress"
    type = map(map(string))
}

ingress = {
    {
        ssh:{
            from_port : 22
            to_port   : 22
            protocol  : "tcp"
            cidr_blocks : [ "0.0.0.0/0" ]
        }
    },
    {
        from_port : 8080
        to_port   : 8080
        protocol  : "tcp"
        cidr_blocks : [ "0.0.0.0/0" ]
    }
}

# ingress {
#         from_port = 22
#         to_port   = 22
#         protocol  = "tcp"
#         cidr_blocks = [ "0.0.0.0/0" ]
#     }
    
#     ingress {
#         from_port = 8080
#         to_port   = 8080
#         protocol  = "tcp"
#         cidr_blocks = [ "0.0.0.0/0" ]
#     }

#     egress {
#         from_port = 0
#         to_port   = 0
#         protocol  = "-1"
#         cidr_blocks = [ "0.0.0.0/0" ]
#     }
