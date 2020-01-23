FROM openjdk:8-jdk-alpine

ENV SPRING_OUTPUT_ANSI_ENABLED=NEVER \
    JHIPSTER_SLEEP=0 \
    JAVA_OPTS="-Xmx256m"

# add directly the war
ADD target/*.war /app.war
ADD https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST /user/local/lib/dd-java-agent.jar

EXPOSE 8080

CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
    sleep ${JHIPSTER_SLEEP} && \
    java -javaagent:/user/local/lib/dd-java-agent.jar ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.war
