#defaults"
credentials = "Credential.json"
project_id  = "lunar-subject-364714"
region      = "europe-west1"
zone        = "europe-west1-b"

#key_ring:
keyring              = "test-keyring"
location             = "europe"
crypto_keys          = ["test-key-01", "test-key-02"]
purpose              = "ENCRYPT_DECRYPT"
key_rotation_period  = "100000s"
key_algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
key_protection_level = "HSM"

#owners:
set_owners_for     = ["test-key-01", "test-key-02"]
owners             = ["user:manjushree196@gmail.com", "user:satyajeet0606@gmail.com", ]
set_decrypters_for = [] //-->Default value
decrypters         = [] //-->Default value
set_encrypters_for = [] //-->Default value
encrypters         = [] //-->Default value
