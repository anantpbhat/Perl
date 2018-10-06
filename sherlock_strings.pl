#!/usr/bin/perl -w

use strict;

# Complete the isValid function below.
sub isValid {
    my $str = shift;
    my @astr = split //, $str;
    my (@acnt, @srtcnt, %hsh);
    my $YES = "NO";
    foreach my $s (@astr) {
        my $cnt = grep /^${s}$/, @astr;
        $hsh{$s} = $cnt;
    }
    @srtcnt = sort {$a <=> $b} values %hsh;
    $YES = "YES" if ( $srtcnt[0] == $srtcnt[-1] or ($srtcnt[0] + 1) == $srtcnt[-1] );
    $YES = "NO" if ( $srtcnt[0] != $srtcnt[-2] );
    return $YES;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $s = <>;
chomp($s);
my $result = isValid $s;
print $fptr "$result\n";

close $fptr;
