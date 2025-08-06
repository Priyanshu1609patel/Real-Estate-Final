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

# Set production environment variables
export NODE_ENV=production

# Log database connection info (without sensitive data)
echo "Database Configuration:"
echo "  Host: ${MYSQLHOST:-Not set}"
echo "  Port: ${MYSQLPORT:-3306}"
echo "  Database: ${MYSQLDATABASE:-Not set}"
echo "  User: ${MYSQLUSER:-Not set}"
echo "  SSL: ${MYSQL_SSL:-false}"

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ] || [ "$FORCE_INSTALL" = "true" ]; then
  echo "Installing dependencies..."
  npm install --no-optional --no-fund --no-audit
fi

# Start the backend server with better error handling
echo "Starting backend server..."
cd backend
node server.js

# If we get here, the server crashed
RETVAL=$?
echo "Server stopped with exit code $RETVAL"
exit $RETVAL
exit $RETVAL
