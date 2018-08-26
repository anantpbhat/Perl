#!/bin/perl -w
#########################################################################
#                                                                       #
# Look for orphan virtual disks in replicated, newly imported Storage   #
# Domains and try to register them.                                     #
# Author: Anant Bhat.                                                   #
#                                                                       #
# Please capture all version changes below                              #
# Version 1.0 - Initial creation, Anant, 10/05/2015                     #
#########################################################################

use strict;

my ($stgref, $stgnm, $vdskref, $vdsk, $curlref, $chk);
my $RHEVM = "rhevm.mg.ny.frb.org";
my $DOM = "rb.win.frb.org";
my $DOM1 = "RB_Domain";

print "Your RHEVM Username: ";
chomp ( my $user = <STDIN> );
print "Password: ";
system "/bin/stty", "-echo";
chomp ( my $pwd = <STDIN> );
system "/bin/stty", "echo";
print "\n", "Which Storage Domain to work on? ";
chomp ( my $stgdm = <STDIN> );

if ( $stgdm =~ m/B[37]((DEV)|(QA)|(PROD))[1-9]_.*/ ) {
        print $stgdm, "\n";
} else {
        die "Invalid Storage Domain Name, Exiting...\n";
}

open STGDM, "curl -X GET -v -k -u \'$user\@$DOM\@$DOM1:$pwd\' -H \"Accept: application/xml\" \"https://$RHEVM/ovirt-engine/api/storagedomains\" 2>/dev/null|";
print "Working on it, LDAP authentication could take up to a minute...", "\n";

while (<STGDM>) {
        /HTTP Status 401 / and die "Incorrect Username or Password, Exiting...\n";
        ( /ExportDomain/ or /ISODomain/ ) && next;
        if ( m|<name>(.*)</name>| ) {
                if ( $stgnm && (! exists $stgref->{$stgnm})) {
                        print "Storage Domain ID Missing!!!", "\n";
                        $stgref->{$stgnm} = "missing";
                }
                $stgnm = $1;
                print "$stgnm:", "\t";
        }
        if ( m|<storage_domain_id>(.*)</storage_domain_id>| ) {
                $stgref->{$stgnm} = $1;
                print "$stgref->{$stgnm}", "\n";
        }
}

print "\n", "Your Storage Domain ID: ", $stgref->{$stgdm}, "\n";

if ( $stgref->{$stgdm} eq "missing" ) {
        print "Storage Domain ID is Missing!!!", "\n";
        print "Please Input Storage Domain ID: ";
        chomp ( $stgref->{$stgdm} = <STDIN> );
}

close STGDM;

open URVDISKS, "curl -X GET -v -k -u \'$user\@$DOM\@$DOM1:$pwd\' -H \"Accept: application/xml\" \"https://$RHEVM/ovirt-engine/api/storagedomains/$stgref->{$stgdm}/disks\;unregistered\" 2>/dev/null|";

while (<URVDISKS>) {
        $vdsk = "$2" if ( m%<disk href\=\"(.*)\" id\=\"(.*)\">% );
        $vdskref->{$vdsk} = $1 if ( m%<alias>(.*)</alias>% );
}
close URVDISKS;

die "Storage Domain $stgdm has no Unregistered vdisks. Exiting...", "\n" if (! $vdsk);

foreach $vdsk (sort keys %{ $vdskref }) {
        $curlref->{$vdsk} = "/usr/share/centrifydc/bin/curl -v -k -u \'$user\@$DOM\@$DOM1:$pwd\' -H \"Content-type: application/xml\" -d \'\<disk id=\"$vdsk\"\>\<alias\>$vdskref->{$vdsk}\</alias\> \</disk\>\' \"https://$RHEVM/ovirt-engine/api/storagedomains/$stgref->{$stgdm}/disks\;unregistered\" \>/dev/null 2\>\&1";
        print $vdsk, "\t", $vdskref->{$vdsk}, "\n";
}

print "\n", "Please inspect above Virtual Disk aliases and their respective IDs...", "\n", "OK to Register these? (Y/N): ";
chomp ( my $resp = <STDIN> );

if ( $resp =~ /(Y)|(YES)/i ) {
        foreach $vdsk (sort keys %{ $vdskref }) {
                print "Registering ", $vdskref->{$vdsk}, " to \t", $vdsk, "\n";
                !system "$curlref->{$vdsk}" or  $chk = 1;
                print "DONE...", "\n\n";
        }
} else {
        print "No change made. Quiting...", "\n";
        exit 1;
}

if ( $chk ) {
        print "One or all vdisks had problem, please verify", "\n";
        exit 1;
} else {
        print "ALL VDISKS Registered.", "\n";
        exit 0;
}
