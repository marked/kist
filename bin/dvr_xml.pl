#!/usr/bin/perl
use warnings;
use strict;

my $ROOT;
BEGIN { 
  my (@dirs) = split "/", $0 ;
  pop(@dirs);
  $ROOT = join( "/", @dirs);
}
use lib $ROOT;

use Common;
use Conf;

my $IP = "";
if (@ARGV > 0) {
  $IP = shift(@ARGV);
  $IP =~ s/host=//;
} else {
  die "Usage: $0 <host=HostDVR> [Query=val]\n";
}

my $params = "";
if (@ARGV > 0) {
  $params .= '&' .  shift(@ARGV);
}
if ($params !~ 'Container=') {
  $params .= '&' . $param_np;
}

my $xsl = "";
if (0) {
  $xsl = shift(@ARGV);
  $xsl =~ tr/[a-z0-9]//cd;
}

my $transform1_cmd = "xsltproc $DOC_DIR/$xsl/$xsl.xsl -";
my $transform2_cmd = "saxonb-xslt -xsl:$DOC_DIR/$xsl/$xsl.xsl -s:-";

my $url = "https://$IP$np_xml_path$params";

my $fetch_cmd = "curl -s -u \"tivo:$MAK\" -b'sid=abc' -k --digest ";
my $post_cmd = '';

foreach my $f (`ls $BIN_DIR/filters`) {
  chomp $f;
  $post_cmd .= " | $BIN_DIR/filters/$f";
}

if ($xsl) {
  $post_cmd .= " | $transform2_cmd";
}

warn "$fetch_cmd '$url' $post_cmd\n";
my $xml = `$fetch_cmd '$url' $post_cmd`;
print $xml;

if (0) {
  print "$fetch_cmd '$url' $post_cmd";
}
