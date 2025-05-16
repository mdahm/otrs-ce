FROM otrs-linux

# https://otrscommunityedition.com/doc/manual/admin/6.0/en/html/manual-installation-of-otrs.html

ARG VERSION

WORKDIR /opt

# Download OTRS
RUN curl -O https://otrscommunityedition.com/download/otrs-community-edition-${VERSION}.tar.gz && \
    tar xf otrs-community-edition-${VERSION}.tar.gz && rm -f otrs-community-edition-${VERSION}.tar.gz && \
    mv otrs-community-edition-${VERSION} otrs

#perl /opt/otrs/bin/otrs.CheckModules.pl

# Setup OTRS user
RUN useradd -d /opt/otrs -c 'OTRS user' -s /bin/bash -M -N otrs && usermod -G www-data otrs


# Setup OTRS configuration
RUN cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm && \
    sed -i -e 's/127.0.0.1/mariadb/g' -e 's/some-pass/23e117b59bf1d/g' /opt/otrs/Kernel/Config.pm && \
    ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/otrs.conf && \
    perl /opt/otrs/bin/otrs.SetPermissions.pl

# Setup CRON
RUN su - otrs && cd /opt/otrs/var/cron && for foo in *.dist; do cp $foo `basename $foo .dist`; done

# Setup Apache
# a2enconf otrs &&
RUN echo 'ServerName otrs' >> /etc/apache2/apache2.conf && \
    a2enmod perl headers deflate filter cgi && service apache2 restart

# Startup
ADD start-otrs.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start-otrs.sh

EXPOSE 80 443
CMD ["start-otrs.sh"]
