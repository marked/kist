package Conf;
use strict;
use warnings;

use parent 'Exporter'; # imports and subclasses Exporter

our $IP = "tivo";	# || $ENV{TIVO_IP};
our $MAK= "" 
  || $ENV{TIVO_MAK};
if (defined $MAK && $MAK =~ /^([0-9]+)$/) {
  $MAK =~ $1;
} else {
  die "Invalid MAK\nDefine \$TIVO_MAK or edit Conf.pm\n";
}
our $SID = "kist";
our $DEBUG = "0";

our $ROOT = $INC[0] . "/..";
our $DOC_DIR = "$ROOT/docroot";
our $BIN_DIR = "$ROOT/bin";
our $LOG_DIR = "$ROOT/log";
our $XSL_DIR = "$ROOT/transforms";
our $TMP_DIR = "$ROOT/tmp";

our @EXPORT = qw(
  $IP
  $MAK
  $SID
  $DEBUG
  $ROOT
  $DOC_DIR
  $BIN_DIR
  $LOG_DIR
  $XSL_DIR
  $TMP_DIR
);

