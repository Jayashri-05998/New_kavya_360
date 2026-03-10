#!/bin/bash
set -e

echo "🚀 Starting KavyaProMan360 Production Build"
echo "==========================================\n"

# Detect environment
IS_PRODUCTION=${RAILWAY_ENVIRONMENT_NAME:-production}
echo "Environment: $IS_PRODUCTION"

# Check which service to start based on environment
if [[ "$SERVICE_TYPE" == "backend" ]] || [[ -z "$SERVICE_TYPE" && "$IS_PRODUCTION" == "production" ]]; then
    echo "\n📦 Starting Backend Service..."
    cd backend
    
    # Build backend
    echo "🔨 Building backend with Maven..."
    ./mvnw clean package -DskipTests -Dspring.profiles.active=prod
    
    # Start backend
    echo "✅ Backend built successfully!"
    echo "🌐 Starting backend server..."
    java -jar target/backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
    
elif [[ "$SERVICE_TYPE" == "frontend" ]]; then
    echo "\n🎨 Starting Frontend Service..."
    cd frontend
    
    # Install dependencies
    echo "📥 Installing npm dependencies..."
    npm install
    
    # Build frontend
    echo "🔨 Building frontend with Vite..."
    npm run build
    
    # Serve frontend
    echo "✅ Frontend built successfully!"
    echo "🌐 Starting frontend server..."
    npx serve -s dist -l 3000
    
else
    echo "❌ SERVICE_TYPE not set. Set it to 'backend' or 'frontend'"
    exit 1
fi
