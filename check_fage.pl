#!/usr/bin/perl -wl

if (scalar @ARGV != 1)  { die "$0: Provide only one dirname to process"; }
my $mydir = $ARGV[0];

opendir DH, $mydir or die "Dir $ARGV[0] doesn't exist";
chdir $mydir;
###my @cdirfiles = <*>;

foreach (readdir DH) {
	next if $_ eq "." or $_ eq "..";
	my $fage = -M; 
	my $ForD = "file";
	$ForD = "dir" if -d _ ;
	if ( $fage < 1 ) {
		print "$_ $ForD is:\t", "A New $ForD.";
	} else {
		printf "$_ $ForD is:%20d days old.\n", $fage;
	}
}
chdir;
closedir DH;
