######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  Hunter Lapp			
#  hunterlapp@gmail.com		
#										
#########################################
#use strict;
#use warnings;
use Data::Dumper qw(Dumper);

# Replace the string value of the following variable with your names.
my $name = "Hunter Lapp";
print "CSCI 305 Lab 1 submitted by $name.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";

my $numLines = 0; #a count of the number of lines read in

my %counts; #initialize the hash of hashes

# This loops through each line of the file
while($line = <INFILE>) {
    my $title = $line;
    #trim everything after certain characters
    $title =~ s/.*>//;       #trim everything after '>'
    $title =~ s/\(.*//;      #trim parentheticals
    $title =~ s/\[.*//;      #trim bracketed text
    $title =~ s/\{.*//;      #trim braced text
    $title =~ s/\\.*//;      #trim text starting with \
    $title =~ s/\/.*//;      #'''' /
    $title =~ s/_.*//;       #'''' _
    $title =~ s/-.*//;       #'''' -
    $title =~ s/:.*//;       #'''' :
    $title =~ s/".*//;       #'''' "
    $title =~ s/`.*//;       #'''' `
    $title =~ s/\+.*//;      #'''' +
    $title =~ s/=.*//;       #'''' =
    $title =~ s/\*.*//;      #'''' *
    $title =~ s/feat\..*//;  #'''' feat.

    #remove certain characters from titles (global)
    $title =~ s/\?//g;  
    $title =~ s/¿//g;
    $title =~ s/!//g;
    $title =~ s/¡//g;
    $title =~ s/\.//g;
    $title =~ s/\;//g;
    $title =~ s/\&//g;
    $title =~ s/\$//g;
    $title =~ s/\@//g;
    $title =~ s/\%//g;
    $title =~ s/\#//g;
    $title =~ s/\|//g;

    #add only titles with english characters only
    if ($title =~ /[\x80-\xFF]/)
    {
	#non-ascii char found
    }
    else
    {
	$title = lc($title);
	my @words = split( /\W+/, $title);
	for my $i (0 .. $#words - 1)
	{
	    my $curr = $words[$i];
	    my $following = $words[$i + 1];
	    if (exists $counts{$curr}{$following})
	    {
		$counts{$curr}{$following} += 1;
	    }
	    else
	    {
		$counts{$curr}{$following} = 1;
	    }
	}
	$numLines = $numLines + 1;
    }
}

# Close the file handle
close INFILE; 


# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print $numLines;
print "\n";
print "File parsed. Bigram model built.\n\n";

#print Dumper (\%counts);
# User control loop
	
my $finish = 0;
while(! $finish)
{
    print "Enter a word [Enter 'q' to quit]: ";
    print "\n";
    my $input = <STDIN>;
    chomp($input);
    %currentHash = %{$counts{$input}};
    for my $key (keys %currentHash)
    {
	my $value = $currentHash{$key};
	print "$key, $value\n";
    }
    if ($input == "q")
    {
	$finish = 1;
    }
}


# MORE OF YOUR CODE HERE....
