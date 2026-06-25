# 1. Aşama: React uygulamasını derleme (Build)
FROM node:18-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 2. Aşama: Derlenen kodları Nginx ile canlıya alma
FROM nginx:alpine
# Nginx'in varsayılan sayfasını silip, kendi oluşturduğumuz dosyaları koyuyoruz
COPY --from=build-stage /app/build /usr/share/nginx/html

# Web yayını için standart 80 portunu açıyoruz
EXPOSE 80

# Nginx'i arka planda sürekli çalışacak şekilde başlatıyoruz
CMD ["nginx", "-g", "daemon off;"]