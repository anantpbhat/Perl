#!/usr/bin/perl -wl

defined $ARGV &&  chdir "$ARGV[0]";

my $dirname;
my @SIZE;
my @Dir = <*>;
print "@Dir";
chomp (my $DU = `/usr/bin/du`);

foreach $dirname (@Dir) {
	if (-d $dirname) {
		@SIZE = system "/usr/bin/du", "-s", $dirname;
		print @SIZE;
#		print "${dirname}\t", $SIZE[0] / 1024, "M";
	}
}

exit 0;
