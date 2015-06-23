# kist
##Keep-It-Simple-Tv

###Custom HTTP proxy server for TivoToGo

####Requires:

* perl
* tivodecode
* curl
* libxml2-utils: ( xmllint )
* xsltproc: ( xsltproc )
* or
libsaxonb-java: ( saxonb-xslt )

[ /usr/bin/ or /usr/local/bin/ ]

####Tested Server:

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

#####Logos can be added to docroot/html/images/logos/ with the filenames:

    1.png
    2.png
    3.png
    ...
    999.png
    
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
* support PATH
* render Details page
* Channel logo grabber
* WAN access + Auth
* Enlarge cache
* Verify sane inputs
* Redesign HTML UI

####More R&D:

* Debug VLC's file length detection
* Attempt transcoding
* Attempt Tivo side scrub
