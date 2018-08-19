#!/usr/bin/perl -w

use strict;

if (@ARGV) { die "No arguments expected, Usage: $0\n"; }

my $BadData = "No \"Space\" \"TAB\" or alphabets allowed in Data";
my $pformat1 = "%-12s %-10s %-12s %-12s";
my $pformat2 = "%-3s %-2d %-5d %-10s %-12.3f %-12.3f";
my @DT = split (/\s+/, localtime());

my $regref = [ "Regular", "0" ];
my $premref = [ "Premium", "0" ];

my $askdata = sub {
	my $IN = shift;
	print "Sale for $IN GAS (Gallons): ";
	return 1;
};

sub getdata {
	chomp (my $IN = <STDIN>);
	die "Quiting" if $IN =~ /(^[qQ]$)|(^[qQ]uit$)/;
	my @subary = split(/\s+/, "$IN");
	return 0 if (scalar @subary > 1);
	return $subary[0] if $subary[0] =~ /^(\d+)[\.]?(\d+)$/;
	return 0;
}

my $checkdata = sub {
	my $IN = shift;
	if ($IN == 0) {
		print "$BadData", "\n";
		return 0
	} else { return 1; }
};
	
foreach my $gas ( $regref, $premref ) {
	while (1) {
		$askdata->("$gas->[0]");
		$gas->[1] = getdata();
		last if $checkdata->("$gas->[1]");
	}
}

printf "$pformat1\n", "DATE", "TIME", "REGULAR", "PREMIUM";
printf "$pformat2\n", $DT[1], $DT[2], $DT[4], $DT[3], $regref->[1], $premref->[1];
