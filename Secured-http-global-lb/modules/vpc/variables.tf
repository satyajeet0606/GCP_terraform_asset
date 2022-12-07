#VPC-Network:
variable "terraform_vpc" {
  description = "Name for the vpc network"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Boolean value whether to create auto mode subnets"
  type        = bool
}

variable "delete_default_routes_on_create" {
  description = "Boolean value for deleting default routes on create"
  type        = bool
  default     = false
}

#Subnets:
variable "terraform_subnets" {
  description = "Name of the subnets to be created"
  type        = list(string)
}
variable "cidr_ranges" {
  description = "cidr range list"
  type        = list(string)
}
variable "subnet_regions" {
  description = "list of subnet regions"
  type        = list(string)
}

#Firewalls:
variable "pre_populated" {
  description = "Pre-populated firewall rules"
  type        = list(string)
}
variable "protocol" {
  description = "protocols to enable"
  type        = string
  
}
variable "ports" {
  description = "ports for each protocol"
  type        = list(string)
}
variable "allowed_range" {
  description = "allowed range here it is for public"
  type        = string
   
}
variable "internal_source_range" {
    description = "Source IP for internal traffic"
    type = list(string)
  
}

