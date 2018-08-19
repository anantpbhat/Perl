#!/usr/bin/perl -wl

open DFOUT, "/bin/df -t ext4 -t ext3 -k|";

my $Total = 0;
my $Used = 0;
my $Free = 0;

foreach (<DFOUT>) {
	chomp;
	next if(/^Filesystem/);
	@LINE = split;
	$Total = $Total + $LINE[1];
	$Used = $Used + $LINE[2];
	$Free = $Free + $LINE[3];
}

printf "Total Storage:\t%dG \n", $Total / (1024 * 1024);
printf "Used Storage:\t%dG \n", $Used / (1024 * 1024);
printf "Free Storage:\t%dG \n", $Free / (1024 * 1024);

close DFOUT;
