#!/bin/sh
set -o errexit

flux create source git demo \
  --url=https://github.com/xiagn825/demo \
  --branch=main \
  --interval=1m \
  --export > ./demo-source.yaml

flux create kustomization demo \
  --target-namespace=default \
  --source=demo \
  --path=./kustomize \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > demo-kustomization.yaml