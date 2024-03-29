#!/usr/bin/env bash

set -e

IMAGE=vouchio/datomic-pro-alpine
export DATOMIC_VERSION=$(cat DATOMIC_VERSION)
GIT_SHA=$(git rev-parse HEAD)
VERSION=${DATOMIC_VERSION}-${GIT_SHA}
DOCKER_TAG=${IMAGE}:${VERSION}

case "$1" in
  build)
    DOCKER_BUILDKIT=1 docker build -t ${DOCKER_TAG} \
      --build-arg DATOMIC_VERSION .
      ;;

  push)
    docker push ${DOCKER_TAG}
    ;;

  *)
    echo "Unknown command."
    exit 1
    ;;

esac
