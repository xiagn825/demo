#!/bin/sh
# https://fluxcd.io/flux/get-started/
export GITHUB_TOKEN=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
export GITHUB_USER=xiagn825

brew install fluxcd/tap/flux
flux check --pre
flux bootstrap github \
  --owner=xiagn825 \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --personal
