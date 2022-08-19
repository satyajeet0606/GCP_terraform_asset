provider "google" {
    credentials = file("aa.json")
    project = var.project
    region = var.region
    zone = var.zone
  
}
provider "google-beta" {
    credentials = file("aa.json")
    project = var.project
    region = var.region
    zone = var.zone

}

#Reserving IP:
resource "google_compute_global_address" "global-address" {
    provider = google-beta
    name = "my-address"
    ip_version = "IPV4"
    address_type = "EXTERNAL"
  
}

#Creating http proxy:
resource "google_compute_target_http_proxy" "target-http" {
    provider = google-beta
    name = "my-target"
    url_map = google_compute_url_map.url-map.id

  }

#Creating forwarding rule:
resource "google_compute_global_forwarding_rule" "forwarding-rule" {
    provider = google-beta
    name = "my-rule"
    port_range = "80"
    ip_protocol = "TCP"
    load_balancing_scheme = "EXTERNAL"
    target = google_compute_target_http_proxy.target-http.id
    ip_address = google_compute_global_address.global-address.address
    
  }

#Creating url map:
resource "google_compute_url_map" "url-map" {
    provider = google-beta
    name = "my-url"
    default_service = google_compute_backend_bucket.backend-bucket.id
  
}

#Creating storage bucket:
resource "google_storage_bucket" "my-bucket" {
  provider = google-beta
  name = "my-06-bucket"
  location = var.location
  uniform_bucket_level_access = true
  storage_class = "STANDARD"

  
  //delete bucket:
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page = "404.html"
  }
  
}

#Making the storage bucket public:
resource "google_storage_bucket_iam_member" "iam-bucket" {
  bucket = google_storage_bucket.my-bucket.name
  role = "roles/storage.objectViewer"
  member = "allUsers"  
}

#Index html page:
resource "google_storage_bucket_object" "index_page" {
  provider = google-beta
  name = "index.html"
  source = "index.html"
  bucket = google_storage_bucket.my-bucket.name
  depends_on = [
    local_file.index_page
  ]
   
}

#error page for html:
resource "google_storage_bucket_object" "error_page" {
  provider = google-beta
  name = "404.html"
  source = "404.html"
  bucket = google_storage_bucket.my-bucket.name
  depends_on = [
    local_file.error_page
  ]
 
}


#index-page:
resource "local_file" "index_page" {
  filename = "index.html"
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

#error page:
resource "local_file" "error_page" {
  filename = "404.html"
  content = <<-EOT
  <html>
  <body>
  <h1>Error 404:Not available</h1>
  </body>
  </html>
  EOT
}

#Creating Backend Bucket:
resource "google_compute_backend_bucket" "backend-bucket" {
    provider = google-beta
    name = "my-backend-bucket"
    bucket_name = google_storage_bucket.my-bucket.name
    enable_cdn = true  

    
    cdn_policy {
        cache_mode = "CACHE_ALL_STATIC" 
        client_ttl = 3600
        default_ttl = 3600
        max_ttl = 86400
        negative_caching = true
        serve_while_stale = 86400
    }
       
}












