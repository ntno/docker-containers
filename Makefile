namespace:=ntno
version=$(shell cat $(app)/version.txt)
tag=$(namespace)/$(app):$(version)

build: check-app
	docker build $(app) --tag $(tag)

push: build
	docker push $(tag)

launch: 
	docker run -it $(tag) /bin/bash

check-app:
ifndef app
	$(error app is not set)
endif