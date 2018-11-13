#!/usr/bin/perl -w
use warnings; 
use strict; 

# Given the URL of a web page fetches it by running wget and prints the HTML tags it uses.
# The tag should be converted to lower case and printed in sorted order with a count of how often each is used.

# Don't count closing tags.

if (@ARGV != 1) { 
	die "usage: $0 <url>\n";
}

my $url = shift @ARGV;

open my $FH, "-|", "wget -q -O- $url", or die "Could not scrape $url\n"; 
my @contents = <$FH>;

close $FH;

print @contents;

my @tags; # an array of tags, with 1 opening tag each