#!/bin/bash

initfile=/config/spotweb.database.initialised
dbfile=/config/dbsettings.inc.php.sample

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
    if [[ -s $(echo $dbfile) ]]; then
	if [ ! -f $(echo $initfile) ]; then
	    touch $(echo $initfile) 
            # this should just run once, as dbsettings.inc.php started empty ...
	    mydate=date
	    echo "> Running database upgrade ..."
            /usr/bin/php /www/spotweb/bin/upgrade-db.php >/dev/null 2>&1
	    echo "> Database upgrade done." 
	    echo "Start db upgrade at $(mydate)" >> $(echo $initfile)
	    echo "Finished at $(date)" >> $(echo $initfile)
	fi
       	# echo "$(date +%S)"
	# every 60 mins, reapply the dbsettings
	if [ $(($(date +%M) % 60)) = 0 ]; then
 	    if [ $(($(date +%S) % 60)) = 0 ]; then
	    	echo "> Reapplying db settings to $dbfile at $(date)"
                echo "<?php" > $dbfile
                echo "\$dbsettings['engine'] = '$SPOTWEB_DB_TYPE';" >> $dbfile
                echo "\$dbsettings['host'] = '$SPOTWEB_DB_HOST';" >> $dbfile
                echo "\$dbsettings['dbname'] = '$SPOTWEB_DB_NAME';"  >> $dbfile
                echo "\$dbsettings['user'] = '$SPOTWEB_DB_USER';" >> $dbfile
                echo "\$dbsettings['pass'] = '$SPOTWEB_DB_PASS';"  >> $dbfile
	    fi
	fi
    else
        echo "<?php" > $dbfile
        echo "\$dbsettings['engine'] = '$SPOTWEB_DB_TYPE';" >> $dbfile
        echo "\$dbsettings['host'] = '$SPOTWEB_DB_HOST';" >> $dbfile
        echo "\$dbsettings['dbname'] = '$SPOTWEB_DB_NAME';"  >> $dbfile
        echo "\$dbsettings['user'] = '$SPOTWEB_DB_USER';" >> $dbfile
        echo "\$dbsettings['pass'] = '$SPOTWEB_DB_PASS';"  >> $dbfile
    fi
fi

if [ $((`date +%M` % 2)) = 0 ]; then
    if [ $((`date +%S` % 60)) = 0 ]; then
  	# every 10 minutes  
	echo "> Retrieval of new spots starting at $(date) ..."
	if [[ -s /config/$(echo $initfile) ]]; then
	    /usr/bin/php /www/spotweb/retrieve.php >/config/retrieve.log 2>&1
	fi
    fi
fi

