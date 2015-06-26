# kist
##Keep-It-Simple-Tv

###Custom HTTP proxy server for TivoToGo

####Requires:

* perl
* tivodecode
* curl
* libxml2-utils: ( xmllint )
* XSLT via:
xsltproc: ( xsltproc ) or 
libsaxonb-java: ( saxonb-xslt )

[ /usr/bin/ or /usr/local/bin/ ]

####Tested Servers:

*  Ubuntu
*  Mac 10.10
*  FreeBSD

####Tested Clients:

* VLC on Linux  
* VLC on Mac
* VLC Firefox Plugin

#####Sketchy Clients:

* gnome VLC plugin
* gnome totem / videos

####Getting started:

1. Edit 2 lines [ IP and MAK ] in bin/Conf.pm for your Tivo
2. Start daemon: `bin/kistd`
3. Contact server from web browser, on port 8080

#####Channel logos come from a backend service.  If yours are missing, message the author with your lineup URL from zap2it.com

####CLI Usage:

    $ bin/fid_mpg [host=192.168.1.100] 123456
    < mpeg TS of fileID follows >

    $ bin/fid_xml [host=tivo.mydomain] 123456
    < xml details of fileID follows >

    $ bin/dvr_xml 
    < xml index from default IP follows >

    $ bin/dvr_html
    < html index from default IP follows >
    
    $ bin/dvr_html host=tivo.mydomain Recurse=Yes
    < html classic index from default IP follows >
 
####ToDo:

* multi DVR households
* support $PATH
* render Details page
* local Channel logo override/grabber
* WAN access + Auth
* Enlarge cache management
* Verify sane inputs
* Redesign HTML UI

####More R&D:

* Debug VLC's file length detection
* Attempt transcoding
* Attempt Tivo side scrub
