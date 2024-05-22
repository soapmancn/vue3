# 使用 Node.js 20 作为构建阶段的基础镜像
FROM node:20 AS build-stage
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# 使用 Nginx 作为生产阶段的基础镜像
FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
