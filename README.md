# spotweb
[![Docker Pulls](https://img.shields.io/docker/pulls/trueosiris/spotweb.svg)](https://hub.docker.com/r/trueosiris/spotweb/) [![Docker Stars](https://img.shields.io/docker/stars/trueosiris/spotweb.svg)](https://hub.docker.com/r/trueosiris/spotweb/) [![Docker Automated buil](https://img.shields.io/docker/automated/trueosiris/spotweb.svg)](https://hub.docker.com/r/trueosiris/spotweb/) [![Docker Build Statu](https://img.shields.io/docker/build/trueosiris/spotweb.svg)](https://hub.docker.com/r/trueosiris/spotweb/) ![GitHub last commit](https://img.shields.io/github/last-commit/trueosiris/docker-spotweb.svg)

Base webserver with 2 external volumes : /config & /www \
volume /config holds all apache2 & php7.0 config files \
volume /www is the entire webroot \
\
Works with an external mysql or mariadb database container (not included). \
There isn't one running on localhost. \
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
