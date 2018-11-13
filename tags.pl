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
my @contents;
open my $FH, "-|", "wget -q -O- $url", or die "Could not scrape $url\n"; 
# my @contents = <$FH>;
while (my $line = <$FH>) { 
	$line =~ s/<!--.*?-->//g; # remove comments
	if ($line =~ m/\S/) { # only save non-empty lines
		$line = lc $line; # all to lowercase
		$line =~ s/^\s+//; # delete leading spaces
		push @contents, $line;
	}
}
close $FH;

my @tags; # an array of tags, with 1 opening tag each
foreach my $line (@contents) { 
	# save the line into my array of tags if: 
	# non greedy match of < something > 
	my @tags_in_line = grep(/<.*?>/, $line);
	print "these are my tags in line: @tags_in_line\n";
	push @tags, @tags_in_line;
}

print @tags;
# at this stage, the tags may still be of the form: 
# word < div id=""> word
# lets clean the filth 

# my @clean_tags; 
# foreach my $line (@tags) { 
# 	print "this is a line containing a single tag: $line\n";
# }


# # now only save all the lines which have beginning tags
# my @beginning_tags; 
# foreach my $line (@tags) { 
# 	if ($line =~ m/<\//) { 
# 		print "this is and ending tag: $line\n";
# 	} else { 
# 		push @beginning_tags, $line;
# 	}
# }

# print "beginning tags!"; 
# print @beginning_tags;




