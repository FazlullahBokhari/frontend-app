# Build Stage
FROM node:18 AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build -- --configuration=production

# Runtime Stage
FROM nginx:alpine
COPY --from=build /app/dist/frontend-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]