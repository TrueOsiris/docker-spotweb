# spotweb

Base webserver with 2 external volumes : /config & /www \
/config holds all apache2 & php7.0 config files \
/www is the entire webroot \
\
`docker create 
 -p 4567:80 
 -v /some/host/folder/www:/www 
 -v /some/host/folder/config:/config 
 -e TZ=Europe/Brussels 
 --name spotweb 
 --restart=unless-stopped 
 trueosiris/spotweb` \
\
`docker container start spotweb` \
\
`docker exec -it spotweb /bin/bash` \
\
`docker logs -f spotweb` \
