# Use an appropriate base image for building the application
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json and install dependencies
COPY package*.json ./

# Install all dependencies
RUN npm install --force
RUN npm install -g @angular/cli

# Copy the bash script to the Docker image
COPY modify_quill_editor.sh ./

# Verify the script is copied correctly and give it execute permissions
RUN ls -la /app && chmod +x /app/modify_quill_editor.sh

# Execute the bash script to modify the quill-editor.component.d.ts file
RUN /app/modify_quill_editor.sh

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build --prod

# Use a lightweight web server to serve the frontend and deployment process
FROM nginx:alpine

# Copy the build output from the build stage to the nginx web server directory
COPY --from=build /app/dist/lms-front-ang /usr/share/nginx/html

# Expose the port on which the frontend will run
EXPOSE 80

# Start the web server
CMD ["nginx", "-g", "daemon off;"]

