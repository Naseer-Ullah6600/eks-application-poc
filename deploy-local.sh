#!/bin/bash

# Local deployment script for testing
echo "🚀 Starting local deployment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build the Docker image
echo "🔨 Building Docker image..."
docker build -t eks-demo-app:local .

if [ $? -ne 0 ]; then
    echo "❌ Docker build failed!"
    exit 1
fi

# Stop any existing container
echo "🛑 Stopping existing container..."
docker stop eks-demo-app-local 2>/dev/null || true
docker rm eks-demo-app-local 2>/dev/null || true

# Run the container
echo "🚀 Starting container..."
docker run -d \
    --name eks-demo-app-local \
    -p 5000:5000 \
    -e ENVIRONMENT=local \
    -e APP_VERSION=local \
    eks-demo-app:local

if [ $? -eq 0 ]; then
    echo "✅ Application started successfully!"
    echo "🌐 Access the application at: http://localhost:5000"
    echo "🏥 Health check at: http://localhost:5000/health"
    echo "📊 API info at: http://localhost:5000/api/info"
    echo ""
    echo "📋 Container logs:"
    docker logs eks-demo-app-local
    echo ""
    echo "🛑 To stop the application: docker stop eks-demo-app-local"
else
    echo "❌ Failed to start the application!"
    exit 1
fi
