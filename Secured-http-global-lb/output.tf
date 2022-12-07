output "External_ip" {
  value = "http://${module.global-http-lb.External_IP}"
}
output "nginx_backend" {
  value = "http://${module.global-http-lb.External_IP}/nginx"
}