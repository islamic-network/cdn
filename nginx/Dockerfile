FROM nginx:1.21

COPY nginx.conf /etc/nginx/nginx.conf
COPY sites-available/* /etc/nginx/templates/

ENV ISLAMIC_NETWORK_CDN_ORIGIN "cdn.islamic.network.ap-south-1.linodeobjects.com"
ENV ALADHAN_CDN_ORIGIN "cdn.aladhan.com.ap-south-1.linodeobjects.com"
ENV POP "Singapore"

