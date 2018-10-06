#!/usr/bin/perl

use strict;
use warnings;

# Complete the twoStrings function below.
sub twoStrings {
    my $str1 = shift;
    my $str2 = shift;
    my $Y = 0;
    foreach (split //, $str1) {
        if ($str2 =~ /$_/) {
            $Y = 1;
            last;
        }
    }
    print "YES" if ($Y == 1);
    print "NO" if ($Y == 0);
    return 1;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $q = <>;
$q =~ s/\s+$//;

for (my $q_itr = 0; $q_itr < $q; $q_itr++) {
    my $s1 = <>;
    chomp($s1);

    my $s2 = <>;
    chomp($s2);

    my $result = twoStrings $s1, $s2;

    print $fptr "$result\n";
}

close $fptr;
