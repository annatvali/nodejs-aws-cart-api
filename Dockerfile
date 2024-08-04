# Use Node.js 20 as base image
FROM node:20

# Set up working directory
WORKDIR /app

# Copy over package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy rest of the app code
COPY . .

# Build the app
RUN npm run build

# Use port 3000 for the app
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
