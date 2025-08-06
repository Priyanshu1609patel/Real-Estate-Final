#!/bin/bash

# Set error handling
set -e

# Log environment information
echo "===== Starting Application ====="
date
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Ensure we're in the correct directory
cd "$(dirname "$0")"

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ] || [ "$FORCE_INSTALL" = "true" ]; then
  echo "Installing dependencies..."
  npm install --no-optional
fi

# Set production environment variables
export NODE_ENV=production

# Start the backend server with better error handling
echo "Starting server..."
node backend/server.js

# If we get here, the server crashed
RETVAL=$?
echo "Server stopped with exit code $RETVAL"
exit $RETVAL
