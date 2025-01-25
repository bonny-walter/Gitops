#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the current commit hash and set the version variable
export VERSION=$(git rev-parse HEAD | cut -c1-7)

# Build and test the application
make build
make test

# Define the new Docker image
export NEW_IMAGE="gitopsbook/sample-app:${VERSION}"

# Build and push the Docker image
docker build -t "${NEW_IMAGE}" .
docker push "${NEW_IMAGE}"

# Clone the sample app deployment repository
REPO_URL="http://github.com/gitopsbook/sample-app-deployment.git"
if [ ! -d "sample-app-deployment" ]; then
    git clone "${REPO_URL}"
fi
cd sample-app-deployment

# Update the deployment.yaml with the new image
kubectl patch \
  --local \
  -o yaml \
  -f deployment.yaml \
  -p "spec:
        template:
          spec:
            containers:
            - name: sample-app
              image: ${NEW_IMAGE}" \
  > /tmp/newdeployment.yaml

# Move the updated deployment file back
mv /tmp/newdeployment.yaml deployment.yaml

# Commit and push the changes
git add deployment.yaml
git commit -m "Update sample-app image to ${NEW_IMAGE}"
git push
