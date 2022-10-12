# spotweb
![Trueosiris Rules](https://img.shields.io/badge/trueosiris-rules-f08060) 
[![Docker Pulls](https://badgen.net/docker/pulls/trueosiris/spotweb?icon=docker&label=pulls)](https://hub.docker.com/r/trueosiris/spotweb/) 
[![Docker Stars](https://badgen.net/docker/stars/trueosiris/spotweb?icon=docker&label=stars)](https://hub.docker.com/r/trueosiris/spotweb/) 
[![Docker Image Size](https://badgen.net/docker/size/trueosiris/spotweb?icon=docker&label=image%20size)](https://hub.docker.com/r/trueosiris/spotweb/) 
![Github stars](https://badgen.net/github/stars/trueosiris/docker-spotweb?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/trueosiris/docker-spotweb?icon=github&label=forks) 
![Github issues](https://img.shields.io/github/issues/TrueOsiris/docker-spotweb)
![Github last-commit](https://img.shields.io/github/last-commit/TrueOsiris/docker-spotweb)

Base webserver with 2 external volumes : /config & /www.
Volume /config holds all apache2 & php7.0 config files.
Volume /www is the entire webroot.

Works with an external mysql or mariadb database container (not included).
There isn't one running on localhost.

At the start, point your browser to install.php & do the config.
Everything is stored in the /config folder, so you can easily edit the files in the volume.

```
docker create 
 -p 4567:80 
 -v /some/host/folder/www:/www 
 -v /some/host/folder/config:/config 
 -e TZ=Europe/Brussels 
 --name spotweb 
 --restart=unless-stopped 
 trueosiris/spotweb
```
