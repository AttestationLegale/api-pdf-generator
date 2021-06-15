FROM openjdk:8-jdk-alpine AS BUILDER
ARG APP_HOME=/tmp/build/
ARG MVN_PROFILE=prod

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    SPRING_JPA_SHOW_SQL=false
RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}
ADD . .

# Build dynamic env and application
# Please provide secrets: MAVEN_OFA_USERNAME, MAVEN_OFA_PASSWORD
RUN mkdir -p /shared/ \
    && chmod -R 544 /shared \
    && ./mvnw package -P${MVN_PROFILE} -DskipTests=true -Dmaven.javadoc.skip=true -B -V \
    && echo "DD_VERSION=$(./mvnw org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate \
        -Dexpression=project.version -q -DforceStdout)" >> /shared/app.env \
    && echo "DD_SERVICE=$(./mvnw org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate \
        -Dexpression=project.artifactId -q -DforceStdout)" >> /shared/app.env

# Datadog java agent install
ADD https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST /shared/dd-java-agent.jar

#########################################################################################################
FROM openjdk:8-jdk-alpine
LABEL name="api-pdf-generator" \
      description="api-pdf-generator OnceForAll Docker image" \
      vcs-url="https://github.com/AttestationLegale/api-pdf-generator"

ARG APP_HOME=/tmp/build/
ENV SPRING_OUTPUT_ANSI_ENABLED=NEVER \
    JAVA_OPTS="-Xmx256m" \
    # Datadog ENV
    DD_PROFILING_ENABLED="false" \
    ## DD_ENV, DD_SERVICE, DD_VERSION should be filled at build or runtime
    DD_ENV="none" \
    DD_SERVICE="api-pdf-generator" \
    DD_VERSION="undefined" \
    DD_TAGS=""

RUN apk --no-cache add curl
COPY src/main/resources/docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# add directly the war
COPY --from=BUILDER /shared/app.env /shared/app.env
COPY --from=BUILDER /shared/dd-java-agent.jar /shared/dd-java-agent.jar
COPY --from=BUILDER ${APP_HOME}target/*.war /app.war

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD export TEST_ENV=$LOCAL_IP && \
    export $(grep -v '^#' /shared/app.env | xargs -d '\n') && \
    export DATADOG_TRACE_AGENT_HOSTNAME=$(curl --retry 5 --connect-timeout 3 -s 169.254.169.254/latest/meta-data/local-ipv4) && \
java -javaagent:/shared/dd-java-agent.jar ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.war
