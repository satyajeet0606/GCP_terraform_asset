output "instance_group_url" {
    value = google_compute_instance_group_manager.terraform_instance_group.*.instance_group
  
}