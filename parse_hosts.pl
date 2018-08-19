#!/usr/bin/perl -wl

if ( scalar @ARGV != 1 ) { die "USAGE: $0 <host|ip>"; }

my $IP;
my $HOST;
my @line;
my $request = $ARGV[0];
open INFILE, "/etc/hosts";

sub host_or_ip {
	$_[0] =~ /^[a-z][a-z]+/i and $HOST = $_[0] or $IP = $_[0];
}

MAIN:	foreach ( <INFILE> ) {
		@line = split;
		if ( /\b$request\s+/ ) {
			&host_or_ip($request);
			last MAIN;
		}
	}

if ($IP) { print "IP <$request> resolves to <$line[1]>"; exit 0; };
if ($HOST) { print "Hostname <$request> resolves to <$line[0]>"; exit 0; };
print "Input <$request> doesn't resolve";

exit 1;
