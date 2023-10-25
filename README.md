# Datomic Pro on Alpine Linux

[Datomic Pro](https://www.datomic.com/on-prem.html) Docker container running on Alpine Linux. 
The base container is [JDK-11-alpine by Eclipse Temurin](https://hub.docker.com/_/eclipse-temurin). 

## Repository

This image is maintained in [Docker Hub](https://hub.docker.com/repository/docker/vouchio/datomic-pro-alpine/general)

## Usage

### Building

```bash
./build.sh build
```

### Configuration

#### transactor.properties

You have to configure Datomic by providing a `transactor.properties` file while running the container. 
There intentionally is no default config since it depends on the storage backend you intend to use.

#### data directory

Configure the data directory in `transactor.properties` and mount it into the container.

#### Logging

Logging has been setup to log to stdout by default. You can change this behaviour by modifying 
`/opt/datomic/bin/logback.xml`

### Running 

An example for running this container:

```bash
GIT_SHA=$(git rev-parse HEAD) ## git SHA of this repo
JVM_OPTS="-Xms1g -Xmx2g"
docker run -v $(pwd)/transactor.properties:/etc/datomic/transactor.properties \
  -v $(pwd)/data:/data \
  docker.pkg.github.com/vouchio/datomic-pro-alpine/datomic-pro-alpine:1.0.6222-$GIT_SHA \
  sh -c "/opt/datomic/bin/transactor $JVM_OPTS /etc/datomic/transactor.properties"
```
