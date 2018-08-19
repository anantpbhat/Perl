#!/usr/bin/perl -wl

use lib "lib";
use Date_Time;
use strict;

my ($S, $CNT);
my $pmemh = "%-12s %-12s %-12s %-12s %-12s";
my $pmem = "%-12s %-12s %-12s %-12s %-12s";
my $pswph = "%-12s %-12s %-12s";
my $pswp = "%-12s %-12s %-12s";

(defined $ARGV[0]) ? ($S = "$ARGV[0]") : ($S = "3");
(defined $ARGV[1]) ? ($CNT = "$ARGV[1]") : ($CNT = "5");
die "Only Integer arguments please: $!" unless (($S =~ /\d+/) and ($CNT =~ /\d+/));

sub getmem {
	my (@mem, @swp);
	open MEM, "/usr/bin/free -h|" or die "Free command not available: $!";
	while ( <MEM> ) {
		next if /total|used/;
		@mem = split /\s+/ if /^Mem:/;
		@swp = split /\s+/ if /^Swap:/;
	}
	close MEM;
	return (\@mem, \@swp);
}

while ($CNT != 0) {
	my $dt = Date_Time->new;
	print "Date: ", $dt->getdatetime->{year}, "-", $dt->getdatetime->{mon}, "-", $dt->getdatetime->{mday},  "\t", "Time: ",  $dt->getdatetime->{time};
	my ($memref, $swpref) = getmem();
	printf "${pmemh}\n", "Total Mem", "Used Mem", "Free Mem", "Cache/Buff", "Actual Free";
	printf "${pmem}\n", $memref->[1], $memref->[2], $memref->[3], $memref->[5], $memref->[6];
	printf "${pswph}\n", "Total Swap", "Used Swap", "Free Swap";
	printf "${pswp}\n\n", $swpref->[1], $swpref->[2], $swpref->[3];
	--$CNT;
	system "sleep", "$S" if ($CNT != 0);
}
