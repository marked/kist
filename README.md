# kist
##Keep-It-Simple-Tivo

###Custom HTTP proxy server for TivoToGo

####Requires:

* perl
* tivodecode
* curl
* XSLT via:
xsltproc: ( xsltproc ) or 
libsaxonb-java: ( saxonb-xslt )

####Optional:

* libxml2-utils: ( xmllint )

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

    $ bin/fid_mpg [192.168.1.100] 123456
    < mpeg TS of fileID follows >

    $ bin/fid_xml [tivo.mydomain] 123456
    < xml details of fileID follows >

    $ bin/dvr_xml
    < xml index from default IP follows >

    $ bin/dvr_html [192.168.1.100]
    < html index from specific IP follows >
    
    $ bin/dvr_html [tivo.mydomain] Recurse=Yes&AnchorOffset=16
    < html classic index from specific IP follows >
 
####ToDo:
* multiple user sessions
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
