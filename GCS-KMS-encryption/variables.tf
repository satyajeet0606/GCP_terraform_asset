#Defaults:
variable "credentials" {
  type        = string
  description = "Json credential file"

}

variable "project_id" {
  type        = string
  description = "project id value"

}

variable "region" {
  type        = string
  description = "region of deployment"

}

variable "zone" {
  type        = string
  description = "zone of the deployment"
}

#Keyring:
variable "keyring" {
  description = "Keyring name."
  type        = string
}

variable "location" {
  description = "Location for the keyring."
  type        = string
}

#crypto_keys:
variable "crypto_keys" {
  description = "Key names."
  type        = list(string)

}

variable "key_rotation_period" {
  type        = string
  description = "key rotation period"
}

variable "purpose" {
  type        = string
  description = "The immutable purpose of the CryptoKey. Possible values are ENCRYPT_DECRYPT, ASYMMETRIC_SIGN, and ASYMMETRIC_DECRYPT."

}

variable "key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."

}

variable "key_protection_level" {
  type        = string
  description = "The protection level to use when creating a version based on this template. Default value: \"SOFTWARE\" Possible values: [\"SOFTWARE\", \"HSM\"]"

}

#Owner Specifications:
variable "set_owners_for" {
  description = "Name of keys for which owners will be set."
  type        = list(string)

}

variable "owners" {
  description = "List of comma-separated owners for each key declared in set_owners_for."
  type        = list(string)

}

#Encrypter roles specification:
variable "set_encrypters_for" {
  description = "Name of keys for which encrypters will be set."
  type        = list(string)

}

variable "encrypters" {
  description = "List of comma-separated owners for each key declared in set_encrypters_for."
  type        = list(string)

}

#Decrypter roles specification:
variable "set_decrypters_for" {
  description = "Name of keys for which decrypters will be set."
  type        = list(string)

}

variable "decrypters" {
  description = "List of comma-separated owners for each key declared in set_decrypters_for."
  type        = list(string)

}


#bucket:
variable "static_bucket" {
  description = "name of the storage bucket"
  type        = string
}

variable "storage_location" {
  description = "object storage location"
  type        = string
}

variable "force_destroy" {
  description = "if given true buckets with object can be deleted else operation would fail"
  type        = bool
}

variable "uniform_bucket_level_access" {
  description = "level of access on the bucket as uniform/ fine grained"
  type        = bool
}

variable "storage_class" {
  description = "storage class of the object"
  type        = string

}
