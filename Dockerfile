# Multi-stage Dockerfile based on https://github.com/WISVCH/connect
FROM maven:3.5-jdk-8 as builder

LABEL maintainer="Justin Anderson <jander@mit.edu>"

# Pre-download dependencies to speed up repeat builds
COPY pom.xml /src/pom.xml
COPY mit-cxsci-openid-connect/pom.xml /src/mit-cxsci-openid-connect/pom.xml
WORKDIR /src
RUN mvn -s /usr/share/maven/ref/settings-docker.xml dependency:resolve-plugins dependency:resolve package

# Build MITREid Connect with overlay
COPY mit-cxsci-openid-connect /src/mit-cxsci-openid-connect

RUN mvn -s /usr/share/maven/ref/settings-docker.xml package

FROM tomcat:9-jre8-slim

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /src/mit-cxsci-openid-connect/target/mit-cxsci-openid-connect-server.war /usr/local/tomcat/webapps/ROOT.war

# Containers should override /etc/mitreid-connect to change server settings.
COPY config /etc/mitreid-connect

# Containers should persist this volume to persist server data across runs.
VOLUME /etc/hsqldb/data
