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

# Enable password authentication
sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
systemctl restart sshd
service sshd restart

# Add ecs-user
useradd ecs-user
usermod -aG wheel ecs-user
echo "${ECS_USER_PASSWORD}" | passwd --stdin ecs-user

# Report end
echo 'Done Initialization'