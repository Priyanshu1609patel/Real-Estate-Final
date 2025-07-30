# Use Node.js 22
FROM node:22

# Set working directory inside the container
WORKDIR /app

# Copy only backend package files first (for better caching)
COPY backend/package*.json ./backend/

# Install backend dependencies
WORKDIR /app/backend
RUN npm install

# Copy the whole project (backend + frontend)
WORKDIR /app
COPY . .

# Expose backend port
EXPOSE 3001

# Start backend server
CMD ["node", "backend/server.js"]
