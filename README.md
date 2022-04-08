<!-- GETTING STARTED -->
## Getting Started

This is an example of how we can deploy spring boot application in AWS using Terraform, Docker.

### Prerequisites

We need to have below packages installed on our Operating System.

* docker
* git

All the required dependencies can be built into doker image by running the below commands.

### Deployment

1. git clone git@github.com:amankaushal/iac.git

2. Set the Environment variables.
   Clone the repo
   ```sh
   export AWS_SECRET_ACCESS_KEY="XXXXX"
   export AWS_ACCESS_KEY_ID="XXXXX"
   export AWS_SECRET_KEY="XXXXX"
   export TF_WORKSPACE="devtest"
   export ENV_TYPE="dev"
   ```

3. To build the container.
   ```sh
   ./build.sh
   ```

4. To deploy the infrastructure, run below command.
   ```sh
   ./run.sh create
   ```
