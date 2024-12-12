FROM node:18

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install global dependencies with force flag
RUN npm install -g cross-env --force

# Install vite and its plugins explicitly
RUN yarn add -D vite vite-plugin-html @vitejs/plugin-react

# Install all dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the code
COPY . .

# Set environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development

# Navigate to the app directory and build
RUN cd excalidraw-app && yarn install && yarn build

# Start the app
CMD ["yarn", "start"]

# Expose the port
EXPOSE 3000