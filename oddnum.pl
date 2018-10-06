#!/usr/bin/perl -w
#
use strict;

sub getdata {
	print "Enter start number: ";
	my $x = <STDIN>;
	print "Enter end number: ";
	my $y = <STDIN>;
	return $x, $y;
}

my ($l, $r) = getdata();
my @oddnums = grep {$_ % 2 != 0} ($l..$r);
print "@oddnums\n";
