#!/usr/bin/env perl6



grammar FASTA::Grammar::DNA {
    token TOP { <record>+ }
    token record { ">"<id><comment>?"\n"<sequence> }
    token id { <-[\ \n]>+ }
    token comment { " "<-[\n]>+ }
    token sequence { <[ACGT\-\n]>+ }
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

multi MAIN() {
    my $fasta = $*IN.slurp;
    my @seqs = FASTA::Grammar::DNA.parse($fasta, actions => FASTA::Actions).made.map({$_<sequence>});

    my $shortest_seq = @seqs[@seqs.map({$_.chars}).minpairs[0].keys[0]];
    my $motif_length = 0;
    my $longest_motif = "";

    for 0..($shortest_seq.chars - $longest_motif.chars) -> $i {
        for ($longest_motif.chars)..($shortest_seq.chars - $i) -> $j {
            my $substring = $shortest_seq.substr($i, $j);
            my $vote = @seqs.map({ $_.contains($substring) ?? 1 !! last }).sum;
#        my $vote = @seqs.map({ $_ !~~ /$substring/ ?? (last) !! 1 }).sum;
#        my $vote = @seqs.map({defined index($_, $substring) ?? 1 !! last }).sum;
            if ($vote == @seqs.elems) {
                $longest_motif = $substring if $substring.chars > $longest_motif.chars;
            }
        }
    }

    say $longest_motif;
}

multi MAIN(Bool :$man!)
{
    run $*EXECUTABLE, '--doc', $*PROGRAM;
}

=begin pod
=head1 Description

=para
Finding a Shared Motif
L<http://rosalind.info/problems/lcsm/>

=head1 Example Input and Output

=head2 Input

=begin code
>Rosalind_1
GATTACA
>Rosalind_2
TAGACCA
>Rosalind_3
ATACA
=end code

=head2 Output

=begin code
AC
=end code
=end pod

