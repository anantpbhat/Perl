#!/usr/bin/perl

use strict;
use warnings;

my @words;
my $line = 0;

if ( ! defined($ARGV[0]) ) { die "No arguments specified... "; }

open (FILE1, "<$ARGV[0]"); 

while (<FILE1>) {
	chomp;
	@words = split;
	print "Line $. has:\t", $#words + 1, " words\n";
	++$line;
}

print "Total number of lines in the file:\t", "$line\n";
close (FILE1);
