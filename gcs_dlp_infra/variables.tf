#Defaults:
variable "credentials" {
  description = "Json credential file for authorization"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Resources deployment zone"
  type        = string
}

variable "zone" {
  description = "Resources deployment zone"
  type        = string
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

variable "sensitive_bucket" {
  type        = string
  description = "Name of the sensitive bucket"

}

variable "function_bucket" {
  type        = string
  description = "name of the function bucket"
}

variable "source_function" {
  type        = string
  description = "source python function file"

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

#pub-sub:
variable "pubsub_topic" {
  type        = string
  description = "name of the pubsub topic"

}

variable "pubsub_subscription" {
  type        = string
  description = "name of the subscription"

}

#function-gcs:
variable "function-gcs" {
  type        = string
  description = "name of the object trigger function"

}

#pubsub function:
variable "function-pubsub" {
  type        = string
  description = "name of the pubsub triger function"

}