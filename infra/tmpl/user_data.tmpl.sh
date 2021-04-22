#! /bin/bash
set -e
# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo ECS_CLUSTER=${ECS_CLUSTER} >> /etc/ecs/ecs.config
#verify that the agent is running
# until curl -s http://localhost:51678/v1/metadata
# do
# 	sleep 1
# done
#install the Docker volume plugin
docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${REGION} --grant-all-permissions

# Report end
echo 'Done Initialization'