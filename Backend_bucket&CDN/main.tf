terraform {
  required_version = ">=0.12.0"
  required_providers {
    google      = ">=2.11.0"
    google-beta = ">=2.13"
  }
}

provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
  zone        = var.zone

}
provider "google-beta" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
  zone        = var.zone

}

#Reserving IP:
resource "google_compute_global_address" "terraform_test_global_address" {
  provider     = google-beta
  name         = var.terraform_global_address
  ip_version   = "IPV4"
  address_type = "EXTERNAL"

}

#Creating http proxy:
resource "google_compute_target_http_proxy" "terraform_test_target_http_proxy" {
  provider = google-beta
  name     = var.terraform_target_http_proxy
  url_map  = google_compute_url_map.terraform_test_url_map.id

}

#Creating forwarding rule:
resource "google_compute_global_forwarding_rule" "terraform_test_forwarding_rule" {
  provider              = google-beta
  name                  = var.terraform_forwarding_rule
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_http_proxy.terraform_test_target_http_proxy.id
  ip_address            = google_compute_global_address.terraform_test_global_address.address

}

#Creating url map:
resource "google_compute_url_map" "terraform_test_url_map" {
  provider        = google-beta
  name            = var.terraform_url_map
  default_service = google_compute_backend_bucket.terraform_test_backend_bucket.id

}

#Creating storage bucket:
resource "google_storage_bucket" "terraform_test_bucket" {
  provider                    = google-beta
  name                        = var.terraform_gcs_bucket
  location                    = var.location
  uniform_bucket_level_access = true
  storage_class               = var.storage_class


  //delete bucket:
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

}

#Making the storage bucket public:
resource "google_storage_bucket_iam_member" "terraform_gcs_bucket_iam_member" {
  bucket = google_storage_bucket.terraform_test_bucket.name
  role   = var.bucket_iam_policy
  member = "allUsers"
}

#Index html page:
resource "google_storage_bucket_object" "terraform_test_index_page" {
  provider = google-beta
  name     = var.terraform_index_page
  bucket   = google_storage_bucket.terraform_test_bucket.name

  content = <<-EOT
  <html>
<head>
<style>
h1{text-align: Left;}
</style>
</head>
<body>
<h1 style="color:black;style="font-family:verdana;">Let's see how CDN works..!!</h1>
<video width="500px" height="500px" 
        controls="controls"/> 
          
        <source src="vid.mp4" 
            type="video/mp4"> 
    </video>
  EOT

}

#error page for html:
resource "google_storage_bucket_object" "terraform_test_error_page" {
  provider = google-beta
  name     = var.terraform_error_page
  bucket   = google_storage_bucket.terraform_test_bucket.name

  content = <<-EOT
  <html>
  <body>
  <h1>Error 404:Not available</h1>
  </body>
  </html>
  EOT


}


#Creating Backend Bucket:
resource "google_compute_backend_bucket" "terraform_test_backend_bucket" {
  provider    = google-beta
  name        = var.terraform_backend_bucket
  bucket_name = google_storage_bucket.terraform_test_bucket.name
  enable_cdn  = true


  cdn_policy {
    cache_mode        = "CACHE_ALL_STATIC"
    client_ttl        = 3600
    default_ttl       = 3600
    max_ttl           = 86400
    negative_caching  = true
    serve_while_stale = 86400
  }

}





