# Production-Ready EKS Cluster with Terraform

This project provisions a complete, secure, production-ready Amazon EKS cluster using Terraform. It is designed to be modular and easily customizable.

## Features

- **VPC:** Creates a new VPC with public and private subnets across multiple availability zones.
- **EKS Cluster:** Deploys an EKS cluster with managed node groups.
  - Supports both on-demand and spot instances for cost optimization.
  - Enables IAM Roles for Service Accounts (IRSA) for secure access to AWS resources from pods.
  - Enables control plane logging (api, audit, authenticator).
- **Networking:**
  - NAT Gateway for outbound internet access from private subnets.
  - VPN Gateway support.
- **Backend:** Includes a module to create an S3 bucket and DynamoDB table for Terraform remote state and locking.

## Project Structure

The project is organized into the following modules:

- **`network/`**: Contains the networking resources, including the VPC, subnets, and NAT Gateway. It uses the official `terraform-aws-modules/vpc/aws` module.
- **`eks/`**: Contains the EKS cluster resources. It uses the official `terraform-aws-modules/eks/aws` module.
- **`backend/`**: Contains the resources for the Terraform backend (S3 bucket and DynamoDB table).

The root `main.tf` file ties these modules together.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (version >= 1.6.0)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) configured with your AWS credentials.
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

## Usage

1.  **Initialize the backend:**

    First, you need to create the S3 bucket and DynamoDB table for the Terraform backend.

    ```bash
    cd backend
    terraform init
    terraform apply
    ```

2.  **Configure the backend:**

    In the `backend.tf` file in the root directory, replace `<YOUR_S3_BUCKET_NAME>` and `<YOUR_DYNAMODB_TABLE_NAME>` with the outputs from the previous step.

3.  **Deploy the EKS cluster:**

    Now you can deploy the EKS cluster.

    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

4.  **Configure kubectl:**

    After the apply is complete, you can configure `kubectl` to connect to your new cluster.

    ```bash
    aws eks update-kubeconfig --name <cluster_name> --region <aws_region>
    ```

## Outputs

The following outputs are available from the modules:

### EKS Module

- `cluster_id`: The name/id of the EKS cluster.
- `cluster_endpoint`: The endpoint for your EKS Kubernetes API.
- `cluster_version`: The Kubernetes version of the EKS cluster.
- `cluster_primary_security_group_id`: The primary security group ID of the EKS cluster.

### Network Module

- `vpc_id`: The ID of the VPC.
- `private_subnets`: A list of private subnet IDs.
- `public_subnets`: A list of public subnet IDs.

