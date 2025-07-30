# Use Node.js 22
FROM node:22

# Set working directory
WORKDIR /app

# Copy backend package files
COPY backend/package*.json ./backend/

# Install backend dependencies
RUN cd backend && npm install

# Copy the whole project (backend + frontend)
COPY . .

# Ensure node_modules is in the right place
RUN cd backend && npm install

# Expose backend port
EXPOSE 3001

# Start backend server
CMD ["node", "backend/server.js"]
