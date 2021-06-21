namespace:=ntno
version=$(shell cat $(app)/version.txt)
tag=$(namespace)/$(app):$(version)
test_container_name=test-$(app)-$(version)

build: check-app
	docker build $(app) --tag $(tag)

push: build
	docker push $(tag)

launch: check-app
	docker run -it $(tag) /bin/bash -l

test: build
	docker kill $(test_container_name) || true
	docker run --rm -id --name $(test_container_name) $(tag) /bin/bash 
	docker exec -w "/usr/local/$(app)/goss-tests" -i $(test_container_name) /bin/bash < run-goss-tests.sh 
	docker kill $(test_container_name) || true

check-app:
ifndef app
	$(error app is not set)
endif


# docker exec -i $(test_container_name) /bin/sh -c "/usr/local/$(app)/goss-tests"
