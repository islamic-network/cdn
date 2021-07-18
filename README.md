# Cert issueance

acme.sh --issue --dns dns_zilore -d cdn.islamic.network --reloadcmd "service nginx reload"
acme.sh --issue --dns dns_cf -d cdn.aladhan.com --reloadcmd "service nginx reload"


# Setup
sg.cdn.islamic.network is the primary node. Cert issued only on this node. All other CDN nodes copy
ssl certs and nginx config from this node.

## Copy Certs
Syncs once a month
```
1 1 1 * * scp -P 17700 -r root@sg.cdn.islamic.network:/root/.acme.sh/cdn.islamic.network/* /root/.acme.sh/cdn.islamic.network/ && service nginx reload
1 1 1 * * scp -P 17700 -r root@sg.cdn.islamic.network:/root/.acme.sh/cdn.aladhan.com/* /root/.acme.sh/cdn.aladhan.com/ && service nginx reload
```

## Copy nginx Sites and Config
Syncs every 5 mins

```
*/5 * * * * scp -P 17700 -r root@sg.cdn.islamic.network:/etc/nginx/nginx.conf /etc/nginx/nginx.conf && service nginx reload
*/5 * * * * scp -P 17700 -r root@sg.cdn.islamic.network:/etc/nginx/sites-available/* /etc/nginx/sites-available/ && service nginx reload
*/5 * * * * scp -P 17700 -r root@sg.cdn.islamic.network:/etc/nginx/sites-enabled/* /etc/nginx/sites-enabled/ && service nginx reload


scp -P 17700 -r root@sg.cdn.islamic.network:/etc/nginx/sites-available/* /etc/nginx/sites-available/ && scp -P 17700 -r root@sg.cdn.islamic.network:/etc/nginx/sites-enabled/* /etc/nginx/sites-enabled/ && service nginx reload
```


# Local Development
 docker run -v /home/meezaan/code/islamic-network/cdn/nginx/nginx.conf:/etc/nginx/nginx.conf -v /home/meezaan/code/islamic-network/cdn/nginx/sites-available/cdn.islamic.network.conf.dev:/etc/nginx/sites-enabled/cdn.islamic.network.conf -p 80:80 nginx:1.14.2
