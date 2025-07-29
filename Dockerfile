# Use Node.js 22
FROM node:22

# Set working directory for backend
WORKDIR /app/backend

# Copy backend package files and install dependencies
COPY backend/package*.json ./
RUN npm install

# Copy backend source code
COPY backend/. .

# Expose backend port
EXPOSE 3001

# Start backend server
CMD ["npm", "start"]
