package Common;
use strict;
use warnings;

use parent 'Exporter'; # imports and subclasses Exporter

use Conf;
our $detail_xml_path	= "/TiVoVideoDetails?id=";
our $np_html_path	= "/nowplaying/index.html?";
our $np_xml_path	= "/TiVoConnect?Command=QueryContainer";
our $param_np		= "Container=/NowPlaying";
our $vid_path		= "/download/filename.TiVo?Container=%2FNowPlaying&id=";
our $param_classic	= "Recurse=Yes";
our $param_group	= "Recurse=No";

our %mime_type = (
	".mpg" => "video/mpeg"
);


our @EXPORT = qw(
 $detail_xml_path
 $np_html_path
 $np_xml_path
 $vid_path
 $param_classic
 $param_group
 $param_np
 %mime_type
);
