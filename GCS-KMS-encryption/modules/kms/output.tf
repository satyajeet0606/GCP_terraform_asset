output "keyring" {
    value = module.kms_key.keyring
  
}

output "keyring_resource" {
    value = module.kms_key.keyring_resource
  
}

output "keys" {
    value = module.kms_key.keys
  
}

output "keyring_name" {
    value = module.kms_key.keyring_name  
}