# Stage 1: Build the application
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Install Nest CLI globally
RUN npm install -g @nestjs/cli

# Copy the rest of the application source code
COPY . .

# Build the application using Nest CLI
RUN nest build

# Stage 2: Create the production image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy only the compiled output and package.json from the builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "dist/main.js"]