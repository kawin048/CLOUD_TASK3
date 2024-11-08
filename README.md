# GCP Automated Infrastructure Setup Script - TASK3
 This script will automate the creation of the virtual machine,VPC creation,Subnets,Firewalls and  a VM instance running an Apache web server. The goal is to deploy a basic, publicly accessible web server on GCP.

# Table of Contents
- [Prerequisites](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#prerequisites)
- [Script Overview](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#script-overview)
- [Usage](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#usage)
- [Script Details](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#script-details)
- [Accessing Web server](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#accessing-web-server)
- [Result](https://github.com/kawin048/CLOUD_TASK3/blob/main/README.md#result)


 

# Prerequisites
- A Google Cloud Account
- A Project with billing enabled
- The user running the script should have sufficient permissions to create networks, firewall rules, and VM instances in the GCP project.

# Script Overview

The script performs the following tasks:

 1. Sets up necessary environment variables for configuration.
 
2. Sets the active GCP project.

3. Creates a VPC network in custom subnet mode.

4. Creates a subnet within the VPC with a specified IP range.

5. Configures a firewall rule to allow HTTP traffic on port 80.

6. Creates a VM instance within the VPC and subnet, installing and starting an Apache web server on it.


# Usage

1. Clone or download this repository to your local machine or GCP editor.

2. Edit the script to replace variables (such as PROJECT_ID,REGION,ZONE etc..) with your own configurations.

3. Run the script using the following commands:
```bash
chmod +x setup_infrastructure.sh
./setup_infrastructure.sh

```

4. Go to the Console and Visit Compute Engine Service You will See an instance will Created.

5. By Using the external Ip of VM you can visit Apache web server Page.


# Script Details
1. First set the variables for Project Creation.
```bash

PROJECT_ID: Your Google Cloud Project ID.
  
REGION: The region where the resources will be created.

ZONE: The zone where the VM instance will be created.

NETWORK_NAME: The name of Your VPC network.

SUBNET_NAME: The name of the subnet within the VPC.

VM_NAME: The name of Your virtual machine instance.

FIREWALL_RULE_NAME: The name of the firewall rule to allow HTTP access.

```

2.Set Project: Sets the active GCP project for all commands in the script.

```bash
gcloud config set project $PROJECT_ID

```

3.VPC and Subnet Creation: Creates a VPC in custom mode and a subnet within it.

```bash
gcloud compute networks create $NETWORK_NAME --subnet-mode=custom
gcloud compute networks subnets create $SUBNET_NAME --network=$NETWORK_NAME --region=$REGION --range=10.0.0.0/24

```

4.Firewall Rule Creation: Adds a firewall rule to allow HTTP (port 80) traffic from any IP.

```bash
gcloud compute firewall-rules create $FIREWALL_RULE_NAME --network=$NETWORK_NAME --allow=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

```

5.VM Instance Creation with Apache Web Server: Creates a VM and installs Apache to serve HTTP requests.

```bash
gcloud compute instances create $VM_NAME \
  --zone=$ZONE \
  --machine-type=e2-micro \
  --subnet=$SUBNET_NAME \
  --tags=http-server \
  --metadata=startup-script='#! /bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2'
```
# Accessing Web server
You can access the web server by using Using this External Ip of Vm .
- Example: http://[VM_EXTERNAL_IP]

# Result 
After following all steps , I built the automation script that creates the vm, vpc with subnets,firewall and serves apache webserver static page.

- To Access my Application: [Click Here](http://34.172.35.91)
  
  

 

