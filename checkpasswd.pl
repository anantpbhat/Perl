#!/usr/bin/perl -w

use strict;
use Crypt::PBKDF2;
use v5.10;
 
my $password = "$ARGV[0]";
my $hash = '{X-PBKDF2}HMACSHA2+512:AAAnEA:wbW5m35mXj1aTg==:/VGBxlB3y6jxLRtPue3IpIYrDoa5rAJ8wLvdz/PQVY12YQT7wAH8QH5GM6EveJW7ZqKepmO/TyaASt/VTAb6hA==';
 
my $pbkdf2 = Crypt::PBKDF2->new;
if ($pbkdf2->validate($hash, $password)) {
	say "This was a valid password";
} else {
	say "Wrong password, please try again";
}

