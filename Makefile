
build: node6-sass2.2.0 node6-sass3.1.0

node6-sass2.2.0:
	docker build --build-arg SASS_VERSION=2.2.0 -t remuslazar/docker-node-sass:node6-sass2.2.0 .

node6-sass3.1.0:
	docker build --build-arg SASS_VERSION=3.1.0 -t remuslazar/docker-node-sass:node6-sass3.1.0 .
