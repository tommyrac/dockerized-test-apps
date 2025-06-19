FROM eclipse-temurin:17-jre

WORKDIR /app

# Download the AWS Distro for OpenTelemetry Java agent
ADD https://github.com/aws-observability/aws-otel-java-instrumentation/releases/latest/download/aws-opentelemetry-agent.jar /opt/aws-opentelemetry-agent.jar

# Copy the application JAR
COPY build/libs/java-simple.jar app.jar

# Expose the application port
EXPOSE 8050

# Set the JAVA_TOOL_OPTIONS environment variable to enable auto-instrumentation
ENV JAVA_TOOL_OPTIONS="-javaagent:/opt/aws-opentelemetry-agent.jar"

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
