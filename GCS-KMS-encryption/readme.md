# Cloud Key Management Service - KMS

## Overview
Cloud Key Management Service allows you to create, import, and manage cryptographic keys and perform cryptographic operations in a single centralized cloud service. You can use these keys and perform these operations by using Cloud KMS directly, by using Cloud HSM or Cloud External Key Manager, or by using Customer-Managed Encryption Keys (CMEK) integrations within other Google Cloud services.

With Cloud KMS you are the ultimate custodian of your data, you can manage cryptographic keys in the cloud in the same ways you do on-premises, and you have a provable and monitorable root of trust over your data.
## List of CMEK-integrated services
- A Customer-managed encryption key (CMEK) integration lets you encrypt data at rest in that service using a Cloud KMS key that you own and manage. Data protected with a CMEK key cannot be decrypted without access to that key.

- A CMEK-compliant service either does not store data, or only stores data for a short period of time, such as during batch processing. Such data is encrypted using an ephemeral key that exists only in memory and is never written to disk. When the data is no longer needed, the ephemeral key is flushed from memory, and the data can't ever be accessed again. The output of a CMEK-compliant service might be stored in a service that is integrated with CMEK, such as Cloud Storage.

- Your applications can use Cloud KMS in other ways. For example, you can directly encrypt application data before transmitting or storing it.

**The following table lists services that integrate with Cloud KMS for software and hardware (HSM) keys.** 

## Encrypting data manually using CLI
## Decrypting data manually using CLI
## Why to rotate Keys?
## How often to rotate keys?
## Rotating keys and re-encrypting data requires the following roles or permissions:


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Cloud KMS module that allows managing a keyring, zero or more keys in the keyring, and IAM role bindings on individual keys.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS keyring in the provided project
- Create zero or more keys in the keyring
- Create IAM role bindings for owners, encrypters, decrypters

## Inputs

| Name                   | Description                                                                                                                                                                                                                                                      | Type           | Default                         | Required |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------- | -------- |
| decrypters             | List of comma-separated owners for each key declared in set\_decrypters\_for.                                                                                                                                                                                    | `list(string)` | `[]`                            | no       |
| encrypters             | List of comma-separated owners for each key declared in set\_encrypters\_for.                                                                                                                                                                                    | `list(string)` | `[]`                            | no       |
| key\_algorithm         | The algorithm to use when creating a version based on this template. See the [https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm](https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm) for possible inputs. | `string`       | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no       |
| key\_protection\_level | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: \["SOFTWARE", "HSM"\]                                                                                                                     | `string`       | `"SOFTWARE"`                    | no       |
| key\_rotation\_period  | n/a                                                                                                                                                                                                                                                              | `string`       | `"100000s"`                     | no       |
| keyring                | Keyring name.                                                                                                                                                                                                                                                    | `string`       | n/a                             | yes      |
| keys                   | Key names.                                                                                                                                                                                                                                                       | `list(string)` | `[]`                            | no       |
| labels                 | Labels, provided as a map                                                                                                                                                                                                                                        | `map(string)`  | `{}`                            | no       |
| location               | Location for the keyring.                                                                                                                                                                                                                                        | `string`       | n/a                             | yes      |
| owners                 | List of comma-separated owners for each key declared in set\_owners\_for.                                                                                                                                                                                        | `list(string)` | `[]`                            | no       |
| prevent\_destroy       | Set the prevent\_destroy lifecycle attribute on keys.                                                                                                                                                                                                            | `bool`         | `true`                          | no       |
| project\_id            | Project id where the keyring will be created.                                                                                                                                                                                                                    | `string`       | n/a                             | yes      |
| purpose                | The immutable purpose of the CryptoKey. Possible values are ENCRYPT\_DECRYPT, ASYMMETRIC\_SIGN, and ASYMMETRIC\_DECRYPT.                                                                                                                                         | `string`       | `"ENCRYPT_DECRYPT"`             | no       |
| set\_decrypters\_for   | Name of keys for which decrypters will be set.                                                                                                                                                                                                                   | `list(string)` | `[]`                            | no       |
| set\_encrypters\_for   | Name of keys for which encrypters will be set.                                                                                                                                                                                                                   | `list(string)` | `[]`                            | no       |
| set\_owners\_for       | Name of keys for which owners will be set.                                                                                                                                                                                                                       | `list(string)` | `[]`                            | no       |

## Outputs
| Name              | Description                       |
| ----------------- | --------------------------------- |
| keyring           | Self link of the keyring.         |
| keyring\_name     | Name of the keyring.              |
| keyring\_resource | Keyring resource.                 |
| keys              | Map of key name => key self link. |

## Principle of least privilege
To practice the principle of least privilege, grant the most limited set of permissions to the lowest object in the resource hierarchy.

- To grant a principal permissions to encrypt (but not decrypt) data, grant the **roles/cloudkms.cryptoKeyEncrypter** role on the key.

- To grant a principal permissions to encrypt and decrypt data, grant the **roles/cloudkms.cryptoKeyEncrypterDecrypter** role on the key.

- To grant a principal permissions to verify (but not sign) data, grant the **roles/cloudkms.publicKeyViewer** role on the key.

- To grant a principal permissions to sign and verify data, grant the **roles/cloudkms.signerVerifier role** on the key.

- To grant a principal permissions to manage a key, grant the **roles/cloudkms.admin** role on the key.

## Member declaration for Roles:
- **user:{emailid}:** An email address that represents a specific Google account. For example, jane@example.com or joe@example.com.
- **serviceAccount:** {emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
- **group:{emailid}:** An email address that represents a Google group. For example, admins@example.com.
- **domain:{domain}:** A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.








