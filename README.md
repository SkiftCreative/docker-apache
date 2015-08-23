# README #

This is originally based off the image here: https://hub.docker.com/r/eboraas/apache/

This is a simple Apache image. To use this image properly, you need to mount your sites content in 1 of two ways.

1) `-v /home/joe/mysite:/var/www/` where in there, exists a directory named `html`
2) `-v /home/joe/mysite/html:/var/www/html`
 
Apache serves the actual content, the document root, from `/var/www/html` with the index files listed as `index.php index.html`

## A note on SSL ##

Originally, there was support for SSL in this repo, but I removed it as my setup is configured to have SSL handled through
`tutum/haproxy`. Instructions to do so are here: https://github.com/tutumcloud/haproxy#ssl-termination

## Logging ## 

Apache is setup to log everything to `/std/out` it can be picked up by https://github.com/tutumcloud/syslogger and sent
to places like loggly or papertrail

## Simple Examples ##

Assuming you have your content at /home/jdoe/mysite/, the below will be sufficient to serve it. Note that many Docker 
users encourage mounting data from a storage container, rather than directly from the filesyetem.

- "It works!": `docker run -p 80:80 -d eboraas/apache` and browse to the host's IP address using http
- ... using non-standard ports: `docker -p 8080:80 -v /home/jdoe/mysite/:/var/www/ -d eboraas/apache`

