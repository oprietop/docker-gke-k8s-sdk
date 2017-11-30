#!/bin/sh
mkdir -p keys
docker run -it --rm -v $(pwd):/root oprietop/gke-k8s-sdk
