FROM alpine:3.14 as build

ARG MYDATOMIC_USER
ARG MYDATOMIC_PASSWORD
ARG DATOMIC_VERSION

RUN apk --no-cache add zip bash wget

WORKDIR /opt

RUN wget --inet4-only --http-user=${MYDATOMIC_USER} --http-password=${MYDATOMIC_PASSWORD} \
  https://my.datomic.com/repo/com/datomic/datomic-pro/${DATOMIC_VERSION}/datomic-pro-${DATOMIC_VERSION}.zip -O datomic-pro-${DATOMIC_VERSION}.zip
RUN unzip datomic-pro-${DATOMIC_VERSION}.zip
RUN mv datomic-pro-${DATOMIC_VERSION} datomic
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/transactor
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/classpath
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/datomic
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/run

FROM eclipse-temurin:8-jdk-alpine

COPY --from=build /opt/datomic /opt/datomic

COPY logback.xml /opt/datomic/bin/logback.xml
