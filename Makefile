# Image URL to use for building/pushing images
TAG ?= latest
IMG ?= santonix/example-operator:${TAG}

# Build the docker image
docker-build:
	@echo "Building Docker image: ${IMG}"
	docker build . -t ${IMG}

# Push the docker image
docker-push:
	@echo "Pushing Docker image: ${IMG}"
	docker push ${IMG}

# Clean local images (optional)
docker-clean:
	@echo "Removing local image: ${IMG}"
	docker rmi ${IMG} || true
