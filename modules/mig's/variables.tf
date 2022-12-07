#instance template:
variable "terraform_template" {
  description = "Enter tempalte names"
  type        = list(string)
}
variable "template_region" {
  description = "Enter tempalte names"
  type        = list(string)
}
variable "subnets" {
  description = "Enter subnets for vpc network"
  type        = list(string)
}
variable "machine_type" {
  description = "Enter machine type for template"
  type        = string
 
}
variable "automatic_restart" {
  description = "Enter true/false"
  type        = bool
  
}
variable "on_host_maintenance" {
  description = "Enter what to do on maintenance"
  type        = string
  
}
variable "source_image" {
  description = "Enter source image "
  type        = string

}
variable "auto_delete" {
  description = "Enter true/false"
  type        = bool

}
variable "network_tags" {
  description = "Enter network tags to attach"
  type        = list(string)
}

#Instance group & autoscaler:
variable "migs" {
  description = "Enter migs to be created"
  type        = list(string)
}
variable "mig_zone" {
  description = "Enter zone for template"
  type        = list(string)
}
variable "max_replicas" {
  description = "Enter zone for template"
  type        = number
  default     = 2
}
variable "min_replicas" {
  description = "Enter zone for template"
  type        = number
  default     = 1
}
variable "cooldown_period" {
  description = "Enter zone for template"
  type        = number
  default     = 45
}
variable "target_utilization" {
  description = "Enter zone for template"
  type        = number
  default     = 0.8
}
