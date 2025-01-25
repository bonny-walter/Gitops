# Image URL to use for building/pushing images
IMG ?= gitopsbook/example-operator

# Get the current commit hash to use as the tag
TAG := $(shell git rev-parse --short HEAD)
FULL_IMAGE := ${IMG}:${TAG}

# Default target
.PHONY: all
all: docker-build kubectl-apply

# Build the Docker image
.PHONY: docker-build
docker-build:
	@echo "Building Docker image: ${FULL_IMAGE}"
	docker build . -t ${FULL_IMAGE}

# Push the Docker image
.PHONY: docker-push
docker-push:
	@echo "Pushing Docker image: ${FULL_IMAGE}"
	docker push ${FULL_IMAGE}

# Apply the Kubernetes manifests
.PHONY: kubectl-apply
kubectl-apply:
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f .