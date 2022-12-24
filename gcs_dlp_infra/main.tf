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

module "dlp-function" {
  source = "./modules/cloud-function"
  depends_on = [
    module.gcs-infra
  ]
  function_bucket           = var.function_bucket
  location                  = var.location
  force_destroy             = var.force_destroy
  storage_class             = var.storage_class
  public_access_prevention  = var.public_access_prevention
  source_function           = var.source_function
  function-gcs              = var.function-gcs
  function_trigger_resource = module.gcs-infra.staging-bucket
  function-pubsub           = var.function-pubsub
  project_id                = var.project_id
  pubsub_topic              = var.pubsub_topic
}

