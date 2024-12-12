FROM node:18

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install global dependencies
RUN npm install -g cross-env yarn

# Install dependencies with legacy peer deps flag
RUN npm install --legacy-peer-deps

# Copy the rest of the code
COPY . .

# Set environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development

# Build the app using yarn
RUN yarn install
RUN yarn build

# Start the app
CMD ["yarn", "start"]

# Expose the port
EXPOSE 3000