#!/usr/bin/perl -w
#
use strict;

my $ary = [ 25, 35, 45, 15, 5, 55 ];

foreach ( reverse @$ary ) {
	print "$_ "; 
}
print "\n";
