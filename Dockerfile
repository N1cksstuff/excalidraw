FROM node:18

# Set working directory to the app directory directly
WORKDIR /app/excalidraw-app

# Copy package files from the app directory
COPY excalidraw-app/package*.json ./
COPY excalidraw-app/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy only the app directory contents
COPY excalidraw-app/ ./

# Set environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development
ENV NODE_ENV=production

# Build the app
RUN yarn build

# Start the app
CMD ["yarn", "start"]

# Expose the port
EXPOSE 3000