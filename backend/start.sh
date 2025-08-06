#!/bin/sh

# Set environment
NODE_ENV=${NODE_ENV:-production}
export NODE_ENV

# Log environment info
echo "=== Starting Real Estate Backend ==="
date
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"
echo "NODE_ENV: $NODE_ENV"

# Log database connection info (without sensitive data)
echo "Database host: ${MYSQLHOST:-Not set}"
echo "Database port: ${MYSQLPORT:-3306}"
echo "Database name: ${MYSQLDATABASE:-Not set}"
echo "Database user: ${MYSQLUSER:-Not set}"
echo "SSL: ${MYSQL_SSL:-false}"

# Install dependencies if node_modules is missing
if [ ! -d "node_modules" ]; then
  echo "Installing dependencies..."
  npm install || { echo "Failed to install dependencies"; exit 1; }
fi

# Start the server
echo "Starting server..."
exec node server.js
