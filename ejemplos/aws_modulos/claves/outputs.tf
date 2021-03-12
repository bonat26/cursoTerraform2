output "mi_clave_privada" {
    value = tls_private_key.clave_privada.private_key_pem
}

output "mi_clave_publica" {
    value = tls_private_key.clave_privada.public_key_pem
}
