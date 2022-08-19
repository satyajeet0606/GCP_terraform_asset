terraform {
  required_version = ">=0.12.0"
  required_providers {
    google      = ">=2.11.0"
    google-beta = ">=2.13"
  }
}

//Provider block:
provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone

}

provider "google-beta" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone

}

#Creating VPC network:
resource "google_compute_network" "terraform_test_vpc" {
  provider                = google-beta
  name                    = var.terraform_vpc
  auto_create_subnetworks = false

}

#Creating Subnet1:
resource "google_compute_subnetwork" "terraform_test_subnet" {
  provider      = google-beta
  name          = var.terraform_subnet
  region        = var.region
  ip_cidr_range = var.test_cidr_range
  network       = google_compute_network.terraform_test_vpc.id

}

#Creating Subnet2:
resource "google_compute_subnetwork" "terraform_test_subnet_02" {
  provider      = google-beta
  name          = var.terraform_subnet_02
  region        = var.region_02
  ip_cidr_range = var.test_cidr_range_02
  network       = google_compute_network.terraform_test_vpc.id

}

#Creating the firewall rule:
resource "google_compute_firewall" "terraform-test-firewall" {
  provider      = google-beta
  name          = var.terraform_firewall
  network       = google_compute_network.terraform_test_vpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = var.test_source_ranges
  target_tags   = ["allow-health-check"]

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

}

#Creating instance template1:
resource "google_compute_instance_template" "terraform_test_template" {
  provider     = google-beta
  name         = var.terraform_template
  region       = var.region
  machine_type = var.machine_type

  tags           = ["allow-health-check"]
  can_ip_forward = true

  //boot-disk:
  disk {
    auto_delete  = true
    boot         = true
    mode         = "READ_WRITE"
    source_image = "projects/debian-cloud/global/images/family/debian-11"
    type         = "PERSISTENT"
  }

  //Startup-script:
  metadata = {
    startup-script = "#! /bin/bash\n     sudo apt-get update\n     sudo apt-get install apache2 -y\n"
  }

  //network-interface:
  network_interface {
    network    = google_compute_network.terraform_test_vpc.id
    subnetwork = google_compute_subnetwork.terraform_test_subnet.id
    access_config {
      network_tier = "Premium"
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  lifecycle {
    create_before_destroy = true
  }

}

#creating instance group1:
resource "google_compute_instance_group_manager" "terraform_instance_group" {
  provider = google-beta
  name     = var.terraform_instance_group
  zone     = var.zone

  named_port {
    name = "http"
    port = 80
  }

  //adding template:
  version {
    instance_template = google_compute_instance_template.terraform_test_template.id
    name              = "primary"
  }

  //base instance details:
  base_instance_name = "vm-06"

  //autohealing policy:
  auto_healing_policies {
    health_check      = google_compute_health_check.terraform_health_check.id
    initial_delay_sec = 300
  }

}

#Creating Autoscaler:
resource "google_compute_autoscaler" "terraform_test_autoscaler" {
  provider = google-beta
  name     = var.terraform_autoscaler
  zone     = var.zone
  target   = google_compute_instance_group_manager.terraform_instance_group.instance_group

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.8
    }
  }

}

#Creating health check:
resource "google_compute_health_check" "terraform_health_check" {
  provider            = google-beta
  name                = var.terraform_health_check
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port               = 80
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
}

#Creating instance template2:
resource "google_compute_instance_template" "terraform_test_template_02" {
  provider     = google-beta
  name         = var.terraform_template_02
  region       = var.region_02
  machine_type = var.machine_type

  tags           = ["allow-health-check"]
  can_ip_forward = true

  //boot-disk:
  disk {
    auto_delete  = true
    boot         = true
    mode         = "READ_WRITE"
    source_image = "projects/debian-cloud/global/images/family/debian-11"
    type         = "PERSISTENT"
  }

  //Startup-script:
  metadata = {
    startup-script = "#! /bin/bash\n     sudo apt-get update\n     sudo apt-get install apache2 -y\n"
  }

  //network-interface:
  network_interface {
    network    = google_compute_network.terraform_test_vpc.id
    subnetwork = google_compute_subnetwork.terraform_test_subnet_02.id
    access_config {
      network_tier = "Premium"
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  lifecycle {
    create_before_destroy = true
  }

}

#creating instance group2:
resource "google_compute_instance_group_manager" "terraform_test_instance_group_02" {
  provider = google-beta
  name     = var.terraform_instance_group_02
  zone     = var.zone_02

  named_port {
    name = "http"
    port = 80
  }

  //adding template:
  version {
    instance_template = google_compute_instance_template.terraform_test_template_02.id
    name              = "primary"
  }

  //base instance details:
  base_instance_name = "vm-08"

  //Autohealing policy:
  auto_healing_policies {
    health_check      = google_compute_health_check.terraform_health_check.id
    initial_delay_sec = 300
  }

}

#Creating Auto-Scaler:
resource "google_compute_autoscaler" "terraform_test_autoscaler-02" {
  provider = google-beta
  name     = var.terraform_autoscaler_02
  zone     = var.zone_02
  target   = google_compute_instance_group_manager.terraform_test_instance_group_02.instance_group

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.8
    }
  }

}


#Reserving global IP for LB:
resource "google_compute_global_address" "terraform_test_global_address" {
  provider     = google-beta
  name         = var.terraform_global_address
  ip_version   = "IPV4"
  address_type = "EXTERNAL"

}

#Creating target proxy:
resource "google_compute_target_http_proxy" "terraform_test_target_proxy" {
  provider = google-beta
  name     = var.terraform_target_proxy
  url_map  = google_compute_url_map.terraform_test_load_balancer.id

}

#Creating Forwarding rule:
resource "google_compute_global_forwarding_rule" "terraform_test_forwarding_rule" {
  provider              = google-beta
  name                  = var.terraform_forwarding_rule
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_protocol           = "HTTP"
  target                = google_compute_target_http_proxy.terraform_test_target_proxy.id
  ip_address            = google_compute_global_address.terraform_test_global_address.id

}

#Creating URL map:
resource "google_compute_url_map" "terraform_test_load_balancer" {
  provider        = google-beta
  name            = var.terraform_load_balancer
  default_service = google_compute_backend_service.terraform_test_backend.id

}

#Creating Backend service:
resource "google_compute_backend_service" "terraform_test_backend" {
  provider                        = google-beta
  name                            = var.terraform_backend
  port_name                       = "http"
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  connection_draining_timeout_sec = 0
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  enable_cdn                      = true

  health_checks = [google_compute_health_check.terraform_health_check.id]
  security_policy = google_compute_security_policy.terraform_test_security_policy.id

  backend {
    group           = google_compute_instance_group_manager.terraform_instance_group.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 0.8
  }

  backend {
    group           = google_compute_instance_group_manager.terraform_test_instance_group_02.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 0.8
  }

}

#Creating Cloud Armor Security policies:
resource "google_compute_security_policy" "terraform_test_security_policy" {
  name        = var.terraform_security_policy
  description = "example security policy"

  //Reject all traffic that hasn't been whitelisted.
  rule {
    action   = "deny(403)"
    priority = "2147483647"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.ip_blacklist
      }
    }

    description = "Default rule, higher priority overrides it"
  }

  //Allow traffic from certain ip address
  rule {
    action   = "allow"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.ip_whitelist
      }
    }

    description = "allow traffic from required Range"
  }
}
