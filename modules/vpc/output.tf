output "vpc_id" {
  value = google_compute_network.terraform_vpc.id
}
output "vpc_subnet_self_link1" {
  value = google_compute_subnetwork.terraform_subnet[0].self_link
}
output "vpc_subnets_names" {
  value = google_compute_subnetwork.terraform_subnet.*.name
}
output "vpc_subnet_regions" {
  value = google_compute_subnetwork.terraform_subnet.*.region[*]
}
output "network_tags" {
  value = google_compute_firewall.pre_populated.*.target_tags
}
output "icmp_tag" {
  value = google_compute_firewall.allow_icmp.target_tags
}
output "http_tag" {
  value = google_compute_firewall.pre_populated[0].target_tags
}
output "https_tag" {
  value = google_compute_firewall.pre_populated[1].target_tags
}
output "ssh_tag" {
  value = google_compute_firewall.pre_populated[2].target_tags
}
output "rdp_tag" {
  value = google_compute_firewall.pre_populated[3].target_tags
}
output "health_tag" {
  value = google_compute_firewall.allow_health_check.target_tags
}