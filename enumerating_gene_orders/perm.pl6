#!/usr/bin/env perl6

#my $n = 3;
my $n = $*IN.lines[0].trim;
my @combinations = (1..$n).permutations;
say @combinations.elems;
say .join(" ") for @combinations;


multi MAIN(Bool :$man!)
{
    run $*EXECUTABLE, '--doc', $*PROGRAM;
}

=begin pod
=head1 Description

=para
Enumerating Gene Orders
L<http://rosalind.info/problems/perm/>

=head1 Example Input and Output

=head2 Input

=begin code
3
=end code

=head2 Output

=begin code
6
1 2 3
1 3 2
2 1 3
2 3 1
3 1 2
3 2 1
=end code
=end pod

