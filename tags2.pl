#!/usr/bin/perl -w
use warnings; 

# Given the URL of a web page fetches it by running wget and prints the HTML tags it uses.
# The tag should be converted to lower case and printed in sorted order with a count of how often each is used.

# Don't count closing tags.

if (@ARGV != 2) { 
	die "usage: $0 <-l/-w> <url>\n";
}

my $flag = shift @ARGV; 
my $file = shift @ARGV;

if ($flag eq "-l") { 
	open $FH, "<", "$file" or die "Could not open file $file\n";
} elsif ($flag eq "-w") {
	open $FH, "-|", "wget -q -O- $file", or die "Could not scrape $file\n"; 
} else { 
	die "invalid flag.\n";
}

my $content = join("", <$FH>); # entire content is read into a string
close $FH;

# clean the concent; 
$content =~ tr/A-Z/a-z/; # to lowercase
$content =~ s/<!--.*-->//g; # remove contents

# collect all the different tags
my @tags = $content =~ /<\s*(\w+)/g;

print "Here are all the tags weve collected:\n"; 
foreach my $tag (@tags) { 
	print "$tag\n";
}




