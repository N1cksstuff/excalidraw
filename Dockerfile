FROM node:16

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Build the app
RUN npm run build

# Start the app
CMD ["npm", "start"]

# Expose the port
EXPOSE 3000