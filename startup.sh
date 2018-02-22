#!/bin/bash

set -e
initfile=$(echo $HOST_HOSTNAME)\spotweb.initialised
if [ -f /config/$(echo $initfile) ]; then
    echo 'initial configuration done.'
else    
    chmod -R 777 /www 2>&1
    git clone https://github.com/TrueOsiris/spotweb.git /www/spotweb
    chown -R www-data:www-data /www/spotweb
    echo "<? header('Location: /spotweb/'); ?>" > /www/index.php
    touch /config/dbsettings.inc.php 2>/dev/null
    chown www-data:www-data /config/dbsettings.inc.php
    rm /www/spotweb/dbsettings.inc.php 2>/dev/null
    ln -s /config/dbsettings.inc.php /www/spotweb/dbsettings.inc.php 2>/dev/null
    # creating file, so previous statements only run once.
    echo -e "Do not remove this file.\nIf you do, container will be fully reset on next start." > /config/$(echo $initfile)
    date >> /config/$(echo $initfile)
fi

if [ ! -f /config/ownsettings.php ]; then
    touch /config/ownsettings.php && chown www-data:www-data /config/ownsettings.php
    ln -s /config/ownsettings.php /www/spotweb/ownsettings.php
fi

if [[ -z "$SPOTWEB_DB_TYPE" ]]; then
    SPOTWEB_DB_TYPE="mysql"
fi
if [[ -z "$SPOTWEB_DB_NAME" ]]; then
    SPOTWEB_DB_NAME="spotweb"
fi
if [[ -z "$SPOTWEB_DB_USER" ]]; then
    SPOTWEB_DB_USER="spotweb"
fi
if [[ -z "$SPOTWEB_DB_PASS" ]]; then
    SPOTWEB_DB_PASS="spotweb"
fi

if [[ -n "$SPOTWEB_DB_TYPE" && -n "$SPOTWEB_DB_HOST" && -n "$SPOTWEB_DB_NAME" && -n "$SPOTWEB_DB_USER" && -n "$SPOTWEB_DB_PASS" ]]; then
#    echo "Creating database configuration"
    if [ -z `cat /config/dbsettings.inc.php` ]; then
        echo "<?php" > /config/dbsettings.inc.php
        echo "\$dbsettings['engine'] = '$SPOTWEB_DB_TYPE';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['host'] = '$SPOTWEB_DB_HOST';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['dbname'] = '$SPOTWEB_DB_NAME';"  >> /config/dbsettings.inc.php
        echo "\$dbsettings['user'] = '$SPOTWEB_DB_USER';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['pass'] = '$SPOTWEB_DB_PASS';"  >> /config/dbsettings.inc.php
    else
    	echo "$(date +%S)"
 	if [ $((`date +%S` % 5)) = 0 ]; then
		echo "test" 
	fi
    fi
fi
