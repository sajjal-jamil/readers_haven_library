# FROM defines the base image
FROM node:22-alpine AS builder
# WORKDIR sets the working directory
WORKDIR /app
# COPY copies the packages file
COPY package*.json ./ 
# instal dependencies
RUN npm ci
# copy source and styles files
COPY src/ ./src/
COPY styles/ ./styles/
# build websites
RUN npm run build
# stage 2 serve website using nginx
FROM nginx1.27-alpine
# copy website from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html
# expose port
EXPOSE 80
#start nginx
CMD ["nginx", "-g", "daemon off;"]
