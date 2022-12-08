module "kms_key" {
  source               = "./modules/kms"
  keyring              = var.keyring
  location             = var.location
  crypto_keys          = var.crypto_keys
  key_rotation_period  = var.key_rotation_period
  purpose              = var.purpose
  key_algorithm        = var.key_algorithm
  key_protection_level = var.key_protection_level
  set_owners_for       = var.set_owners_for
  owners               = var.owners
  set_decrypters_for   = var.set_decrypters_for
  decrypters           = var.decrypters
  set_encrypters_for   = var.set_encrypters_for
  encrypters           = var.encrypters

}