#!/usr/bin/perl -w

while (1) {
	print "Type in some alphabets please: ";
	chomp (my $IN = <STDIN>);
	die "Quiting..." if $IN =~ /(^q$)|(^quit$)/i;
	next if $IN =~ /^[[:alpha:]]+\s*[[:alpha:]]*$/;
	print "I saw a non alphabet character!", "\n";
}


