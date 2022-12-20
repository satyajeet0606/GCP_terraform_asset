#Defaults:
credentials = "Credential.json"
project_id  = "lunar-subject-364714"
region      = "us-west1"
zone        = "us-west1-b"

#iam roles:
dlp_rolesList = ["roles/dlp.admin", "roles/dlp.serviceAgent"]
dlp_role      = "roles/viewer"

staging_bucket           = "quar-1999"
non_sensitive_bucket     = "non-sens-1999"
sensitive_bucket         = "sens-1999"
fucntion_bucket          = "function-1999"
location                 = "US"
force_destroy            = true
storage_class            = "STANDARD"
public_access_prevention = "enforced"
zip_function             = "index.zip"

#pubsub:
pubsub_topic        = "dlp-topic"
pubsub_subscription = "dlp-topic-sub"

