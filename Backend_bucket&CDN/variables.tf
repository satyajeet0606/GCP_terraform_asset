variable "project" {
  type        = string
  description = "GCP Project ID"

}
variable "credentials" {
  type        = string
  description = "GCP service account json credential file"

}
variable "region" {
  type        = string
  description = "Region of the resource deployment"

}
variable "zone" {
  type        = string
  description = "zone of the resource deployment"
}
variable "terraform_global_address" {
  type        = string
  description = "Reserved global IP address"

}
variable "terraform_target_http_proxy" {
  type        = string
  description = "Load balancer target http Proxy"

}
variable "terraform_forwarding_rule" {
  type        = string
  description = "Global Forwarding rule"

}
variable "terraform_url_map" {
  type        = string
  description = "Load balancer URL map"

}
variable "terraform_gcs_bucket" {
  type        = string
  description = "Cloud Storage Bucket"

}
variable "storage_class" {
  type        = string
  description = "GCS Object storage class"

}
variable "location" {
  type        = string
  description = "Region of GCS bucket"

}
variable "terraform_backend_bucket" {
  type        = string
  description = "GCS backend bucket"

}
variable "bucket_iam_policy" {
  type        = string
  description = "GCS bucket IAM policy"

}
variable "terraform_index_page" {
  type        = string
  description = "html index page"

}
variable "terraform_error_page" {
  type        = string
  description = "html error page(404 not found)"

}
