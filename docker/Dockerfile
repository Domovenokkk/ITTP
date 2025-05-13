FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY server.crt /etc/ssl/certs/server.crt
COPY server.key /etc/ssl/private/server.key

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80 443
