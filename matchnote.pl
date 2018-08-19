#!/usr/bin/perl -wl

use strict;

my ($hsh, $NO);
chomp (my $i = <STDIN>);
my @in = split /\s+/, "$i";
chomp (my $mgn = <STDIN>);
my @mn = split /\s+/, "$mgn";
chomp (my $not = <STDIN>);
my @nt = split /\s+/, "$not";

foreach my $n ( @nt ) {
    my $m = 0;
    foreach ( @mn ) {
        if ( /^${n}$/ ) {
            $hsh->{$n} = $mn[$m];
            $mn[$m] = "0";
            last;
        }
        ++$m;
    }
}
foreach my $k ( @nt ) {
    $NO = 1 if (! defined $hsh->{$k});
    $hsh->{$k} = undef;
}
if ( $NO ) {
    print "NO";
} else {
    print "YES";
}
