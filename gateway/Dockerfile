# Base image with Node.js 22
FROM node:22

# Set working directory
WORKDIR /app

# Copy package.json + lock first for caching
COPY gateway/package*.json ./

# Copy the public folder (index.html)
COPY gateway/public/ /app/public/

# Install all dependencies (including devDependencies)
RUN npm install

# Copy rest of the gateway source
COPY gateway .

# Default port
EXPOSE 2025

# Run your dev command
CMD ["npm", "run", "dev"]