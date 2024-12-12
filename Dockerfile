FROM node:18

WORKDIR /app

# Copy all files
COPY . .

# Install global dependencies with force flag
RUN npm install -g cross-env --force

# Install dependencies in the workspace root
RUN yarn install --frozen-lockfile

# Install specific dependencies in the app directory
RUN cd excalidraw-app && yarn add -D vite vite-plugin-html @vitejs/plugin-react

# Set environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development

# Build the app from the app directory
RUN cd excalidraw-app && yarn build

# Set working directory to the app
WORKDIR /app/excalidraw-app

# Start the app
CMD ["yarn", "start"]

# Expose the port
EXPOSE 3000