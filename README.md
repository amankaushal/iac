<!-- GETTING STARTED -->
## Getting Started

This is an example of how you can deploy spring boot application in AWS using Terraform, Docker.

### Prerequisites

We need to have below packages installed on our Operating System.

* docker

### Deployment

1. Set the Environment variables.
   Clone the repo
   ```sh
   export AWS_SECRET_ACCESS_KEY="XXXXX"
   export AWS_ACCESS_KEY_ID="XXXXX"
   export AWS_SECRET_KEY="XXXXX"
   export TF_WORKSPACE="devtest"
   export ENV_TYPE="dev"
   ```
2. To deploy the infrastructure, run below command.
   ```sh
   ./run.sh create
   ```