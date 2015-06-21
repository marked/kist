package Conf;
use strict;
use warnings;

use parent 'Exporter'; # imports and subclasses Exporter

our $IP = "tivo";
our $MAK= "";

our $ROOT = $INC[0] . "/..";
our $DOC_DIR = "$ROOT/docroot";
our $BIN_DIR = "$ROOT/bin";
our $LOG_DIR = "$ROOT/log";

our @EXPORT = qw(
  $IP
  $MAK
  $ROOT
  $DOC_DIR
  $BIN_DIR
  $LOG_DIR
  $DN
);

