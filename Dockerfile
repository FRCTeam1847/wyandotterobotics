FROM node:lts as runtime
WORKDIR /app

RUN mkdir /app/.astro
# Copy the cache directory from the build context
COPY .astro-cache/cache /app/.astro/cache

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the application files
COPY . .

RUN ls -la /app/.astro/cache && echo "Cache-busting: $(date +%s)"

# Build the Astro project
RUN npm run build

# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=4321

# Expose port 4321 for the application
EXPOSE 4321

# Start the production server
CMD ["npm", "run", "preview"]