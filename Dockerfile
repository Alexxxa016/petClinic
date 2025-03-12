# Use an OpenJDK runtime as a base image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged jar file into the container
# This assumes the Maven build produces a jar file in the target directory.
COPY target/*.jar app.jar

# Expose port 8080 (or the port your application listens on)
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
