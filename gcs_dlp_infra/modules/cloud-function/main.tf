#function bucket:
resource "google_storage_bucket" "function_bucket" {
  name          = var.function_bucket
  location      = var.location
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  public_access_prevention = var.public_access_prevention

}

#source-object:
resource "google_storage_bucket_object" "source-function" {
  name   = var.source_function
  source = "../source-dlp.zip"
  bucket = google_storage_bucket.function_bucket.name

}

#function - GCS trigger:
resource "google_cloudfunctions_function" "function" {
  name        = var.function-gcs
  description = "Function to be triggered on object upload"
  runtime     = "python37"

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.source-function.name

  entry_point = "create_DLP_job"
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.function_trigger_resource
  }

  environment_variables = {
    PROJECT_ID       = "banded-operator-370512"
    STAGING_BUCKET   = "quar-1999"
    SENSITIVE_BUCKET = "sens-1999"
    PUB_SUB_TOPIC    = "dlp-topic"
    MIN_LIKELIHOOD   = "POSSIBLE"
    INFO_TYPES       = "FIRST_NAME,PHONE_NUMBER,EMAIL_ADDRESS,US_SOCIAL_SECURITY_NUMBER"
    APP_LOG_NAME     = "DLP-classify-gcs-files"

  }
}

#function - GCS trigger:
resource "google_cloudfunctions_function" "function-pubsub" {
  name        = var.function-pubsub
  description = "Function to be triggered on pubsub notification"
  runtime     = "python37"

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.source-function.name

  entry_point = "resolve_DLP"
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = "projects/${var.project_id}/topics/${var.pubsub_topic}"
  }

  environment_variables = {
    PROJECT_ID       = "banded-operator-370512"
    STAGING_BUCKET   = "quar-1999"
    SENSITIVE_BUCKET = "sens-1999"
    PUB_SUB_TOPIC    = "dlp-topic"
    MIN_LIKELIHOOD   = "POSSIBLE"
    INFO_TYPES       = "FIRST_NAME,PHONE_NUMBER,EMAIL_ADDRESS,US_SOCIAL_SECURITY_NUMBER"
    APP_LOG_NAME     = "DLP-classify-gcs-files"

  }
}