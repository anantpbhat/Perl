#!/usr/bin/perl -w

use lib "lib";
use Date_Time;
use strict;

my $dt = Date_Time->new;

print "Date is " . $dt->getdatetime->{year} . "-" . $dt->getdatetime->{mon} . "-" . $dt->getdatetime->{mday} . " and Time is " . $dt->getdatetime->{time} . "\n";
