# Build

    docker build -f Dockerfile.linux -t otrs-linux .

    docker build --build-arg VERSION=6.0.41 -t otrs .

# Start

    docker-compose up -d

# Stop

    docker-compose down

# Setup Database and the like

Visit [OTRS Installer](http://localhost:8080/otrs/installer.pl)

* Accept terms & conditions
* Use existing DB (otrs, 23e117b59bf1d)
* (Skip Email-configuration) or setup
* Make sure to remember generated root password

# Activate CRON & Daemon

    docker exec otrs su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
    docker exec otrs su -c "/opt/otrs/bin/Cron.sh start" -s /bin/bash otrs

# Further readings

* https://otrscommunityedition.com/doc/manual/admin/6.0/en/html/manual-installation-of-otrs.html