

# Uploading files
```
s3cmd -c ~/.s3cfg_in_us --recursive --force --acl-public --add-header="Cache-Control: public, max-age=2628000" --add-header="expires: access plus 30 days" put /loca/src/* s3://cdn.islamic.network/quran/audio/
```
