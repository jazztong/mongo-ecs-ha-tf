#! /bin/bash
set -e
# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# Set ECS Cluster
echo ECS_CLUSTER=${ECS_CLUSTER} >> /etc/ecs/ecs.config
#install the Docker volume plugin
docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${REGION} --grant-all-permissions
# Report end
echo 'Done Initialization'