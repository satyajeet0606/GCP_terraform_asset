credentials = "CZED.json"
project_id  = "ms-gcp-g-i-cze-d-dev"
region      = "europe-north1"
zone        = "europe-north1-a"

#vpc-network:
terraform_vpc                   = "test-vpc"
auto_create_subnetworks         = false
delete_default_routes_on_create = false

#subnets:
terraform_subnets = ["vpc-sub-1", "vpc-sub-2"]
subnet_regions    = ["europe-north1", "us-west1"]
cidr_ranges       = ["10.0.0.0/24", "10.1.0.0/24"]

#Pre-populalted Firewall:
pre_populated = ["http", "https", "rdp", "ssh"]
protocol      = "tcp"
ports         = ["80", "443", "3389", "22"]
allowed_range = "0.0.0.0/0"

#Instance Template:
terraform_template  = ["test-temp-1", "test-temp-2"]
machine_type        = "f1-micro"
auto_delete         = true
automatic_restart   = true
source_image        = "projects/debian-cloud/global/images/family/debian-11"
on_host_maintenance = "MIGRATE"

#instance_group & autoscaler:
migs               = ["mig-1", "mig-2"]
max_replicas       = "3"
min_replicas       = "1"
cooldown_period    = "60"
target_utilization = ".8"

#backend Service:
lb_name                  = "test-backend"
forward_http             = true
forward_http_port_range  = "80"
forward_https            = false
forward_https_port_range = "443"
ip_version               = "IPV4"
enable_cdn               = true
address_type             = "EXTERNAL"

#SSL 
private_key = "Private key path"
certificate = "SSL certificate path"

#backend-service:
backend_service_protocol = "HTTP"
backend_service_port     = "http"
health_check_port        = "80"

