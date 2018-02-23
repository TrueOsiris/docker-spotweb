# spotweb

Base webserver with 2 external volumes : /config & /www \
volume /config holds all apache2 & php7.0 config files \
volume /www is the entire webroot \
\
Works with an external mysql database container (not included). \
\
At the start, point your browser to install.php & do the config. \
Everything is stored in the /config folder, so you can easily edit the files in the volume. \

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
