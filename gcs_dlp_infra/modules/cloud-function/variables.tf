variable "function_bucket" {
  type        = string
  description = "name of the function bucket"
}

variable "storage_class" {
  type        = string
  description = "storage class of the object"

}

variable "location" {
  type        = string
  description = "location of the object being stored"

}

variable "force_destroy" {
  type        = string
  description = "if given true buckets with objects can be deleted"

}

variable "public_access_prevention" {
  type        = string
  description = "whether to enforce public prevention"

}

variable "source_function" {
  type        = string
  description = "source python function file"

}

#function-gcs trigger:
variable "function-gcs" {
  type        = string
  description = "name of the object trigger function"

}

variable "function_trigger_resource" {
  type        = string
  description = "function trigger resource"

}

#pubsub function:
variable "function-pubsub" {
  type        = string
  description = "name of the pubsub triger function"

}
variable "project_id" {
  type        = string
  description = "project id description"
}

variable "pubsub_topic" {
  type        = string
  description = "name of the pubsub topics"

}