#forward_http:
variable "forward_http" {
    description = "If given true creates http based forwarding rule"
    type = bool
}
 variable "forward_http_port_range" {
    description = "http forwarding rule port range"
    type = string   
}

#Forward https:
variable "forward_https" {
    description = "If given true creates https based forwarding rule"
    type = bool
  
}
variable "forward_https_port_range" {
    description = "https forwarding rule"
    type = string
}

#Static externl IP:
variable "ip_version" {
    description = "IP version specification as http/https"
    type = string
}
variable "address_type" {
    description = "address type specification external/internal"
    type = string  
}

#ssl certificate:
variable "private_key" {
    description = "private key path"
    type = string  
}
variable "certificate" {
    description = "SSL certificate path"
    type = string  
}

#Backend-service:
variable "instance_group_url" {
    description = "url for the instance group created in output.tf"
    type = list(string)
  
}
variable "lb_name" {
    description = "name of the lb backend service"
    type = string
  
}
variable "backend_service_protocol" {
    description = "port number for the description"
    type = string  
}

variable "backend_service_port" {
    description = "backend service port name"
    type = string
}

variable "enable_cdn" {
    description = "if set to true will enable caching"
    type = bool
}

#health-check:
variable "health_check_port" {
    description = "health check port value"
    type = string  
}

#security policy:
variable "backend_security_policy" {
    description = "name of the backend security policy"
    type = string
    default = "test-security-policy"
  
}

variable "ip_whitelist" {
    description = "ip address to allow access"
    type = list(string)
    default = ["9.9.9.0/24"]
  
}