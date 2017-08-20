# docker build -t sentiments-line-chart .
# docker run -d --name sentiments-line-chart -p 5002:8080 sentiments-line-chart
FROM node:6.10-alpine
LABEL maintainer="Eugen Soloviov"
COPY src /app/src
COPY config /app/config
COPY index.html /app/index.html
COPY package.json /app/package.json
COPY build /app/build
WORKDIR /app
RUN npm install
CMD ["node","build/build.js"]
WORKDIR /app/public
COPY app /app/public
CMD ["node","index.js"]