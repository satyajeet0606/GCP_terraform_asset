variable "credentials" {
  type        = string
  description = "credential Json file"

}

variable "project_id" {
  type        = string
  description = "GCP project ID"

}

variable "region" {
  type        = string
  description = "Region of deployment"

}

variable "zone" {
  type        = string
  description = "Zone of deployment"

}

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

#Pre-populated Firewall:
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
  description = "Allowed traffic range"
  type        = string

}

#Instance template:
variable "terraform_template" {
  description = "Enter tempalte names"
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

#Instance group & autoscaler:
variable "migs" {
  description = "Enter migs to be created"
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

#forward_http:
variable "forward_http" {
  description = "If given true creates http based forwarding rule"
  type        = bool
}
variable "forward_http_port_range" {
  description = "http forwarding rule port range"
  type        = string
}

#Forward https:
variable "forward_https" {
  description = "If given true creates https based forwarding rule"
  type        = bool

}
variable "forward_https_port_range" {
  description = "https forwarding rule"
  type        = string
}

#Static externl IP:
variable "ip_version" {
  description = "IP version specification as http/https"
  type        = string
}
variable "address_type" {
  description = "address tyoe specification external/internal"
  type        = string
}

#ssl certificate:
variable "private_key" {
  description = "private key path"
  type        = string
}
variable "certificate" {
  description = "SSL certificate path"
  type        = string
}

#Backend-service:
variable "lb_name" {
  description = "name of the lb backend service"
  type        = string

}
variable "backend_service_protocol" {
  description = "port number for the description"
  type        = string
}

variable "backend_service_port" {
  description = "backend service port name"
  type        = string
}

variable "enable_cdn" {
  description = "if set to true will enable caching"
  type        = bool
}

#health-check:
variable "health_check_port" {
  description = "health check port value"
  type        = string
}

