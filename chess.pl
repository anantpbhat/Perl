#!/usr/bin/perl -w

use strict;

my @chessboard;
my @back = qw(R N B Q K B N R);

# Assign values to both white and black rows
for (0..7) {
	$chessboard[0]->[$_] = "W" . $back[$_];		#White back row
	$chessboard[1]->[$_] = "WP";			#White pawns
	$chessboard[6]->[$_] = "BP";			#Black pawns
	$chessboard[7]->[$_] = "B" . $back[$_];		#Black back row
}

while (1) {
	# Print out the Chess Board
	for my $i (reverse (0..7)) {
		for my $j (0..7) {
			if (defined $chessboard[$i]->[$j]) {
				print $chessboard[$i]->[$j];	#Print defined black & white rows
			} elsif ( ($i % 2) == ($j % 2) ) {
				print "..";	#Print two dots for every even cells
			} else {
				print "  ";	#Print two spaces for every odd cells
			}
			print " ";		#Print space between cells
		}				#End of Cell
		print "\n";
	}					#End of Row

	PSTART: print "\n Starting Square [x,y]: ";
	my $move = <>;
	last if ($move =~ /[qQ]|Quit|quit/);
	goto PSTART unless ($move =~ /([1-8]),([1-8])/);
	my $startx = $1 - 1;
	my $starty = $2 - 1;
	unless (defined $chessboard[$starty]->[$startx]) {
		print "\nNothing on that square!\n\n";
		goto PSTART;
	}
	PEND: print "\n Ending Square [x,y]: ";
	$move = <>;
	last if ($move =~ /[qQ]|Quit|quit/);
	goto PEND unless ($move =~ /([1-8]),([1-8])/);
	my $endx = $1 - 1;
	my $endy = $2 - 1;
	if (defined $chessboard[$endy]->[$endx]) {
		print "\nCannot move, somethings there!!\n\n";
		goto PEND;
	}
	$chessboard[$endy]->[$endx] = $chessboard[$starty]->[$startx];
	undef $chessboard[$starty]->[$startx];
}
