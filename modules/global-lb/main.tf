resource "google_compute_global_forwarding_rule" "http" {
  count      = var.forward_http ? 1 : 0
  name       = "${var.lb_name}-http-fwd-rule"
  ip_address = google_compute_global_address.static_ip.id
  target     = google_compute_target_http_proxy.http_target_proxy[0].self_link
  port_range = var.forward_http_port_range
}

#forwarding rule for HTTPS
resource "google_compute_global_forwarding_rule" "https" {
  count      = var.forward_https ? 1 : 0
  name       = "${var.lb_name}-https-fwd-rule"
  ip_address = google_compute_global_address.static_ip.address
  target     = google_compute_target_https_proxy.https_target_proxy[0].self_link
  port_range = var.forward_https_port_range
}

#External IP
resource "google_compute_global_address" "static_ip" {
  name        = "${var.lb_name}-static-address"
  ip_version = var.ip_version
  address_type = var.address_type
}

#HTTP proxy 
resource "google_compute_target_http_proxy" "http_target_proxy" {
  count   = var.forward_http ? 1 : 0
  name    = "${var.lb_name}-http-proxy"
  url_map = google_compute_url_map.url_map.id
}
#HTTPS proxy with ssl certificate
resource "google_compute_target_https_proxy" "https_target_proxy" {
  count            = var.forward_https ? 1 : 0
  name             = "${var.lb_name}-https-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [google_compute_ssl_certificate.ssl_certificates[0].id]
}
#SSL certificate
resource "google_compute_ssl_certificate" "ssl_certificates" {
  count       = var.forward_https ? 1 : 0
  name        = "${var.lb_name}-ssl-certificate"
  private_key = file(var.private_key)
  certificate = file(var.certificate)
}

#url-map
resource "google_compute_url_map" "url_map" {
  name            = "${var.lb_name}-http"
  default_service = google_compute_backend_service.test_backend_service[0].id

  host_rule {
    hosts        = ["mysite.com"]
    path_matcher = "mysite"
  }


  path_matcher {
    name            = "mysite"
    default_service = google_compute_backend_service.test_backend_service[0].self_link

    path_rule {
      paths   = ["/nginx"]
      service = google_compute_backend_service.test_backend_service[1].self_link
    }
  }  
}

#backend services
resource "google_compute_backend_service" "test_backend_service" {
  count         = length(var.instance_group_url)
  name          = "${var.lb_name}-service-${count.index + 1}"
  protocol      = var.backend_service_protocol
  port_name     = var.backend_service_port
  health_checks = [google_compute_health_check.http_health_check.id]
  security_policy = google_compute_security_policy.backend_security_policy.id
  enable_cdn    = var.enable_cdn
  backend {
    group = var.instance_group_url[count.index]
  }
}

#health check for load balancer
resource "google_compute_health_check" "http_health_check" {
  name = "${var.lb_name}-http-health-check"
  http_health_check {
    port = var.health_check_port
  }
}

#Compute Security policy:
resource "google_compute_security_policy" "backend_security_policy" {
  name = var.backend_security_policy
 
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Deny access to all by default"
  }

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.ip_whitelist
      }
    }
    description = "allow access to the specific IP's as needed"
  }
}

