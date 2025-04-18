FROM node:20-alpine
WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm install

# Copy source & build
COPY . .
RUN npm run build

# Create creds directory for OAuth JSON
RUN mkdir -p /app/.gmail-mcp \
 && chown -R node:node /app/.gmail-mcp

# Run as non-root
USER node

# Expose HTTP/SSE port
EXPOSE 3000

# Launch the MCP server
CMD ["node","dist/index.js"]
