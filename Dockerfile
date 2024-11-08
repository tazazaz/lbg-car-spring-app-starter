# Stage 1: Build the Maven project

FROM maven:3.8.4-openjdk-11-slim AS builder

# Set the working directory inside the container

WORKDIR /app

# Copy the pom.xml and src directory to the container  (only for the build context)

COPY pom.xml .

# Download the dependencies(this helps with caching layers)

RUN mvn dependency:go-offline

# Copy the entire project into the container

COPY src /app/src

# Build the application(thisgenerates the target/myapp.jar file)

RUN mvn -Dmaven.test.skip -Dmaven.compile.skip package

# Stage 2: Create a smaller runtime image with OpenJDK

FROM openjdk:11-jre-slim

# Set the working directory inside the container

WORKDIR /app

# Copy the built JAR file from the builder stage

COPY --from=builder /app/target/cardatabase-0.0.1-SNAPSHOT.jar /app/myapp.jar

# Expose the port the application runs on (e.g., 8080)

EXPOSE 8080

# Run the application (replace with your actual class name if necessary)

ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
