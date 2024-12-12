FROM node:18

WORKDIR /app

# Copy the entire repository content first
COPY . .

# Install global dependencies
RUN npm install -g cross-env --force

# Install all workspace dependencies
RUN yarn install --frozen-lockfile

# Set build environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development
ENV NODE_ENV=production

# Build the specific package we need
RUN cd excalidraw-app && yarn build:app

# Set working directory to the built app
WORKDIR /app/excalidraw-app

# Start command
CMD ["yarn", "start"]

EXPOSE 3000