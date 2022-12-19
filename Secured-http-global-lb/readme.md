# Securing Traffic using Cloud Armor
### Use Case
- Control access to your web applications and services.
- Enable access for users at specific IP addresses with allow-lists.
- Block access for users at specific IP addresses with deny-lists.
- Custom rules to filter based on Layer 3 through Layer 7 parameters.
- Cloud CDN external origin server DDoS defense and layer 7 monitoring.
- Layer 7 access controls and cache-busting attacks.

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### Problem Description
When applications are open to internet, attackers may jump in and steal sensitive information. Cloud Armor protects application against several types of Layer-7 DDOS – Distributed Denial of Service Attacks such as,
- HTTP Floods
- High Frequency layer 7 malicious activity
- cross-site scripting (XSS) 
- SQL injection (SQLi) attacks

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### Solution Scope
- To protect our workloads from DDOS attacks we configure cloud Armor Security Policies to the load balancer backend services. It provides built-in defenses against L3 and L4 DDoS attacks.
- Cloud Armor provides predefined rules to help defend against attacks such as cross-site scripting (XSS) and SQL injection (SQLi) attacks.
- The adaptive protection of Google Cloud Armor puts up protection assistance for the Google Cloud applications, services, and websites.

- The adaptive protection policy of Cloud Armor makes use of machine-learning models in order to offer protection services. Automatically   detect and help mitigate high volume Layer 7 DDoS attacks with an ML system trained locally on your applications.

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### High Level Solution Diagram

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### IAM Permissions
| IAM Role | Description |
| -------- | ----------- |
| Compute Admin(roles/compute.admin) | Full control of all Compute Engine resources |
| Compute Network Admin Role(roles/compute.networkAdmin) | Permissions to create, modify, and delete networking resources, except for firewall rules and SSL certificates. |
| Compute Security Admin Role(roles/compute.securityAdmin) | Permissions to create, modify, and delete firewall rules and SSL certificates, and also to configure Shielded VM settings. |
| Compute Load Balancer Admin(roles/compute.loadBalancerAdmin) | Permissions to create, modify, and delete load balancers and associate resources |

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### Low Level Design - VPC & Subnets
| Region | Environment | VPC | Availability Zone | Subnets | Size | Total IP's | Subnet CIDR |
| ------ | ----------- | --- | ----------------- | ------- | ---- | ---------- | ----------- |
| europe-north1 | Development | test-vpc | lowa | vpc-sub-1 | 24 | 256 | 24 |
| us-west1 | Development | test-vpc | lowa | vpc-sub-2 | 24 | 256 | 24 |

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### Instance Template and MIG's
| Region |	Zone |	Environment |	Compute Service | 	VPC |	Subnet |
| ------ | ----- | ------------ | --------------- | ----- | ------ |
| europe-north1 |	europe-north1-b |	Development |	Ins-temp |	test-vpc |	vpc-sub-1 |
| us-west1 |	us-west1-b |	Development |	Ins-temp |	test-vpc |	vpc-sub-2 |
| europe-north1 |	europe-north1-b |	Development |	Ins-grp	test-vpc | test-vpc |	vpc-sub-1 |
| us-west1 |	us-west1-b |	Development |	Ins-grp |	test-vpc |	vpc-sub-2 |

-----------------------------------------------------------------------------------------------------------------------------------------------------------

### Backend Service
| Backend | Backend Mig's | Region | Environment | static-IP |
| ------- | ------------- | ------ | ----------- | --------- |
| test-backend-service-1 |	mig-1 |	europe-north1 |	Development |	"http://34.120.22.33" |
| test-backend-service-2	| mig-2	 | us-west1	| Development	| "http://34.120.22.33/nginx" |

-----------------------------------------------------------------------------------------------------------------------------------------------------------









