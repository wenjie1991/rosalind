#!/usr/bin/env perl6

multi MAIN() {
    my ($ref, $query) = $*IN.lines[0, 1];
    $ref ~~ m:ov/$query/;
    @$/.map({$_.from + 1}).join(" ").say;
}

multi MAIN(Bool :$man!)
{
    run $*EXECUTABLE, '--doc', $*PROGRAM;
}

=begin pod
=head1 Description

=para
Finding a Motif in DNA
L<http://rosalind.info/problems/subs/>

=head1 Example Input and Output

=head2 Input

=begin code
GATATATGCATATACTT
ATAT
=end code

=head2 Output

=begin code
2 4 10
=end code
=end pod

