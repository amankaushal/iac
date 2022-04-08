#!/bin/bash

delete_stale_containers () {
  for i in `docker ps -a -f name=aws_iac| awk '{print $1}'|grep -v CONTAINER`
  do
    docker stop $i;
    docker rm $i;
    echo -e "Deleted stale containers\n";
  done
}

delete_stale_containers

docker rmi aws_iac:0.1
echo -e "Deleted the existing image\n";

cd deployer
docker build -t aws_iac:0.1 . 
