
deploy: build
	$$(aws ecr get-login --region us-west-2)
	docker tag ecsbootstrap:latest 265109528935.dkr.ecr.us-west-2.amazonaws.com/ecsbootstrap:latest
	docker push 265109528935.dkr.ecr.us-west-2.amazonaws.com/ecsbootstrap:latest

build:
	docker build -t ecsbootstrap .
