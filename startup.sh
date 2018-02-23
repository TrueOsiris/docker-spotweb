#!/bin/bash

set -e
initfile=spotweb.initialised
if [ -f /config/$(echo $initfile) ]; then
    echo 'initial spotweb configuration done.'
else    
    chmod -R 777 /www 2>&1
    echo "> Cloning into /www/spotweb ..."
    git clone https://github.com/TrueOsiris/spotweb.git /www/spotweb 2>&1
    echo "> Cloning done."
    echo "> Changing ownership of on /www/spotweb ..."
    chown -R www-data:www-data /www/spotweb
    echo "> Ownership changed."
    echo "> Creating index.php in root folder ..."
    echo "<? header('Location: /spotweb/'); ?>" > /www/index.php
    echo "> Creating /config/dbsettings.inc.php ..."
    touch /config/dbsettings.inc.php 2>/dev/null
    echo "> Changing ownership of /config/dbsettings.inc.php ..."
    chown www-data:www-data /config/dbsettings.inc.php 2>&1
    #rm /www/spotweb/dbsettings.inc.php 2>/dev/null
    echo "> Creating symlink to /config/dbsettings.inc.php in /www/spotweb/ ..."
    ln -s /config/dbsettings.inc.php /www/spotweb/dbsettings.inc.php 2>/dev/null

    # creating file, so previous statements only run once.
    echo -e "Do not remove this file.\nIf you do, container will be fully reset on next start." > /config/$(echo $initfile)
    date >> /config/$(echo $initfile)
fi

if [ ! -f /config/ownsettings.php ]; then
    echo "> Creating /config/ownsettings.php ..."
    touch /config/ownsettings.php 
    chown www-data:www-data /config/ownsettings.php
    echo "> Creating symlink to /config/ownsettings.php in /www/spotweb/ ..."
    ln -s /config/ownsettings.php /www/spotweb/ownsettings.php
fi



