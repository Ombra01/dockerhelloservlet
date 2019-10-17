FROM gradle:4.7.0-jdk8-alpine AS build

LABEL "maintainer"="Ombra"

COPY --chown=gradle:gradle . /src
WORKDIR /src
RUN gradle war --no-daemon


FROM tomcat:8.0-alpine

LABEL "maintainer"="Ombra"

COPY --from=build src/build/libs/dockerhelloservlet-1.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]