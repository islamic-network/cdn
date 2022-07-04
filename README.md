# Islamic Netowrk CDN

This is the harness used for the Islamic Network CDN. It's effectively ready to be used by anyone who wants to build a CDN.

It contains 3 directories:

* nginx - This directory contains all the NGINX and Docker configuration for the CDN
warranted.
* info - this is purely information and has files that are linked from outside of this repo and the CDN. It's not really related to the CDN setup, 
but relevant for users who consume assets on the Islamic Network CDN.


## Notes

### Purging cache

To purge a particular item from the cache, on the host, run:

```
docker exec -it islamic-network-cdn ./purge /quran/audio-surah/128/ar.alafasy/1.mp3 /var/cache/cdn
```

to flush a file or

```
docker exec -it islamic-network-cdn ./purge /quran/audio-surah/128/ar.alafasy /var/cache/cdn
```

to flush an entire directory / path.


### Uploading files to an s3 bucket  (this is a sample for 1 region)
```
s3cmd -c ~/.s3cfg_in_us --recursive --force --acl-public --add-header="Cache-Control: public, max-age=2628000" --add-header="expires: access plus 30 days" put /loca/src/* s3://cdn.islamic.network/quran/audio/
```

### Generating Certificates on the first node

Instal acme.sh:

```
wget -O - https://get.acme.sh | bash; source ~/.bashrc
```

Then generate the certificates:

```
 acme.sh --issue --dns dns_cf -d cdn.islamic.network -d cdn.singapore.islamic.network -d cdn.london.islamic.network -d cdn.frankfurt.islamic.network -d cdn.mumbai.islamic.network -d cdn.sydney.islamic.network -d cdn.newark.islamic.network -d cdn.dallas.islamic.network -d cdn.aladhan.com --reloadcmd "docker exec -it islamic-network-cdn nginx -s reload"
```

These then need to be copied to all the other nodes via a monthly cronjob:

```

```
