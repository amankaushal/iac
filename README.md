<!-- GETTING STARTED -->
## Getting Started

Deploy/Upgrade Spring Boot application in AWS EC2 using Terraform.

### Prerequisites

We need to have below packages installed on our Operating System.

* docker
* git

### Deployment

1. Create the IAM user account for terraform in AWS and create AWS ACCESS key.

2. Grant EC2 / S3 full access to the terraform user.

3. Clone the repository.
   ```sh
   git clone git@github.com:amankaushal/iac.git
   ```

4. Set the Environment variables and you can modify configuration in deployer/profiles/${env_type}.tfvars.json
   ```sh
   export AWS_SECRET_ACCESS_KEY="XXXXX"
   export AWS_ACCESS_KEY_ID="XXXXX"
   export AWS_SECRET_KEY="XXXXX"
   export TF_WORKSPACE="devtest" # choose any environment name.
   export ENV_TYPE="dev" # prod/stg/acc/qa
   ```

5. To build the container.
   ```sh
   ./build.sh
   ```

6. To deploy the infrastructure, run below command.
   ```sh
   ./run.sh create
   ```

7. To upgrade the application, run below command after modifying app_tag in environment specific profile files.
   ```sh
   ./run.sh upgrade
   ```