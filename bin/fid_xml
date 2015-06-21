#!/usr/bin/perl
use warnings;
use strict;

my $ROOT;
BEGIN {
  $0 =~ m%^(.*)/%;
  $ROOT = $1;
}
use lib $ROOT;
#warn $ROOT;
#warn "@INC";

use Common;
use Conf;

my $fid = "";
if (@ARGV == 2) {
  $fid = pop(@ARGV);
  $fid =~ tr/[0-9]//cd;
} else {
  die "Usage: $0 <HostDVR> <fileID>\n";
}

my $IP = "";
if (@ARGV == 1) {
  $IP = shift(@ARGV);
}


my $fetch_cmd = "curl -u tivo:$MAK -k --digest -b'sid=abc' 'https://$IP$detail_xml_path$fid'";
my $post_cmd = "$BIN_DIR/filters/pretty";

#warn "$fetch_cmd  | $post_cmd";
my $xml = `$fetch_cmd  | $post_cmd`;
print $xml;
