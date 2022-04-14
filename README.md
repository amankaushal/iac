<!-- GETTING STARTED -->
## Getting Started

Deploy/Upgrade Spring Boot application in AWS EC2 using Terraform.

### Prerequisites

We need to have below packages installed on our Operating System.

* docker
* git

### Deployment

1. Create S3 storage bucket to save the terraform states and change it in provider.tf file.

2. Create IAM Group and grant EC2 / S3 / Route53 full access to the group.

3. Create terraform user and make it the member of above group. Create AWS access key and use it in (4).

4. Clone the repository.
   ```sh
   git clone git@github.com:amankaushal/iac.git
   ```

5. Set the Environment variables and you can modify configuration in deployer/profiles/${env_type}.tfvars.json
   ```sh
   export AWS_SECRET_ACCESS_KEY="XXXXX"
   export AWS_ACCESS_KEY_ID="XXXXX"
   export AWS_SECRET_KEY="XXXXX"
   export TF_WORKSPACE="devtest" # Unique terraform workspace name.
   export ENV_TYPE="dev" # prod/stg/acc/dev
   ```

6. To build the docker image.
   ```sh
   ./build.sh
   ```

7. To deploy the infrastructure in AWS, run below command.
   ```sh
   ./run.sh create
   ```

8. To upgrade the application, run below command after modifying app_tag in environment specific profile files.
   ```sh
   ./run.sh upgrade
   ```

Note: Configuration variables can be modified in profiles/$env_type files.