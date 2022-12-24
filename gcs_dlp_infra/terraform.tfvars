#Defaults:
credentials = "operator.json"
project_id  = "banded-operator-370512"
region      = "us-west1"
zone        = "us-west1-b"

#iam roles:
dlp_rolesList = ["roles/dlp.admin", "roles/dlp.serviceAgent"]
dlp_role      = "roles/viewer"

staging_bucket           = "quar-1999"
sensitive_bucket         = "sens-1999"
location                 = "US"
force_destroy            = true
storage_class            = "STANDARD"
public_access_prevention = "enforced"

#pubsub:
pubsub_topic        = "dlp-topic"
pubsub_subscription = "dlp-topic-sub"

#cloud-function
function_bucket = "function-1999"
source_function = "function.zip"
function-gcs    = "create_DLP_job"
function-pubsub = "resolve_DLP"


