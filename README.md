# To deploy your Application in AWS using Terraform. Follow the steps below.

1. Set Environment variables.

   export AWS_SECRET_ACCESS_KEY="XXXXX"
   export AWS_ACCESS_KEY_ID="XXXXX"
   export AWS_SECRET_KEY="XXXXX"
   export TF_WORKSPACE="devtest"
   export ENV_TYPE="dev"

2. To deploy the infrastructure, run below command.
   
   ./run.sh create
