#!/bin/bash

set -e
initfile=$(echo $HOST_HOSTNAME)\spotweb.initialised
if [ -f /config/$(echo $initfile) ]; then
    echo 'initial configuration done.'
else    
    git clone https://github.com/TrueOsiris/spotweb.git /www/spotweb
    echo "<? header('Location: /spotweb/'); ?>" > /www/index.php
    echo -e "Do not remove this file.\nIf you do, container will be fully reset on next start." > /config/$(echo $initfile)
    date >> /config/$(echo $initfile)
fi
