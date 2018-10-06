#!/usr/bin/perl -w

use strict;

# Complete the activityNotifications function below.
sub activityNotifications {
    my $aref = shift;
    my $tds = shift;
    my @ary = @$aref;
    my $ntf = 0;
    
    foreach my $i (0..($#ary - $tds + 1)) {
        my $sm = $ary[$i];
        my $lg = $ary[$i];
        $sm = grep {
            if ($sm > $_) { 
                $sm = $_; $sm;
            } else { $sm; }
        } ($ary[$i]..$ary[$i + $tds - 1]);
        $lg = grep {
            if ($lg < $_) {
                $lg = $_; $lg;
            } else { $lg; }    
        } ($ary[$i]..$ary[$i + $tds - 1]);
        my $mdn = $lg + $sm;
        last if ( $i == ($#ary - $tds + 1) );
        ++$ntf if ( $mdn <= $ary[$i + $tds] );
    }
return $ntf;
}
    

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $nd = <>;
$nd =~ s/\s+$//;
my @nd = split /\s+/, $nd;

my $n = $nd[0];
$n =~ s/\s+$//;

my $d = $nd[1];
$d =~ s/\s+$//;

my $expenditure = <>;
$expenditure =~ s/\s+$//;
my @expenditure = split /\s+/, $expenditure;

my $result = activityNotifications \@expenditure, $d;

print $fptr "$result\n";

close $fptr;
