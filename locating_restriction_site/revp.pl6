#!/usr/bin/env perl6

my $fasta = $*IN.slurp;

grammar FASTA::Grammar {
    token TOP { <record>+ }
    token record { ">"<id><comment>?"\n"<sequence> }
    token id { <-[\ \n]>+ }
    token comment { " "<-[\n]>+ }
    token sequence { <[A..Z\-\n]>+ }
}

class FASTA::Actions {
    method TOP ($/) {
        make $<record>>>.made;
    }
    method record ($/) {
        make {
            id => ~$<id>,
            comment => ($<comment>) ?? (~$<commnet>).trim !! '',
            sequence => $<sequence>.subst("\n", "", :g)
        };
    }
}

my @seqs = FASTA::Grammar.parse($fasta, actions => FASTA::Actions).made.map({$_<sequence>});
my $dna = @seqs[0];


sub revc($dna is copy){
    $dna = $dna.flip;
    ($dna ~~ tr/TCGA/AGCT/).join;
}

my @mer = 4,6...12;
for @mer -> $length {
    (0..($dna.chars - $length)).map({
        my $kmer = $dna.substr($_, $length);
        if $kmer eq revc($kmer) {
            say [$_ + 1, $length].join(" ");
        }
    });
}
