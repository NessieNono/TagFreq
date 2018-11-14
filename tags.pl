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

# count the frequency of each tag 
my %hash; 

# count the tags
my $size = 0; 
foreach my $tag (@tags) { 
	$hash{$tag}++;
	$size++; 
}
my $types = keys %hash;
print "Reading $file\n";
print "$types types of tags found\n";
print "$size total tags found.\n";
print "--------------------------\n";
print "       tag:  freq  percent\n";
print "--------------------------\n";
foreach my $key (sort {$hash{$b} <=> $hash{$a}} keys %hash) { 
	# a percent sign is escaped by doubling it 
	my $ratio = $hash{$key} * 100 / $size;
	my $bracketed_key = "<".$key.">";
	printf "%10s: %5d %5.1f%%\n", $bracketed_key, $hash{$key}, $ratio;
}