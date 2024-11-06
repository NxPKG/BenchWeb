#
# BUILD
#
FROM docker.io/bellsoft/liberica-runtime-container:jdk-all-21-cds-musl AS build
USER root
WORKDIR /hexagon

ADD . .
RUN ./gradlew --quiet classes
RUN ./gradlew --quiet -x test installDist

#
# RUNTIME
#
FROM docker.io/bellsoft/liberica-runtime-container:jre-21-musl
ARG PROJECT=hexagon_jetty_postgresql

ENV POSTGRESQL_DB_HOST bw-database
ENV JDK_JAVA_OPTIONS --enable-preview -XX:+AlwaysPreTouch -XX:+UseParallelGC -XX:+UseNUMA -DvirtualThreads=true
ENV maximumPoolSize 300

COPY --from=build /hexagon/$PROJECT/build/install/$PROJECT /opt/$PROJECT

ENTRYPOINT [ "/opt/hexagon_jetty_postgresql/bin/hexagon_jetty_postgresql" ]
