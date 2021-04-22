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