#!/usr/bin/perl -wl

use strict;

# Complete the freqQuery function below.
sub freqQuery {
	my $ref = shift;
	my @fary;
	foreach my $i (@$ref) {
		push @fary, $i->[1] if $i->[0] == 1;
		@fary = grep $_ != $i->[1], @fary if ($i->[0] == 2);
		if ($i->[0] == 3) {
			my $YES = "NO";
			foreach my $n (@fary) {
				my $rpt = grep /^$n$/, @fary;
				if ($rpt >= $i->[1]) {
					$YES = "YES";
					last;
				}
			}
			print $YES;
		}
	}

}

my $aa = [1, 3];
my $ab = [1, 6];
my $ac = [3, 2];
my $ad = [1, 3];
my $ae = [2, 6];
my $af = [3, 2];
my $ag = [1, 6];
my $ah = [2, 3];
my $ai = [3, 2];
my $aref = [$aa, $ab, $ac, $ad, $ae, $af, $ag, $ah, $ai];
	
freqQuery $aref;

###open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

#my $q = ltrim(rtrim(my $q_temp = <STDIN>));
#my @queries = ();

#for (1..$q) {
#    my $queries_item = rtrim(my $queries_item_temp = <STDIN>);
#    my @queries_item = split /\s+/, $queries_item;
#    push @queries, \@queries_item;
#}

#my @ans = freqQuery \@queries;
#print $fptr join "\n", @ans;
#print $fptr "\n";

#close $fptr;

#sub ltrim {
#    my $str = shift;
#    $str =~ s/^\s+//;
#    return $str;
#}

#sub rtrim {
#    my $str = shift;
#    $str =~ s/\s+$//;
#    return $str;
#}
