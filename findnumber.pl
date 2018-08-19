#!/usr/bin/perl -wl

use strict;

chomp (my $n = <STDIN>);
my @arr;
my $y;

while ( $n >= "0" ) {
	chomp (my $a = <STDIN>);
	push @arr, $a;
	--$n;
}

my $k = pop @arr;

foreach (@arr) {
	if ( /^${k}$/ )	{
		$y = 1;
		last;
	}
}
if ( $y ) {
	print "YES";
} else {
	print "NO";
}
