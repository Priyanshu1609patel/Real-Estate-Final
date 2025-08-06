#!/bin/bash

# Install backend dependencies
cd backend
npm install

# No build step needed for static frontend files
# Frontend files will be served as static content by the Node.js backend

echo "Build completed successfully"
