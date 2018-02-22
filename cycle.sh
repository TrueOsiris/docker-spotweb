#!/bin/bash

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
    echo "Spotweb db params are set. Creating database configuration ..."
    if [[ -s /config/dbsettings.inc.php ]]; then
       	echo "$(date +%S)"
 	if [ $((`date +%S` % 5)) = 0 ]; then
		echo "test" 
	fi
    else
        echo "<?php" > /config/dbsettings.inc.php
        echo "\$dbsettings['engine'] = '$SPOTWEB_DB_TYPE';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['host'] = '$SPOTWEB_DB_HOST';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['dbname'] = '$SPOTWEB_DB_NAME';"  >> /config/dbsettings.inc.php
        echo "\$dbsettings['user'] = '$SPOTWEB_DB_USER';" >> /config/dbsettings.inc.php
        echo "\$dbsettings['pass'] = '$SPOTWEB_DB_PASS';"  >> /config/dbsettings.inc.php
    fi
fi
