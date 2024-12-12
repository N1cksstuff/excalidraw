FROM node:18

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install global dependencies with force flag
RUN npm install -g cross-env --force

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the code
COPY . .

# Set environment variables
ENV VITE_APP_ENABLE_TRACKING=true
ENV VITE_APP_GIT_SHA=development

# Build the app
RUN yarn build

# Start the app
CMD ["yarn", "start"]

# Expose the port
EXPOSE 3000