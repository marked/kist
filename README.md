# kist
##Keep-It-Simple-Tivo

###Custom HTTP proxy server for TivoToGo

Requires:

* perl
* tivodecode
* curl
* libxml2-utils: ( xmllint )
* libsaxonb-java: ( saxonb-xslt )

[ /usr/bin/ or /usr/local/bin/ ]

Tested Server on:

*  Ubuntu

Tested Clients:

* VLC on Linux  
* VLC on Mac
* VLC Firefox Plugin

Getting started:

1. Edit 2 lines [IP and MAK] in bin/Conf.pm for your Tivo
2. Start daemon: cd bin ; ./kistd
3. Contact server from web browser, on port 8080

Note for CR/LF problems:
	`$ git config --global core.autocrlf input`
	`$ git config --global core.safecrlf false`
or
	`dos2unix`
