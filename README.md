# TerraformPractice
Just messing around with Terraform and IAC 

# Requirements 

# Notes
Shamelessly borrowed from https://medium.com/@bm54cloud/deploy-a-kubernetes-cluster-with-terraform-b5bf6a7a369a for learning purposes
https://github.com/slawekzachcial/kubernetes-the-hard-way-aws


# Goals for this project
  - Create a highly available Kubernetes cluster and requisite infrastructure inAWS using Terraform for practicing managing Kubernetes with code. 
    - Terraform should deploy and configure all requisite underlaying infrastructure for the EKS cluster. 
    - Cluster should be able to withstand an entire AZ failure 
    - Cluster should adhere to AWS/Kubernetes best security practices
    - If possible the cluster should be fully deployable with Terraform (more discovery needed as I learn more)
    - Cluster should autoscale both cluster members and pods 
  - Host a basic "Hello world" container that's accessable from the public internet. 

# To Do
 - Create a VPC
 - Create Appropriate Subnets in the VPC