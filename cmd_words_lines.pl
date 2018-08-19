#!/usr/bin/perl

use strict;
use warnings;

my @words;
my $line = 0;

open (FILE1, "@ARGV|") or die "No Arguments specified.";

while (<FILE1>) {
	chomp;
	@words = split;
	print "Line $. has:\t", $#words + 1, " words\n";
	++$line;
}

print "Total number of lines in this CMD:\t", "$line\n";
close (FILE1);
