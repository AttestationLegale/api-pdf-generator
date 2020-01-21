FROM openjdk:8-jdk-alpine

ENV SPRING_OUTPUT_ANSI_ENABLED=NEVER \
    JHIPSTER_SLEEP=0 \
    JAVA_OPTS="-Xmx256m"

COPY src/main/resources/docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# add directly the war
ADD target/*.war /app.war
ADD https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST /user/local/lib/dd-java-agent.jar

EXPOSE 8080

RUN apk --no-cache add curl

ENTRYPOINT ["/entrypoint.sh"]
CMD export TEST_ENV=$LOCAL_IP && \
    export DATADOG_TRACE_AGENT_HOSTNAME=$(curl --retry 5 --connect-timeout 3 -s 169.254.169.254/latest/meta-data/local-ipv4) && \
    echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
    sleep ${JHIPSTER_SLEEP} && \
java -javaagent:/user/local/lib/dd-java-agent.jar ${JAVA_OPTS} -Ddd.agent.host=172.17.0.1 -Ddd.agent.port=8126 -Djava.security.egd=file:/dev/./urandom -jar /app.war
