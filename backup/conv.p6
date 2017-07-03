#!/usr/bin/env perl6
use v6;

my $sample_input = Q{186.07931 287.12699 548.20532 580.18077 681.22845 706.27446 782.27613 968.35544 968.35544
101.04768 158.06914 202.09536 318.09979 419.14747 463.17369};

my @picks = $sample_input.split(/\n/);

my %conv; %conv{$_}++ for (@picks[0].split(/\s+/) X- @picks[1].split(/\s+/));
.say for %conv.max(:by(*.value)).kv.reverse;


