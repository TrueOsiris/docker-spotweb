#!/bin/bash

initfile=$(echo $HOST_HOSTNAME)\.database.initialised

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
    # echo "Spotweb db params are set. Creating database configuration ..."
    if [[ -s /config/dbsettings.inc.php ]]; then
	if [ ! -f /config/$(echo $initfile) ]; then
	    touch /config/$(echo $initfile) 
            # this should just run once, as dbsettings.inc.php started empty ...
	    echo "> Running database upgrade ..."
            /usr/bin/php /var/www/spotweb/bin/upgrade-db.php >/dev/null 2>&1
	    echo "> Database upgrade done." 
	    echo "Finished $(date)" >> /config/$(echo $initfile)
	fi
       	# echo "$(date +%S)"
	# every 2 mins, reapply the dbsettings
	if [ $(($(date +%M) % 2)) = 0 ]; then
 	    if [ $(($(date +%S) % 60)) = 0 ]; then
                echo "<?php" > /config/dbsettings.inc.php
                echo "\$dbsettings['engine'] = '$SPOTWEB_DB_TYPE';" >> /config/dbsettings.inc.php
                echo "\$dbsettings['host'] = '$SPOTWEB_DB_HOST';" >> /config/dbsettings.inc.php
                echo "\$dbsettings['dbname'] = '$SPOTWEB_DB_NAME';"  >> /config/dbsettings.inc.php
                echo "\$dbsettings['user'] = '$SPOTWEB_DB_USER';" >> /config/dbsettings.inc.php
                echo "\$dbsettings['pass'] = '$SPOTWEB_DB_PASS';"  >> /config/dbsettings.inc.php 
	    fi
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

if [ $((`date +%M` % 10)) = 0 ]; then
    if [ $((`date +%S` % 60)) = 0 ]; then
  	# every 10 minutes  
	if [[ -s /config/$(echo $initfile) ]]; then
	    /usr/bin/php /var/www/spotweb/retrieve.php >/config/retrieve.log 2>&1
	fi
    fi
fi
