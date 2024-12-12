FROM node:18

WORKDIR /app

# Copy the entire repository content
COPY . .

# Install global dependencies
RUN npm install -g cross-env --force

# Install all workspace dependencies
RUN yarn install --frozen-lockfile

# Install Vite dependencies explicitly
RUN cd excalidraw-app && yarn add -D @vitejs/plugin-react vite

# Set build environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development
ENV NODE_ENV=production

# Build the specific package we need
RUN cd excalidraw-app && yarn build:app

# Set working directory to the built app
WORKDIR /app/excalidraw-app

# Serve the built files instead of running the dev server
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-p", "3000"]

EXPOSE 3000