#!/usr/bin/perl -w

use strict;

if (scalar @ARGV != 1) { print "Atleast one arg is required.\n" };
my $rmlink = $ARGV[0];

open INFILE, "<", "quickfile";
open OUT, ">>", "quickout.html";

sub rmline {
	foreach ( <INFILE> ) {
		next if (/$rmlink/gi);
		chomp (my $line = $_);
		print OUT "$line", "\n";
	}
	return 0;
}

rmline;
close INFILE;
close OUT;
