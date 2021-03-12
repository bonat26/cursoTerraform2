terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = var.region_aws
    profile = "default"
}

module "claves" {
    source = "./claves"
    longitud_clave_rsa = 4096
    id_clave = var.id_clave
}

module "red" {
    source      = "./red"
    nombre_vpc  = "bonat-vpc"
    cidr_vpc    = "10.0.0.0/16"
    subnets     = [
                {
                    "subnet_name": "bonat-publica",
                    "subnet_cidr": "10.0.1.0/24",
                    "subnet_az_name": null,
                    "subnet_az_id": null,
                    "subnet_public": true
                },
                {
                    "subnet_name": "bonat-privada",
                    "subnet_cidr": "10.0.2.0/24",
                    "subnet_az_name": null,
                    "subnet_az_id": null,
                    "subnet_public": false
                }
            ]
    
    security_groups = [
    
    ]
}
