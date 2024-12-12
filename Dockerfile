FROM node:18

WORKDIR /app

# Copy the entire repository content
COPY . .

# Install global dependencies
RUN npm install -g cross-env vite --force

# Clean yarn cache and install dependencies for the entire workspace
RUN yarn cache clean
RUN yarn install --frozen-lockfile --network-timeout 300000

# Set build environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development
ENV NODE_ENV=production

# Build the app
WORKDIR /app/excalidraw-app
# Remove the separate yarn install since we already installed workspace dependencies
RUN yarn build

# Serve the built files
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-p", "3000"]

EXPOSE 3000