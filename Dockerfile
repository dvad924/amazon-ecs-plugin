ARG JAVA_VERSION=1.8

FROM apps/centos/java:${JAVA_VERSION}

COPY . /app/src

WORKDIR /app/src
