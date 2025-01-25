#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the current commit hash and set the version variable
export VERSION=$(git rev-parse HEAD | cut -c1-7)

# # Build the application
# echo "Building the application..."
# make build

# # Test the application
# echo "Running tests..."
# make test

# Define the new Docker image
export NEW_IMAGE="santonix/sample-app:${VERSION}"

# Build and push the Docker image
echo "Building Docker image: ${NEW_IMAGE}"
docker build -t "${NEW_IMAGE}" .

echo "Pushing Docker image: ${NEW_IMAGE}"
docker push "${NEW_IMAGE}"

# Clone the sample app deployment repository
REPO_URL="https://github.com/bonny-walter/Gitops.git"
if [ ! -d "sample-app-deployment" ]; then
    echo "Cloning repository: ${REPO_URL}"
    git clone "${REPO_URL}"
fi
cd Gitops

# Update the deployment.yaml with the new image
echo "Updating deployment.yaml with the new image..."
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
cd ..
rm -rf /home/bonny/LEARNING-FROM-BOOKS/GITOPS-KUBERNETES/ch-02/Gitops/Gitops

# Commit and push the changes
echo "Committing and pushing changes to deployment.yaml..."
git add deployment.yaml
git commit -m "Update sample-app image to ${NEW_IMAGE}"
git push

