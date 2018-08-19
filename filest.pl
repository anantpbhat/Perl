#!/usr/bin/perl -w

use strict;
use File::stat;

if ( ! @ARGV ) { die "No Directory argument specified"; }

my $DNAME = $ARGV[0];
opendir DIRH, $DNAME or die "Not a Valid Directory: $!";

foreach my $NM ( readdir DIRH ) {
	my $sref = stat("$DNAME/$NM");
	printf "FILENAME: %-32s %04o %-8d %s\n", $NM, $sref->mode & 07777, $sref->size, scalar localtime $sref->mtime;
}
