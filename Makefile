# Image URL to use for building/pushing images
TAG ?= latest
IMG ?= gitopsbook/example-operator:${TAG}

# Default target
.PHONY: all
all: docker-build

# Build the Docker image
.PHONY: docker-build
docker-build:
	@echo "Building Docker image: ${IMG}"
	docker build . -t ${IMG}

# Push the Docker image
.PHONY: docker-push
docker-push:
	@echo "Pushing Docker image: ${IMG}"
	docker push ${IMG}
