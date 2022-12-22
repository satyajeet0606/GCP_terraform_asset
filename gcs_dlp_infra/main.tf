module "gcs-infra" {
  source                   = "./modules/gcs-dlp-scan"
  project_id               = var.project_id
  dlp_role                 = var.dlp_role
  dlp_rolesList            = var.dlp_rolesList
  staging_bucket           = var.staging_bucket
  sensitive_bucket         = var.sensitive_bucket
  location                 = var.location
  force_destroy            = var.force_destroy
  storage_class            = var.storage_class
  public_access_prevention = var.public_access_prevention
  pubsub_topic             = var.pubsub_topic
  pubsub_subscription      = var.pubsub_subscription
  
}

