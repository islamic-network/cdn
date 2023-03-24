# Islamic Network CDN

This is the harness used for the Islamic Network CDN. It's effectively ready to be used by anyone who wants to build a CDN.

It contains 3 directories:

* nginx - This directory contains all the NGINX and Docker configuration for the CDN
warranted.
* info - This is purely informational and has files that are linked from outside of this repo and the CDN. It's not really related to the CDN setup, 
but relevant for users who consume assets on the Islamic Network CDN.
* purge - This directory triggers the pipeline to actually purge the cache from all the PoPs. Just update the paths.txt file's first line with what needs to be purged.
Many thanks to https://github.com/perusio/nginx-cache-purge for this script.

## Notes

### Purging cache

To purge a file:

```
docker exec -it islamic-network-cdn ./purge /quran/audio-surah/128/ar.alafasy/1.mp3 /var/cache/cdn
```

To purge a directory / path:

```
docker exec -it islamic-network-cdn ./purge /quran/audio-surah/128/ar.alafasy /var/cache/cdn
```



### Uploading files to an s3 bucket  (this is a sample for 1 region)
```
s3cmd -c ~/.s3cfg_in_us --recursive --force --acl-public --add-header="Cache-Control: public, max-age=2628000" --add-header="expires: access plus 30 days" put /local/src/* s3://cdn.islamic.network/quran/audio/
```

### Generating Certificates on the first node

Install acme.sh:

```
wget -O - https://get.acme.sh | bash; source ~/.bashrc
```

Then generate the certificates:

```
 acme.sh --issue --dns dns_cf -d cdn.islamic.network \
 -d cdn.helsinki.islamic.network \
 -d cdn.falkenstein.islamic.network \
 -d cdn.singapore.islamic.network \
 -d cdn.london.islamic.network \
 -d cdn.mumbai.islamic.network \
 -d cdn.sydney.islamic.network \
 -d cdn.newark.islamic.network \
 -d cdn.dallas.islamic.network \
 -d cdn.dubai.islamic.network \
 -d cdn.aladhan.com \
 --reloadcmd "docker exec -it islamic-network-cdn nginx -s reload"
```

These then need to be copied to all the other nodes via a monthly cronjob. This cron should be configured on the primary host for every PoP:

```
scp -r -P XXXXX /root/.acme.sh/cdn.islamic.network/* root@cdn.mumbai.islamic.network:/root/.acme.sh/cdn.islamic.network/ && ssh -t root@cdn.mumbai.islamic.network -p XXXXX  "docker exec -it islamic-network-cdn nginx -s reload"
```

# Nodes that are not built and deployed via this repo:

* Helsinki
* Falkenstein
