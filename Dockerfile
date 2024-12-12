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
# Install app-specific dependencies
RUN yarn add -D @vitejs/plugin-react vite-plugin-html vite vite-plugin-svgr vite-plugin-ejs vite-plugin-pwa vite-plugin-checker vite-plugin-sitemap
RUN yarn build:app:docker

# Serve the built files
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-p", "3000"]

EXPOSE 3000