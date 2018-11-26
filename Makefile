SCEPTRE_VERSION = 2.0.0rc2
IMAGE_NAME ?= xmission/sceptre:$(SCEPTRE_VERSION)
TAG = $(SCEPTRE_VERSION)

build:
	docker build --build-arg SCEPTRE_VERSION=$(SCEPTRE_VERSION) -t $(IMAGE_NAME) .

test:
	docker run --rm -it $(IMAGE_NAME) sceptre --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

dockerPush:
        docker push $(IMAGE_NAME)

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
