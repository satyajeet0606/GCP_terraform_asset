#Creating the instance template:
resource "google_compute_instance_template" "terraform_test_template" {
  count        = length(var.migs)
  name         = var.terraform_template[count.index]
  region       = var.template_region[count.index]
  machine_type = var.machine_type
  scheduling {
    automatic_restart   = var.automatic_restart
    on_host_maintenance = var.on_host_maintenance
  }
  disk {
    source_image = var.source_image
    auto_delete  = var.auto_delete
  }
  tags = var.network_tags
  network_interface {
    subnetwork = var.subnets[count.index]
    access_config {
    }
  }
  metadata = {
    startup-script = "#! /bin/bash\n     sudo apt-get update\n     sudo apt-get install nginx -y\n"
  }
}

#Creating the instance groups:
resource "google_compute_instance_group_manager" "terraform_instance_group" {
  count              = length(var.migs)
  name               = var.migs[count.index]
  base_instance_name = "backend-mig-${count.index + 1}"
  version {
    name              = "mig-template-${count.index + 1}"
    instance_template = google_compute_instance_template.terraform_test_template[count.index].id
  }
  //not multizonal.
  zone = "${var.mig_zone[count.index]}-b"
}
resource "google_compute_autoscaler" "autoscaler" {
  count  = length(var.migs)
  name   = "${var.migs[count.index]}-autoscaler"
  target = google_compute_instance_group_manager.terraform_instance_group[count.index].instance_group
  zone   = "${var.mig_zone[count.index]}-b"

  autoscaling_policy {
    max_replicas    = var.max_replicas   
    min_replicas    = var.min_replicas   
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.target_utilization 
    }
  }
}