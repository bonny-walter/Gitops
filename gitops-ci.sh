#!/bin/bash

# Variables
TAG="latest"
IMG="santonix/sample-app:${TAG}"

# Step 1: Build the Docker image
docker buildx build . -t ${IMG} || { echo "Docker build failed!"; exit 1; }

# Step 2: Push the Docker image
docker push ${IMG} || { echo "Docker push failed!"; exit 1; }

# Step 3: Clone the repository (if not already cloned)
if [ ! -d "Gitops" ]; then
  git clone https://github.com/bonny-walter/Gitops.git || { echo "Git clone failed!"; exit 1; }
else
  echo "Directory 'Gitops' already exists, skipping clone."
fi

cd Gitops || exit 1

# Step 4: Apply patch (if exists)
if [ -f "patch-file.patch" ]; then
  git apply patch-file.patch || { echo "Failed to apply patch!"; exit 1; }
else
  echo "No patch file found, skipping."
fi

# Step 5: Check for deployment.yaml
if [ ! -f "deployment.yaml" ]; then
  echo "Error: deployment.yaml not found!"
  exit 1
fi

# Step 6: Commit and push changes
git add deployment.yaml
git commit -m "Updated deployment.yaml" || echo "No changes to commit."
git pull origin main || { echo "Git pull failed!"; exit 1; }
git push origin main || { echo "Git push failed!"; exit 1; }
