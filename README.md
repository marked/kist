# kist
##Keep-It-Simple-Tivo

Custom HTTP proxy server for TivoToGo

Requires:

* perl
* tivodecode
* curl: /usr/bin/curl
* libxml2-utils: /usr/bin/xmllint
* libsaxonb-java: /usr/bin/saxonb-xslt

[ /usr/bin/ or /usr/local/bin/ ]

Tested Server on:

*  Ubuntu

Tested Clients:

* VLC on Linux  
* VLC on Mac
* VLC Firefox Plugin

Getting started:

1. Edit 2 lines in bin/Conf.pm for your Tivo
2. Start daemon: cd bin ; ./kistd
3. Contact server from web browser, on port 8080
