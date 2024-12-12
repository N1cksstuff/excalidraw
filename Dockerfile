FROM node:18

WORKDIR /app

# Copy the entire repository content
COPY . .

# Install global dependencies with specific versions
RUN npm install -g cross-env@7.0.3 vite@5.0.12 --force

# Clean yarn cache and install dependencies with specific resolutions
RUN yarn cache clean
RUN echo '{\n\
  "resolutions": {\n\
    "@babel/core": "^7.0.0",\n\
    "strip-ansi": "^6.0.1",\n\
    "typescript": "^5.0.2",\n\
    "react": "^18.2.0"\n\
  }\n\
}' > .yarnrc.json

# Install workspace dependencies
RUN yarn install --frozen-lockfile --network-timeout 300000

# Set build environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development
ENV NODE_ENV=production
ENV VITE_APP_DOCKER_BUILD=true

# Move to app directory and install its dependencies
WORKDIR /app/excalidraw-app
RUN yarn add -D @vitejs/plugin-react@4.2.1 vite-plugin-html@3.2.2 vite@5.0.12 vite-plugin-svgr@4.2.0 vite-plugin-ejs@1.7.0 vite-plugin-pwa@0.17.4 typescript@5.0.2

# Build the app using the app's build script
RUN yarn build:app:docker

# Serve the built files
RUN npm install -g serve
CMD ["serve", "-s", "build", "-p", "3000"]

EXPOSE 3000