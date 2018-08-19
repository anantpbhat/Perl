#!/usr/bin/perl -w
#################################################
#						#
# Author: Anant Bhat				#
# Please record all version changes below	#
# v1.0: Initial version 			#
#						#
#################################################

use strict;
use feature "switch";
use v5.10;

$SIG{INT} = \&sig_handle;
$SIG{TERM} = \&sig_handle;

my $DIR = "/home/abhat/Documents/HTMLs";
my $File = "HomePage.html";
my $SECFile = "sections.lst";
my $DT = `date '+%Y%m%d:%H%M'`;
system "cp", "$DIR/$File", "$DIR/bkup/${File}_$DT";
system "cp", "$DIR/$SECFile", "$DIR/bkup/${SECFile}_$DT";
open INFILE, "<", "$DIR/$File";
open SECIN, "<", "$DIR/$SECFile";
open OUTFILE, ">>", "$DIR/${File}_New";
open SECOUT, ">>", "$DIR/${SECFile}_New";
my ($input, $retval, $secstr1, $secstr2);
my $rnsec = 0;
my @secary;

sub sig_handle {
	unlink "$DIR/${File}_New";
	unlink "$DIR/${SECFile}_New";
	die "Quiting..., caught signal $!";
}

sub printmenu {
	print "\t1) addlink\n";
	print "\t2) removelink\n";
	print "\t3) addsection\n";
	print "\t4) renamesection\n";
	print "\t5) changemotto\n";
	print "\t6) changefooter\n";
	print "\t7) quit\n";
	print "\tChoose One option: ";
	chomp($input = <STDIN>);
}

sub addlink {
	print "\n", "Under which Section ($secstr1): ";
	chomp (my $section = <STDIN>);
	return "GO BACK" if ($section =~ /^b$|^B$|^back$/);
	unless ( $section =~ /$secstr2/i ) {
		return "Wrong Section Name, has to be exact match from above.";
	}	
	print "\n", "Unique link name: ";
	chomp (my $linkname = <STDIN>);
	return "GO BACK" if ($linkname =~ /^b$|^B$|^back$/);
	my $joinedfile1 = join '', <INFILE>;
	return "Link Name not unique" if (($joinedfile1 =~ />($linkname)</i) || ($linkname =~ /^q$|^Q$|^quit$/ ));
	print "Type in the URL (www.example.com): ";
	chomp (my $url = <STDIN>);
	return "Wrong URL" if ($url =~ /^q$|^Q$|^quit$/);
	return "GO BACK" if ($url =~ /^b$|^B$|^back$/);
	my $str1 = "<a href=\"https://$url\" target=\"_blank\">$linkname</a>";
	$joinedfile1 =~ /(<h2>$section Sites)(.*(\n|\r))+?(\s+<\/section>)/;
	my $matched = $&;
	my $beforematch = $`;
	my $aftermatch = $';
	$matched =~ s/<\/section>/\t<li>$str1<\/li>\n\t\t<\/section>/;
	print OUTFILE "$beforematch";
	print OUTFILE "$matched";
	print OUTFILE "$aftermatch";
	return 0;
}

sub addsection {
	print "\n", "Unique Section Name to add (ex. Search, Banking..): ";
	chomp (my $newsect = <STDIN>);
	return "GO BACK" if ($newsect =~ /^b$|^B$|^back$/);
	return "Section Name \"$newsect\" already exists or wrong," if ($newsect =~ /$secstr2|^[a-z]|^Q$|^Quit$/);
	foreach ( <INFILE> ) {
		chomp (my $ln = $_);
		$ln =~ s/\t<\/main>/\t\t<section>\n\t\t\t<header>\n\t\t\t\t<h2>$newsect Sites<\/h2>\n\t\t\t<\/header>\n\t\t<\/section>\n\t<\/main>/;
		print OUTFILE "$ln", "\n";
	}
	return 0;
}

sub renamesection {
	print "\n", "Section to rename ($secstr1): ";
	chomp (my $renamesec = <STDIN>);
	return "GO BACK" if ($renamesec =~ /^b$|^B$|^back$/);
	unless ( $renamesec =~ /$secstr2/i ) { return "Wrong Section Name, has to be exact match from above."; }
	print "New Section Name: ";
	chomp (my $newsec = <STDIN>);
	return "GO BACK" if ($newsec =~ /^b$|^B$|^back$/);
	return "Wrong Section Name, should start with uppercase letter," unless ( $newsec =~ /^[A-Z][a-z]+$/ );
	foreach (<INFILE>) {
		chomp (my $secln = $_);
		$secln =~ s/<h2>$renamesec Sites</<h2>$newsec Sites</;
		print OUTFILE "$secln", "\n";
	}
	foreach (@secary) {
		s/$renamesec/$newsec/;
		print SECOUT "$_", "\n";
	}
	$rnsec = 1;
	return 0;
}

sub changemotto {
	print "\n", "Type your new Motto here(Max. ten words): ";
	chomp (my $newmot = <STDIN>);
	my @motary = split / /, $newmot;
	return "Motto too long" if ( scalar @motary > 10 );
	my $joinedfile2 = join '', <INFILE>;
	$joinedfile2 =~ /<h1>\w+.*(\n|\r)\s+<p>.+<\/p>/;
	my $matched2 = $&;
	my $beforematch2 = $`;
	my $aftermatch2 = $';
	$matched2 =~ s/<p>".+"<\/p>/<p>"$newmot"<\/p>/;
	print OUTFILE "$beforematch2";
	print OUTFILE "$matched2";
	print OUTFILE "$aftermatch2";
	return 0;	
}

sub changefooter {
	print "\n", "Type your new Footer here(Max. ten words): ";
	chomp (my $newfot = <STDIN>);
	my @fotary = split / /, $newfot;
	return "Footer too long" if ( scalar @fotary > 10 );
	my $joinedfile3 = join '', <INFILE>;
	$joinedfile3 =~ /<footer>(\n|\r)\s+<p>\w+.+<\/p>(\n|\r)\s+<\/footer>/;
	my $matched3 = $&;
	my $beforematch3 = $`;
	my $aftermatch3 = $';
	$matched3 =~ s/<p>.+<\/p>/<p>$newfot<\/p>/;
	print OUTFILE "$beforematch3";
	print OUTFILE "$matched3";
	print OUTFILE "$aftermatch3";
	return 0;	
}

sub removelink {
	print "\n", "Link Name to remove: ";
	chomp (my $rmlink = <STDIN>);
	return "Bad Link Name" if ($rmlink =~ /^q$|^Q$|^quit$/);
	return "GO BACK" if ($rmlink =~ /^b$|^B$|^back$/);
	my $linkfnd;
	foreach ( <INFILE> ) {
		chomp (my $line = $_);
		if ($line =~ />($rmlink)</i) {
			$linkfnd = 1;
			next;
		}
		print OUTFILE "$line\n";
	}
	(! $linkfnd) && return "Link Name \"$rmlink\" not found.";
	return 0;
}

sub replacefile {
	chdir $DIR;
	if ( -f "bkup/${File}_$DT" ) {
		unlink $File;
		rename "${File}_New", "$File";
		if ( $rnsec eq 1 ) {
			unlink $SECFile;
			rename "${SECFile}_New", "$SECFile";
		} else {
			unlink "${SECFile}_New";
		}
	}
	return 0;
}

# Main program starts here
foreach (<SECIN>) {
	chomp;
	push @secary, $_;
}
$secstr1 = join ", ", @secary;
$secstr2 = join "|", @secary;

JUMPHERE: &printmenu;
given ( $input ) {
	when (/^(addlink(\s)*)$|^1$/)		{ $retval = &addlink }
	when (/^(removelink(\s)*)$|^2$/)	{ $retval = &removelink }
	when (/^(addsection(\s)*)$|^3$/)	{ $retval = &addsection }
	when (/^(renamesection(\s)*)$|^4$/)	{ $retval = &renamesection }
	when (/^(changemotto(\s)*)$|^5$/)	{ $retval = &changemotto }
	when (/^(changefooter(\s)*)$|^6$/)	{ $retval = &changefooter }
	when (/^q$|^Q$|^quit$|^7$/)		{ $retval = "EXIT request," }
	default 				{ $retval = "Wrong Input," }
}

if ( $retval =~ /GO\sBACK/ ) {
	unlink "$DIR/${File}_New";
	unlink "$DIR/${SECFile}_New";
	goto JUMPHERE
}

if ( $retval ne 0 ) {
	unlink "$DIR/${File}_New";
	unlink "$DIR/${SECFile}_New";
	print "$retval ", "Quiting...\n";
	exit 1;
}

close INFILE;
close OUTFILE;
close SECIN;
close SECOUT;
&replacefile;
exit 0;
