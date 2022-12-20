variable "project_id" {
  type        = string
  description = "GCP project ID"

}

variable "dlp_rolesList" {
  type        = list(string)
  description = "Roles to be assigned to the app engine default service account"

}

variable "dlp_role" {
  type        = string
  description = "Roles to assigned to the DLP default service account"

}

#GCS bucket's:
variable "staging_bucket" {
  type        = string
  description = "name of the staging bucket"

}

variable "non_sensitive_bucket" {
  type        = string
  description = "name of the non sensitive bucket"

}

variable "sensitive_bucket" {
  type        = string
  description = "Name of the sensitive bucket"

}

variable "fucntion_bucket" {
  type        = string
  description = "name of the function bucket"

}

variable "location" {
  type        = string
  description = "location of the storage bucket"

}

variable "force_destroy" {
  type        = bool
  description = "If given true buckets with objects can be deleted"

}

variable "storage_class" {
  type        = string
  description = "description of the object storage class"

}

variable "public_access_prevention" {
  type        = string
  description = "whether to enforce public access prevention on this bucket"

}

variable "zip_function" {
  type        = string
  description = "name of the function zip file"

}

#pub-sub:
variable "pubsub_topic" {
  type        = string
  description = "name of the pubsub topic"

}

variable "pubsub_subscription" {
  type        = string
  description = "name of the subscription"

}