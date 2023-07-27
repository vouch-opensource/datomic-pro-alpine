FROM alpine:3.14 as build

ARG DATOMIC_VERSION

RUN apk --no-cache add zip bash wget

WORKDIR /opt

RUN wget https://datomic-pro-downloads.s3.amazonaws.com/${DATOMIC_VERSION}/datomic-pro-${DATOMIC_VERSION}.zip -O datomic-pro-${DATOMIC_VERSION}.zip

RUN unzip datomic-pro-${DATOMIC_VERSION}.zip
RUN mv datomic-pro-${DATOMIC_VERSION} datomic
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/transactor
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/classpath
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/datomic
RUN sed -i '1s|.*|#!/bin/sh|' datomic/bin/run

FROM eclipse-temurin:11-alpine

COPY --from=build /opt/datomic /opt/datomic

COPY logback.xml /opt/datomic/bin/logback.xml
