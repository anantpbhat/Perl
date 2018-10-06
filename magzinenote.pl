#!/usr/bin/perl -wl

use strict;

# Complete the checkMagazine function below.
sub checkMagazine {
    my $amagr = shift;
    my $anotr = shift;
    my $Y;
    foreach my $not (@$anotr) {
        $Y = "No";
	my $i = 0;
        foreach my $mg (@$amagr) {
            if ($not eq $mg) {
                $amagr->[$i] = 0;
                $Y = "Yes";
                last;
            }
	    ++$i;
        }
        last if $Y eq "No";
    }
print "$Y";
}

chomp( my $i = <STDIN>);
my @in = split /\s+/, $i;
chomp( my $mn = <STDIN>);
my @mag = split /\s+/, $mn;
chomp( my $nt = <STDIN>);
my @note = split /\s+/, $nt;

checkMagazine \@mag, \@note;
