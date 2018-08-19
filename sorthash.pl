#!/usr/bin/perl -w

use strict;

my $n = 1;
my %cndt;
my $cndt = \%cndt;

sub getnm {
	chomp (my $IN = <STDIN>);	
	return $IN = "quit" if $IN =~ /(^q$)|(^quit$)/i;
	return split (/\s+/, "$IN") if $IN =~ /^[[:alpha:]]+\s*[[:alpha:]]*$/;
	print "Alphabets only please...\n";
	return $IN = "";
}

sub getvt {
	chomp (my $IN = <STDIN>);
	return $IN = "" if $IN =~ /\D+/;
	return $IN;
}

if ( defined ($ARGV[0]) ) {
	open (FILE, "<$ARGV[0]") or die "File $ARGV[0] not a valid file \n";
	while ( <FILE> ) {
		next unless ( m/:/ );
		chomp;
		my @DATA = split /:/;
		my @NM = split (/\s+/, "$DATA[0]");
		my $VT = $DATA[1];
		$cndt->{"$NM[0]_$NM[1]"} = $VT;
	} 
} else {
	while (1) {
		print "Candidate $n: ";
		my @NM = getnm();
		last if $NM[0] eq "quit";
		next if $NM[0] eq "";
		LBL1: print "Votes for Candidate $n: ";
		my $VT = getvt();
		goto LBL1 if $VT eq "";
		$cndt->{"$NM[0]_$NM[1]"} = $VT;
		++$n;
	}
}

my @sorted = sort { $cndt->{$b} <=> $cndt->{$a} or $a cmp $b } keys %cndt;

print "\n", "Winner Candidates in descending order:-", "\n";
foreach my $k ( @sorted ) {
	print "$k", "\t", "-> ", $cndt->{$k}, "\n";
}
