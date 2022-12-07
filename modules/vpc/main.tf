#Creating custom VPC:
resource "google_compute_network" "terraform_vpc" {
  name                            = var.terraform_vpc
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

#creating custom-subnets:
resource "google_compute_subnetwork" "terraform_subnet" {
  count                    = length(var.terraform_subnets)
  name                     = var.terraform_subnets[count.index]
  ip_cidr_range            = var.cidr_ranges[count.index]
  region                   = var.subnet_regions[count.index]
  network                  = google_compute_network.terraform_vpc.id
}

#creating prepopulated firewall:
resource "google_compute_firewall" "pre_populated" {
  count   = length(var.pre_populated)
  name    = "${var.terraform_vpc}-allow-${var.pre_populated[count.index]}"
  network = google_compute_network.terraform_vpc.id
  allow {
    protocol = var.protocol
    ports    = ["${var.ports[count.index]}"]
  }
  priority      = "65534"
  source_ranges = ["${var.allowed_range}"]
  target_tags   = ["allow-${var.pre_populated[count.index]}"]
}

#Creating firewall for icmp rule:
resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.terraform_vpc}-allow-icmp"
  network = google_compute_network.terraform_vpc.id
  allow {
    protocol = "icmp"
  }
  priority      = "65534"
  source_ranges = ["${var.allowed_range}"] //allowed 0.0.0.0/0 given default
  target_tags   =  ["allow-icmp"]
}

#Creating firewall for the internal communication between vm's:
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.terraform_vpc}-allow-internal"
  network = google_compute_network.terraform_vpc.id
  allow {
    protocol = "all"
  }
  priority = 65534
  source_ranges = var.internal_source_range
  
}

#Creating health check firewall:
#health check firewall rule
resource "google_compute_firewall" "allow_health_check" {
  name      = "${var.terraform_vpc}-allow-health-check"
  network   =  google_compute_network.terraform_vpc.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]
}

