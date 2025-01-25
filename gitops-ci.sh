#!/bin/bash
export VERSION=$(git rev-parse HEAD | cut -c1-7)
make build
make test

export NEW_IMAGE="santonix/sample-app:${VERSION}"
docker build -t ${NEW_IMAGE} . qq
docker push ${NEW_IMAGE}

git clone https://github.com/bonny-walter/Gitops.git
cd Gitops  || exit

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
mv /tmp/newdeployment.yaml deployment.yaml

git commit deployment.yaml -m "Update sample-app image to ${NEW_IMAGE}"
git push
