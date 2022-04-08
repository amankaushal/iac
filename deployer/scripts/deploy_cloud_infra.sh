#!/bin/bash
TF_WORKSPACE="$1"
ENV_TYPE="$2"
ACTION="$3"

handle_workspace () {
  terraform init;
  terraform workspace list | grep $1;
  if [ $? -eq 0 ]; then
     terraform workspace select $1;
  else
     terraform workspace new $1;
  fi 
}

handle_execution () {
  if [ "$3" == "destroy" ];then
    terraform init
    terraform state pull;
    terraform destroy -var-file="../profiles/$2.tfvars.json";
  fi
  if [ "$3" == "create" ]; then
    terraform init;
    terraform state pull;
    terraform apply -var-file="../profiles/$2.tfvars.json";
  fi
  if [ "$3" == "upgrade" ]; then
    terraform init;
    terraform state pull;
    terraform apply -var-file="../profiles/$2.tfvars.json" -parallelism=1;
  fi
}

cd /deployer/tf_playbooks;
handle_workspace $TF_WORKSPACE
handle_execution $TF_WORKSPACE $ENV_TYPE $ACTION
