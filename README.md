# Kubernetes Deployment with Terraform

This repository contains the necessary files and instructions to deploy a Kubernetes cluster using Terraform. With Terraform, you can define and manage infrastructure as code, making it easier to provision and maintain a Kubernetes environment.

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed on your local machine and connected to Terraform Cloud.
2. Access to a cloud provider account (AWS in this case) and the necessary credentials to create resources.
3. A working knowledge of Kubernetes and Terraform.

## Getting Started

To get started with this Kubernetes deployment, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/kubernetes-deployment.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd kubernetes-deployment
   ```

3. Review the Terraform configuration files in the `terraform` directory. Modify the files as per your requirements, such as the cloud provider, region, cluster size, or any other desired configuration.

4. Initialize Terraform and download the necessary provider plugins:

   ```bash
   terraform init
   ```

5. Review and validate the Terraform execution plan:

   ```bash
   terraform plan
   ```

   Ensure that the plan output matches your expectations and that no errors or warnings are present.

6. Apply the Terraform configuration to create the Kubernetes cluster:

   ```bash
   terraform apply
   ```

   Confirm the deployment by typing `yes` when prompted. The provisioning process may take several minutes, depending on your infrastructure size.

   *Note that you will have to be signed in as the IAM user that created the nodes to view them in AWS management console, use the following command if the user only has 
    CLI access

   ```bash
   kubectl get nodes
   ```

8. Once the deployment is complete, Terraform will output information about the cluster, such as the endpoint and authentication details. Make note of this information as you will need it to interact with the Kubernetes cluster. (Not yet implemented)

9. You can now interact with your Kubernetes cluster using `kubectl`. Ensure you have `kubectl` installed and configured to use the newly created cluster. Use the endpoint and authentication details provided by Terraform to set up your `kubectl` configuration.

## Cleaning Up

To remove the Kubernetes cluster and associated resources, you can use Terraform to destroy the infrastructure:

```bash
terraform destroy
```

When prompted, type `yes` to confirm the destruction. Be cautious, as this action is irreversible and will delete all resources created by Terraform.

## Contributions

Contributions to this project are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to modify and distribute it as needed.
