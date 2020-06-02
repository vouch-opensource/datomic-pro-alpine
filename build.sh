#!/usr/bin/env bash

set -e

IMAGE=docker.pkg.github.com/vouchio/datomic-pro-alpine/datomic-pro-alpine
export DATOMIC_VERSION=$(cat DATOMIC_VERSION)
GIT_SHA=$(git rev-parse HEAD)
VERSION=${DATOMIC_VERSION}-${GIT_SHA}
DOCKER_TAG=${IMAGE}:${VERSION}

case "$1" in
  build)
    DOCKER_BUILDKIT=1 docker build -t ${DOCKER_TAG} \
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
