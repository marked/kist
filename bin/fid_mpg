#!/usr/bin/perl
use warnings;
use strict;

my $ROOT;
BEGIN {
  $0 =~ m%^(.*)/%;
  $ROOT = $1;
}
use lib $ROOT;

use Common;
use Conf;

if (@ARGV < 2) {
  die "Usage: $0 <HostDVR> <fileID> [offset]\n";
}

my $IP = "";
if (@ARGV >= 1) {
  $IP = shift(@ARGV);
}

my $fid = "";
if (@ARGV >= 1 ) {
  $fid = shift(@ARGV);
  $fid =~ tr/[0-9]//cd;
} 

my $offset_arg = "";
if (@ARGV >= 1) {
  $offset_arg = shift(@ARGV);
  $offset_arg =~ tr/[0-9]//cd;
  $offset_arg = "-C $offset_arg";
}

my $param_PS = "Format=video/x-tivo-mpeg";
my $param_TS = "Format=video/x-tivo-mpeg-ts";

my $fetch_cmd = "curl -u tivo:$MAK --digest -b'sid=$$' $offset_arg -v 'http://$IP$vid_path$fid&$param_PS' 2> $LOG_DIR/curl.log";
my $decode_cmd = "";
if (1) {
  $decode_cmd = "| tivodecode -m $MAK -o - - 2> $LOG_DIR/td.log";
}

warn("$fetch_cmd $decode_cmd\n");
system("$fetch_cmd $decode_cmd");
