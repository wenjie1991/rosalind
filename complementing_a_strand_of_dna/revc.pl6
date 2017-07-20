#!/usr/bin/env perl6

my $dna=$*IN.lines;
revc($dna).say;

sub revc($dna is copy){
    $dna = $dna.flip;
    return ($dna ~~ tr/TCGA/AGCT/).after;
}

