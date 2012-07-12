#!/usr/bin/perl

use strict;
use List::Util;

sub usage;

usage if scalar(@ARGV) < 2;

my ($block_time, $total_time) = @ARGV;

my @values;
my $avg = 0;
my $n = 0;

foreach(<STDIN>)
{
	my @F = split;

	push @values, $F[2];
	$avg = $F[1];
	$n++;
}

my $variance = 0;

foreach (@values)
{
	$variance += ($avg - $_) ** 2;
}
$variance /= $n;

my $stddev = sqrt $variance;
my $amplitude = $stddev * 4.5 * sqrt ($block_time / $total_time);

printf "Nb. valeurs:  %d\n",   $n;
printf "Moyenne:      %.6f\n", $avg;
printf "Écart-type:   %.6f\n", $stddev;
printf "Amplitude IC: %.6f\n", $amplitude;
printf "Intervalle de confiance: [ %.6f, %.6f ]\n", 
	$avg - $amplitude,
	$avg + $amplitude;


sub usage {
	print STDERR "usage: $0 temps_block temps_total < fichier_de_moyennes\n";
	exit 1;
}
