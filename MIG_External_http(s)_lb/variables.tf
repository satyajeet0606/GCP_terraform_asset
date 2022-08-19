variable "project" {
  type        = string
  description = "GCP project ID"

}
variable "credentials" {
  type        = string
  description = "Json credential file"

}
variable "region" {
  type        = string
  description = "Region of the resource allotment"

}
variable "zone" {
  type        = string
  description = "zone of resource deployment"

}
variable "terraform_vpc" {
  type        = string
  description = "network resource"

}
variable "terraform_subnet" {
  type        = string
  description = "VPC subnetwork"

}
variable "test_cidr_range" {
  type        = string
  description = "cidr IP network range"

}
variable "terraform_subnet_02" {
  type    = string
  default = "VPC subnetwork"

}
variable "test_cidr_range_02" {
  type        = string
  description = "cidr IP address range"

}
variable "terraform_firewall" {
  type        = string
  description = "Enter a firewall name"

}
variable "test_source_ranges" {
  type        = list(string)
  description = "cidr IP address range"

}
variable "terraform_template" {
  type        = string
  description = "name of the test instance template"

}
variable "machine_type" {
  type        = string
  description = "name of the vm machine type"

}
variable "terraform_instance_group" {
  type        = string
  description = "name of the test instance group"

}
variable "terraform_autoscaler" {
  type        = string
  description = "name of the autoscaler"

}
variable "terraform_health_check" {
  type        = string
  description = "name of the health check"

}
variable "terraform_template_02" {
  type        = string
  description = "name of the test instance template"

}
variable "region_02" {
  type        = string
  description = "region of resource allotment"

}
variable "terraform_instance_group_02" {
  type        = string
  description = "name of the test instance group"

}
variable "zone_02" {
  type        = string
  description = "zone of resource deployment"

}
variable "terraform_autoscaler_02" {
  type        = string
  description = "name of the autoscaler"

}
variable "terraform_global_address" {
  type        = string
  description = "name of the reserved global IP address"

}
variable "terraform_target_proxy" {
  type        = string
  description = "name of the target http proxy"

}
variable "terraform_forwarding_rule" {
  type        = string
  description = "name of the forwarding rule"

}
variable "terraform_load_balancer" {
  type        = string
  description = "name of the load balancer service"

}
variable "terraform_backend" {
  type        = string
  description = "name of the attached backend service"

}
