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
	my @words = split( /\s+/, $title);
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

sub mcw {
    my ($searchWord) = @_;
    my @frequencies;
    my @wordVals;
    %currentHash = %{$counts{$searchWord}};
    foreach my $nextWord (sort { $currentHash{$b} <=> $currentHash{$a} } keys %currentHash)
    {
	push @wordVals, $nextWord;
	push @frequencies, $currentHash{$nextWord};
    }
    if (! %currentHash)
    {
	return "";
    }
    if ($frequencies[0] > $frequencies[1])
    {
	return $wordVals[0];
    }
    else
    {
	@candidates;
	push @candidates, $wordVals[0];
	my $i = 0;
	while($i < $#arr)
	{
	    if ($frequencies[$i + 1] == $frequencies[$i])
	    {
		push @candidates, $wordVals[$i + 1];
	    }
	}
	return $candidates[rand @candidates];
    }    
}

sub buildTitle
{
    my ($startWord) = @_;
    my @words;
    my $nextWord;
    push @words, $startWord;
    do
    {
	$nextWord = mcw($words[-1]);
	push @words, $nextWord;   
    } until (($#words >= 20) || ($nextWord eq ""));
    return join(" ", @words);
    
}

sub printHash
{
    my ($input) = @_;
    %currentHash = %{$counts{$input}};
    for my $key (keys %currentHash)
    {
	my $value = $currentHash{$key};
	print "$key, $value\n";
    }
}

print "\n";
print "File parsed. Bigram model built.\n\n";

#print Dumper (\%counts);
# User control loop
	
my $finish = 0;
while(! $finish)
{
    print "\n";
    print "Enter a word [Enter 'q' to quit]: ";
    print "\n";
    my $input = <STDIN>;
    chomp($input);
    printHash($input);
    print buildTitle($input);
    if ($input eq "q")
    {
	$finish = 1;
    }
}
