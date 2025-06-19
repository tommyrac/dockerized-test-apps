#!/bin/bash

# Script to build and push the Java application to the local registry
# Usage: ./build-and-push.sh [tag]
# If no tag is provided, 'latest' will be used

# Set default values
REGISTRY="localhost:5000"
IMAGE_NAME="test-java"
TAG=${1:-latest}

echo "=== Building Java application with Gradle ==="
gradle assemble

if [ $? -ne 0 ]; then
  echo "Gradle build failed. Exiting."
  exit 1
fi

echo "=== Building Docker image: $REGISTRY/$IMAGE_NAME:$TAG ==="
docker build -t $REGISTRY/$IMAGE_NAME:$TAG .

if [ $? -ne 0 ]; then
  echo "Docker build failed. Exiting."
  exit 1
fi

echo "=== Pushing image to registry: $REGISTRY/$IMAGE_NAME:$TAG ==="
docker push $REGISTRY/$IMAGE_NAME:$TAG

if [ $? -ne 0 ]; then
  echo "Docker push failed. Exiting."
  exit 1
fi

echo "=== Successfully built and pushed $REGISTRY/$IMAGE_NAME:$TAG ==="
echo "To run the container: docker run -p 8050:8050 $REGISTRY/$IMAGE_NAME:$TAG"
