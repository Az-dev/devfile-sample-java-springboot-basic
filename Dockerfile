# Use a base image with Java 11
FROM alpine:latest

#install java & mvn
RUN apk add --update openjdk11
RUN apk add --update maven
# Set the working directory
WORKDIR /tmp/build/inputs/app
#copy pom
COPY ./pom.xml ./
#build app
RUN mvn clean package -DskipTests
RUN ls target
RUN chmod -R 777 target/
RUN chmod -R 777 target/demo-0.0.1-SNAPSHOT.jar
# Copy the JAR file to the container
COPY target/demo-0.0.1-SNAPSHOT.jar /opt/demo-app.jar    
# Expose the port that your Spring Boot application listens on (default is 8080)
EXPOSE 8080
# Define the command to run your application
CMD ["java", "-jar", "/opt/demo-app.jar"]