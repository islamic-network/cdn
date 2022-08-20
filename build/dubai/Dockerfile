FROM nginx:1.23

COPY nginx.conf /etc/nginx/nginx.conf
COPY ../common/sites-available/* /etc/nginx/templates/
COPY ../common/purge.sh /purge
RUN  chmod 775 /purge

ENV ISLAMIC_NETWORK_CDN_ORIGIN "cdn.islamic.network.ap-south-1.linodeobjects.com"
ENV ALADHAN_CDN_ORIGIN "cdn.aladhan.com.ap-south-1.linodeobjects.com"
ENV POP "Dubai"
ENV LOCAL_CDN_HOSTNAME "cdn.dubai.islamic.network"