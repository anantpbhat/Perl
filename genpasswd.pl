#!/usr/bin/perl -w

use strict;
use Crypt::PBKDF2;
use v5.10;
 
my $pbkdf2 = Crypt::PBKDF2->new(
	hash_class => 'HMACSHA2',
	hash_args => {
		sha_size => 512,
	},
    iterations => 10000,
    salt_len => 10,
);

say "$ARGV[0]";
###my $password = "Change1tN0w";
my $password = "$ARGV[0]";
my $hash = $pbkdf2->generate($password);
say "Crypted Key: ", $hash;
