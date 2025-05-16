#!/bin/bash

service cron start

#su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
#su -c "/opt/otrs/bin/Cron.sh start" -s /bin/bash otrs

# Start Apache
apachectl -D FOREGROUND
