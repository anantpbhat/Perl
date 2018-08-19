#!/usr/bin/perl -w

use warnings;
use strict;

open SORTFILE, "<$ARGV[0]" or die "No argument supplied: $!";
my @sorted;
my $firstline = <SORTFILE>;

print sort { $b <=> $a } <SORTFILE>;		## Both are same
print reverse sort { $a <=> $b } <SORTFILE>;	## Both are same
close SORTFILE;

