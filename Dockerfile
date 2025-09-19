
# Use OpenJDK base image
FROM eclipse-temurin:17-jre-jammy

# Set working directory
WORKDIR /app

# Copy JAR file (use wildcard so version doesn’t matter)
COPY target/*.jar app.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose port 8080
EXPOSE 8080
