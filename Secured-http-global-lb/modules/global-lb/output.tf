output "External_IP" {
  value = google_compute_global_address.static_ip.address
}