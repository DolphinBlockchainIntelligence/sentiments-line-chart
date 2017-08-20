# docker build -t sentiments-line-chart .
# docker run -d --name sentiments-line-chart -p 5002:8080 sentiments-line-chart
FROM node:6.10-alpine
LABEL maintainer="Eugen Soloviov"
COPY app /app
COPY master /app/master
COPY register.json /app/register.json
WORKDIR /master/master
RUN npm install
RUN node build/build.js
WORKDIR /master
RUN npm install
CMD ["node","index.js"]