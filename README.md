# Datomic Pro on Alpine Linux

[Datomic Pro](https://www.datomic.com/on-prem.html) Docker container running on Alpine Linux. 
The base container is [OpenJDK8 by AdoptOpenJDK](https://hub.docker.com/r/adoptopenjdk/openjdk8). 

## Usage

### Building

```bash
MYDATOMIC_USER=xxx MYDATOMIC_PASSWORD=yyy ./build.sh build
```

Retrieve your username and download key from [My Datomic](https://my.datomic.com/account).

### Configuration

#### transactor.properties

You have to configure Datomic by providing a `transactor.properties` file while running the container. 
There intentionally is no default config since you need to provide a working license.

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
