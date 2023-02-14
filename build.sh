#!/usr/bin/env bash

set -e

IMAGE=ghcr.io/vouchio/datomic-pro-alpine
export DATOMIC_VERSION=$(cat DATOMIC_VERSION)
GIT_SHA=$(git rev-parse HEAD)
VERSION=${DATOMIC_VERSION}-${GIT_SHA}
DOCKER_TAG=${IMAGE}:${VERSION}

case "$1" in
  build)
    docker buildx build -t ${DOCKER_TAG} \
      --platform linux/x86_64 \
      --build-arg DATOMIC_VERSION \
      --build-arg MYDATOMIC_USER \
      --build-arg MYDATOMIC_PASSWORD .
    ;;

  push)
    docker push ${DOCKER_TAG}
    ;;

  *)
    echo "Unknown command."
    exit 1
    ;;

esac
