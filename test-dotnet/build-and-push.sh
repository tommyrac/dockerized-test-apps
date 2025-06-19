#!/bin/bash
set -e

# Variables
IMAGE_NAME="test-dotnet"
TAG="latest8"
REGISTRY="localhost:5000"

echo "Building Docker image: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .

echo "Tagging image for local registry: $REGISTRY/$IMAGE_NAME:$TAG"
docker tag $IMAGE_NAME:$TAG $REGISTRY/$IMAGE_NAME:$TAG

echo "Pushing image to local registry"
docker push $REGISTRY/$IMAGE_NAME:$TAG

echo "Done! Image is available at: $REGISTRY/$IMAGE_NAME:$TAG"
