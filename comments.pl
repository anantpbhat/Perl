#!/usr/bin/perl -wl

print "Usage: $0 <filename>" unless (defined "$ARGV[0]");

while (<>) {
	chomp;
	print $& if /\/\/.+$/;
	print "$&" if /\/\*.*\s.*\s.*\*\/$/mg;
}
