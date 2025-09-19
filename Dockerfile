# Use OpenJDK base image
FROM eclipse-temurin:17-jre-jammy

# Set working directory
WORKDIR /app

# Copy JAR file into the container
COPY target/hello-boot-1.0.0.jar app.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose port 8080
EXPOSE 8080
