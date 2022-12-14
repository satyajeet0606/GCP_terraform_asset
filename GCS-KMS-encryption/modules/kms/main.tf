locals {
  keys_by_name = zipmap(var.crypto_keys, slice(google_kms_crypto_key.crypto_key[*].id,0,length(var.crypto_keys)))
}
#Creating the key ring:
resource "google_kms_key_ring" "key_ring" {
  name     = var.keyring
  location = var.location
}

#Creating the crypto key:
resource "google_kms_crypto_key" "crypto_key" {
  count           = length(var.crypto_keys)
  name            = var.crypto_keys[count.index]
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = var.key_rotation_period
  purpose         = var.purpose

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

}

#binding owner roles for the keys:
resource "google_kms_crypto_key_iam_binding" "owners" {
  count         = length(var.set_owners_for)
  role          = "roles/owner"
  crypto_key_id = local.keys_by_name[var.set_owners_for[count.index]]
  members       = compact(split(",", var.owners[count.index]))
}

#binding decrypter roles for the keys:
resource "google_kms_crypto_key_iam_binding" "decrypters" {
  count         = length(var.set_decrypters_for)
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  crypto_key_id = local.keys_by_name[var.set_decrypters_for[count.index]]
  members       = compact(split(",", var.decrypters[count.index]))
}

#binding encrypter roles for the keys:
resource "google_kms_crypto_key_iam_binding" "encrypters" {
  count         = length(var.set_encrypters_for)
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  crypto_key_id = local.keys_by_name[var.set_encrypters_for[count.index]]
  members       = compact(split(",", var.encrypters[count.index]))
}

#Google storage bucket:
resource "google_storage_bucket" "static_bucket" {
  name          = var.static_bucket
  location      = var.storage_location
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  uniform_bucket_level_access = var.uniform_bucket_level_access
  #public_access_prevention = "enforced"


  encryption {
    default_kms_key_name = google_kms_crypto_key.crypto_key[0].id
  }
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.encrypters,
    google_kms_crypto_key_iam_binding.decrypters

  ]
  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

}

