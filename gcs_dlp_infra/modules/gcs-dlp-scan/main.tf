# Grant DLP permissions to app engine  service account
resource "google_project_iam_member" "set_dlp_roles" {
  project = var.project_id
  count   = length(var.dlp_rolesList)
  role    = var.dlp_rolesList[count.index]
  member  = "serviceAccount:lunar-subject-364714@appspot.gserviceaccount.com"
}

#Giving viewer role to the dlp service account:
resource "google_project_iam_member" "set_viewer_role" {
  project = var.project_id
  role    = var.dlp_role
  member  = "serviceAccount:service-551370288252@dlp-api.iam.gserviceaccount.com"
}

#staging bucket:
resource "google_storage_bucket" "staging" {
  name          = var.staging_bucket
  location      = var.location
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  public_access_prevention = var.public_access_prevention
}

#sensitive bucket:
resource "google_storage_bucket" "sensitive" {
  name          = var.sensitive_bucket
  location      = var.location
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  public_access_prevention = var.public_access_prevention
}

#Pubsub - topic:
resource "google_pubsub_topic" "pubsub_topic" {
  name    = var.pubsub_topic
  project = var.project_id
}

#pubsub-suscription:
resource "google_pubsub_subscription" "pubsub_subscription" {
  name  = var.pubsub_subscription
  topic = google_pubsub_topic.pubsub_topic.name

}


