# Step 1: Build Angular app
FROM node:18 as build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Step 2: Serve with Nginx
FROM nginx:alpine

# ✅ Replace Nginx default config with your own
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ✅ Copy built Angular app to Nginx public folder
COPY --from=build /app/dist/frontend-app/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]