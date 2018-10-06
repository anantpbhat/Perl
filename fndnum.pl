#!/usr/bin/perl -w

use strict;

sub getary {
	my $i = shift;
	my $x = 1;
	my @arx;
	until ( $x > $i ) {
		print "Enter array item $x: ";
		my $a = <STDIN>;
		push @arx, $a;
		++$x;
	}
	return \@arx;
}
sub findnum {
	my $ref = shift;
	my $x = shift;
	my $ans = "NO";
	$ans = "YES" if (grep $x == $_, @$ref); 
	return $ans;
}

print "Total number of items in array: ";
my $N = <STDIN>;
my $aref = getary($N);
print "Enter a number to find: ";
my $k = <STDIN>;
my $out = findnum ($aref, $k);

print "$out\n";
