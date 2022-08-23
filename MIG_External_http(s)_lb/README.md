# External HTTP(S) Load Balancer with MIG Backend

#### This Repository explains the deployment of external http(s) load balancer with Managed Instance Group(MIG) backend service.

## Use Case:

When you configure HTTP(S) Load Balancing in Premium Tier, it uses a global external IP address and can intelligently route requests from users to the closest backend instance group or NEG, based on proximity. For example, if you set up instance groups in North America, Europe, and Asia, and attach them to a load balancer's backend service, user requests around the world are automatically sent to the VMs closest to the users, assuming the VMs pass health checks and have enough capacity (defined by the balancing mode). If the closest VMs are all unhealthy, or if the closest instance group is at capacity and another instance group is not at capacity, the load balancer automatically sends requests to the next closest region with capacity.

## Problem Description:

Sometimes it’s difficult to keep the application up and running when unexpected volume of traffic comes in. It becomes difficult to manage the traffic and scale the application according to it. Load Balancer solves many such issues and gives the required solution to the problem.

## Solution-Scope:
##### The above discussed problems can be solved by configuring the following.
- Instance Template
- Managed Instance Group-[MIG]
- Load Balancer
- Health Checks
- Auto Scaler

## Setup Permission:

| Task | Required Permission |
| --- | --- |
| Create | Instance Admin |
| Add or remove firewall rules | Security Admin |
| Create Load Balancer Components | Network Admin |
| Create a Projet(Optional) | Project Creator |

## Solution Diagram:

![image](https://miro.medium.com/max/1230/1*iiUEd9TVt6PyEEYQB6PynA.png)
