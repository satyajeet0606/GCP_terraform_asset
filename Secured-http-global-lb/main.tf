module "custom-vpc" {
  source                          = "./modules/vpc"
  terraform_vpc                   = var.terraform_vpc
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_routes_on_create
  terraform_subnets               = var.terraform_subnets
  cidr_ranges                     = var.cidr_ranges
  subnet_regions                  = var.subnet_regions
  pre_populated                   = var.pre_populated
  protocol                        = var.protocol
  ports                           = var.ports
  allowed_range                   = var.allowed_range
  internal_source_range           = var.cidr_ranges

}

module "managed-group" {
  source = "./modules/mig's"
  depends_on = [
    module.custom-vpc
  ]
  migs                = var.migs
  terraform_template  = var.terraform_template
  template_region     = module.custom-vpc.vpc_subnet_regions
  machine_type        = var.machine_type
  automatic_restart   = var.automatic_restart
  on_host_maintenance = var.on_host_maintenance
  source_image        = var.source_image
  auto_delete         = var.auto_delete
  network_tags        = concat(tolist(module.custom-vpc.icmp_tag), tolist(module.custom-vpc.rdp_tag), tolist(module.custom-vpc.ssh_tag), tolist(module.custom-vpc.https_tag), tolist(module.custom-vpc.http_tag), tolist(module.custom-vpc.health_tag))
  subnets             = module.custom-vpc.vpc_subnets_names
  mig_zone            = module.custom-vpc.vpc_subnet_regions
  max_replicas        = var.max_replicas
  min_replicas        = var.min_replicas
  cooldown_period     = var.cooldown_period
  target_utilization  = var.target_utilization

}

module "global-http-lb" {
  depends_on = [
    module.managed-group
  ]
  source                   = "./modules/global-lb"
  lb_name                  = var.lb_name
  forward_http             = var.forward_http
  forward_http_port_range  = var.forward_http_port_range
  forward_https            = var.forward_https
  forward_https_port_range = var.forward_https_port_range
  instance_group_url       = module.managed-group.instance_group_url
  ip_version               = var.ip_version
  address_type             = var.address_type
  backend_service_protocol = var.backend_service_protocol
  backend_service_port     = var.backend_service_port
  enable_cdn               = var.enable_cdn
  health_check_port        = var.health_check_port
  private_key              = var.private_key
  certificate              = var.certificate

}


