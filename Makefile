filepath        :=      $(PWD)
versionfile     :=      $(filepath)/version.txt
version         :=      $(shell cat $(versionfile))
image_repo      :=      0labs/operator

build:
	docker build --tag $(image_repo):$(version) .

run:
	docker run -d --name=operator -p 1001:1001 $(image_repo):$(version)

release:
	docker build --tag $(image_repo):$(version) .
	docker push $(image_repo):$(version)

latest:
	docker tag $(image_repo):$(version) $(image_repo):latest
	docker push $(image_repo):latest

.PHONY: build release latest
