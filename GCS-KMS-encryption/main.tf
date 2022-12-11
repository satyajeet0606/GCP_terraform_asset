module "kms_key" {

  source                      = "./modules/kms"
  keyring                     = var.keyring
  location                    = var.location
  crypto_keys                 = var.crypto_keys
  key_rotation_period         = var.key_rotation_period
  purpose                     = var.purpose
  key_algorithm               = var.key_algorithm
  key_protection_level        = var.key_protection_level
  set_owners_for              = var.set_owners_for
  owners                      = var.owners
  set_decrypters_for          = var.set_decrypters_for
  decrypters                  = var.decrypters
  set_encrypters_for          = var.set_encrypters_for
  encrypters                  = var.encrypters
  static_bucket               = var.static_bucket
  storage_location            = var.storage_location
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access

}


  