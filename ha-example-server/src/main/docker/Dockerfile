FROM java:8
VOLUME /tmp
ADD ha-example-server.jar ha-example-server.jar
RUN bash -c 'touch /ha-example-server.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar","/ha-example-server.jar"]