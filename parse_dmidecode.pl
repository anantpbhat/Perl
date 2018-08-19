#!/usr/bin/perl -w

use strict;

open (DMIFILE, "/usr/sbin/dmidecode|") or die "ERROR: $!";

while (<DMIFILE>) {
	print "$.:\t", "$_";
}

close (DMIFILE);
