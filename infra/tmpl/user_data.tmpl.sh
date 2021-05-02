#! /bin/bash
set -e
# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# Set ECS agent setting
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=${ECS_CLUSTER}
ECS_INSTANCE_ATTRIBUTES={"mongo": "primary"}
ECS_CONTAINER_STOP_TIMEOUT=2s
ECS_IMAGE_PULL_BEHAVIOR=prefer-cached
EOF
#install the Docker volume plugin
docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${REGION} --grant-all-permissions
# Report end
echo 'Done Initialization'