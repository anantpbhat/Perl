#!/usr/bin/perl -wl

use strict;

my ($hsh, $YES);
chomp (my $i = <STDIN>);
my @in = split /\s+/, "$i";
chomp (my $mgn = <STDIN>);
my @mn = split /\s+/, "$mgn";
chomp (my $not = <STDIN>);
my @nt = split /\s+/, "$not";

foreach my $n ( @nt ) {
    my $m = 0;
    $YES = "No";
    foreach ( @mn ) {
        if ( /^${n}$/ ) {
	    my $i = 0;
	    while ( defined $hsh->{$n}->[$i] ) {
		++$i;
	    }
            $hsh->{$n}->[$i] = $mn[$m];
            $mn[$m] = "0";
	    $YES = "Yes";
            last;
        }
        ++$m;
    }
    last if $YES eq "No";
}

print $YES;

while (my ($ky, $vl) = each %$hsh) {
	foreach my $i (@$vl) {
	    print "$ky => $i";
	}
}
