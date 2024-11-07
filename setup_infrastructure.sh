
PROJECT_ID="YOUR_PROJECT_ID"
REGION="YOUR_REGION"
ZONE="YOUR_ZONE"
NETWORK_NAME="YOUR_VPC_NAME"
SUBNET_NAME="YOUR_SUBNET_NAME"
VM_NAME="YOUR_INSTANCE_NAME"
FIREWALL_RULE_NAME="YOUR_FIREWALL_NAME"

gcloud config set project $PROJECT_ID


#VPC CREATION....
gcloud compute networks create $NETWORK_NAME --subnet-mode=custom

#SUBNET CREATION....
gcloud compute networks subnets create $SUBNET_NAME \
  --network=$NETWORK_NAME \
  --region=$REGION \
  --range=10.0.0.0/24


#FIREWALL CREATION....
gcloud compute firewall-rules create $FIREWALL_RULE_NAME \
  --network=$NETWORK_NAME \
  --allow=tcp:80 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=http-server


#INSTALLING APACHE WEB SERVER....
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


