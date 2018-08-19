#!/usr/bin/perl -w

use strict;

if (scalar @ARGV > 1) { die "Only One wordfile allowed.\nUsage: $0 <wordfile>"; }

my ($cnt, $word, $hwords, @line);		# Notice later that, hwords is a HASH Ref.

# Sub to get input (file/word)
sub getin {
	chomp (my $IN = <STDIN>);
	die "Quiting" if $IN =~ /(^[qQ]$)|(^[qQ]uit$)/;
	return split(/\s+/, "$IN");		# Returns an array
}
	
# MAIN Program Starts Here - Scrape the input file and assign to FH.
if ( ! @ARGV ) {
	print "Path to wordfile please: ";
	my @FILES = getin();
	open FH1, $FILES[0] or die "No such File: $FILES[0]";
} else {
	open FH1, $ARGV[0] or die "No such File: $ARGV[0]";
}

# Task 1 - Run thru the Input File, count lines and check for duplicate words.
$cnt = 0;
while ( <FH1> ) {
	chomp;
	s/(\w+)/\L$1/gi; 	# Converts all alphabets to Lowercase
	++$cnt;			# Count Lines
	my @line = split;
	print "Line ${cnt}: has total ", scalar @line, " words\n";
	foreach $word (@line) {
		unless ( exists $hwords->{$word} ) {
			$hwords->{$word} = [ $word, 0, $cnt ];
		} else {
			++$hwords->{$word}->[1];
			print "I saw a word repeat ", $hwords->{$word}->[1], " time(s)\n";
		}	
	}
}

print "\n", "Total lines in File: ", $cnt, "\n";

# Task 2 - Keep requesting input word from user, display repeat count and line number if exists.
while (1) {
	print "Provide an Input Word or (q|Q) to quit: ";
	my @inword = getin();
	if (scalar @inword > 1) {
		print "You entered two or more words, Invalid input\n"; 
		next;
	}
	$inword[0] =~ s/(\w+)/\L$1/gi;	# Converts all alphabets to Lowercase
	if ( exists $hwords->{$inword[0]} ) {
		print "Word \"$inword[0]\" appears 1st on line ", $hwords->{$inword[0]}->[2], " and is repeated ", $hwords->{$inword[0]}->[1], " more time(s) in this file", "\n\n";
	} else {
		print "No word \"$inword[0]\" exists in this file, try again\n";
	}
}

close FH1;
