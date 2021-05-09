export AWS_DEFAULT_REGION=ap-southeast-1
export ROOT_PATH=infra
init:
	terraform -chdir=${ROOT_PATH} init
	
plan:
	terraform -chdir=${ROOT_PATH} plan

apply:
	terraform -chdir=${ROOT_PATH} apply --auto-approve

kill:
	terraform -chdir=${ROOT_PATH} destroy --auto-approve

ec2_id=$$(terraform -chdir=infra output ec2_id | tr -d '"')

tunnel:
	ssh ecs-user@${ec2_id} \
	-L 27016:localhost:27017 \
	-L 27017:mongo-ecs-primary.ecs.demo:27017 \
	-L 27018:mongo-ecs-secondary.ecs.demo:27017

ssh:
	ssh ecs-user@${ec2_id}

ssm:
	aws ssm start-session --target ${ec2_id}

docker:
	docker run -d -p 27017:27017 -v primary-data:/bitnami docker.io/bitnami/mongodb:4.4-debian-10