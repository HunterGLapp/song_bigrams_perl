######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  Hunter Lapp			
#  hunterlapp@gmail.com		
#										
#########################################
#use strict;
#use warnings;

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


# YOUR VARIABLE DEFINITIONS HERE...

# This loops through each line of the file
while($line = <INFILE>) {
    my $title = $line;
    #trim everything after certain characters
    $title =~ s/.*>//;       #trim everything after '>'
    $title =~ s/\(.*//;      #trim parentheticals
    $title =~ s/\[.*//;      #trim bracketed text
    $title =~ s/\{.*//;      #trim braced text
    $title =~ s/\\.*//;      #trim text starting with \
    $title =~ s/\/.*//;      #trim text starting with /
    $title =~ s/_.*//;      #trim text starting with _
    $title =~ s/-.*//;
    $title =~ s/:.*//;
    $title =~ s/".*//;
    $title =~ s/`.*//;
    $title =~ s/\+.*//;
    $title =~ s/=.*//;
    $title =~ s/\*.*//;
    $title =~ s/feat\..*//;
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

    
    print $title;
}

# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";


# User control loop
print "Enter a word [Enter 'q' to quit]: ";
$input = <STDIN>;
chomp($input);
print "\n";	
while ($input ne "q"){
	# Replace these lines with some useful code
	print "Not yet implemented.  Goodbye.\n";
	$input = 'q';
}

# MORE OF YOUR CODE HERE....
