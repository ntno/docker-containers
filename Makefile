namespace:=ntno
version=$(shell cat $(app)/version.txt)
tag=$(namespace)/$(app):$(version)
test_container_name=test-$(app)-$(version)
goss_version=v0.3.10
dgoss_version=v0.3.10
build: check-app
	docker build $(app) --tag $(tag)

push: build
	docker push $(tag)

launch: check-app
	docker run -it $(tag) /bin/bash

test: build
	docker run --rm -id --name $(test_container_name) $(tag) /bin/bash 
	docker exec -i $(test_container_name) /bin/bash < run-goss-tests.sh
	docker stop $(test_container_name)


check-app:
ifndef app
	$(error app is not set)
endif