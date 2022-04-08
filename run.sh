#!/bin/bash

ACTION="$1"

delete_stale_containers () {
  for i in `docker ps -a -f name=aws_iac| awk '{print $1}'|grep -v CONTAINER`
  do
    docker stop $i;
    docker rm $i;
    echo -e "Deleted stale containers\n";
  done
}

delete_stale_containers

docker run -it --name aws_iac --env "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY" --env "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" --env "AWS_SECRET_KEY=$AWS_SECRET_KEY" aws_iac:0.1 /deployer/scripts/deploy_cloud_infra.sh $TF_WORKSPACE $ENV_TYPE $ACTION
