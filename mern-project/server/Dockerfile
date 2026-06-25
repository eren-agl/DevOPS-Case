
FROM node:18-alpine

# çalışma klasörü
WORKDIR /app

# paket dosyalarını kopyala ve kur
COPY package*.json ./
RUN npm install

# copy rest
COPY . .

# port
EXPOSE 5000

# start 
CMD ["npm", "start"]