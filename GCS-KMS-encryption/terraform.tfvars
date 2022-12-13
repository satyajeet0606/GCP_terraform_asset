#defaults"
credentials = "Credential.json"
project_id  = "lunar-subject-364714"
region      = "europe-west1"
zone        = "europe-west1-b"

#key_ring:
keyring              = "mykeyring"
location             = "us"
crypto_keys          = ["mykey"]
purpose              = "ENCRYPT_DECRYPT"
key_rotation_period  = "100000s"
key_algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
key_protection_level = "HSM"

#owners:
set_owners_for     = ["mykey"]
owners             = ["serviceAccount:service-551370288252@gs-project-accounts.iam.gserviceaccount.com"]  //---> ServiceAccount associated with GCS to be entered for authorization.
set_decrypters_for = ["mykey"]                                                          
decrypters         = ["user:satyajeet0606@gmail.com", "user:manjushree196@gmail.com", ] 
set_encrypters_for = []                                                          
encrypters         = [] 

#bucket:
static_bucket               = "test-bucket-06"
storage_location            = "US"
storage_class               = "STANDARD"
force_destroy               = true
uniform_bucket_level_access = true

