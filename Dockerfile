FROM alpine:3.11 as build

ARG MYDATOMIC_USER
ARG MYDATOMIC_PASSWORD
ARG DATOMIC_VERSION

RUN apk --no-cache add zip bash wget

WORKDIR /opt

RUN wget --http-user=${MYDATOMIC_USER} --http-password=${MYDATOMIC_PASSWORD} \
  https://my.datomic.com/repo/com/datomic/datomic-pro/${DATOMIC_VERSION}/datomic-pro-${DATOMIC_VERSION}.zip -O datomic-pro-${DATOMIC_VERSION}.zip
RUN unzip datomic-pro-${DATOMIC_VERSION}.zip
RUN mv datomic-pro-${DATOMIC_VERSION} datomic
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/transactor
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/classpath

FROM adoptopenjdk/openjdk8:jdk8u252-b09-alpine-slim

COPY --from=build /opt/datomic /opt/datomic

COPY logback.xml /opt/datomic/bin/logback.xml
