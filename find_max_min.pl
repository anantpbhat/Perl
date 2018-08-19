#!/usr/bin/perl -wl

use warnings;
use strict;

( scalar @ARGV < 2 ) and die "$0:\tNeed minimum 2 arguments";
									
my @minmax = @ARGV;
my @sorted;

@sorted = sort { $a <=> $b } @minmax;

#$, = " ";
print "Max number is:\t $sorted[$#sorted]";
print "Min number is:\t $sorted[0]";
print "Sorted numbers in ascending order:\t @sorted";
