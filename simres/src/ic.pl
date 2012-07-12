#!/usr/bin/perl

# Script de calcul d'intervalles de confiance
#
# À noter qu'il faut ajouter aux moyennes obtenues le temps moyen de
# propagation pour qu'on ait des valeurs qui ressemblent à quelque
# chose.
#
# Rappel, taille moyenne des paquets :
#  - voix  : 800 bits
#  - vidéo : 8000 bits
#  - data  : 4960 bits

use strict;
no strict 'refs';
use List::Util;

sub usage;
sub avg;
sub variance;
sub stddev;

usage if scalar(@ARGV) < 2;

my ($block_time, $total_time) = @ARGV;

my (@v_all, @v_data, @v_video, @v_voice);

my %v = ( 
	all => \@v_all, 
	data => \@v_data, 
	video => \@v_video, 
	voice => \@v_voice 
);

foreach(<STDIN>)
{
	# Passer à la ligne suivante si la ligne commence par un commentaire
	next if /^#/;

	# Supprimer d'éventuels commentaires en fin de ligne
	s/#.*$//; 

	# Récupérer les infos d'une ligne en un seul coup
	my ($ts, $drop, $recv, $global, $video, $data, $voice) = split;

	push @v_all, $global;
	push @v_data, $data;
	push @v_video, $video;
	push @v_voice, $voice;
}


foreach my $n_tab qw(all data video voice)
{
	my $r_tab	= $v{$n_tab};
	my $n 		= scalar(@$r_tab);
	my $avg 	= avg(@$r_tab);
	my $stddev	= stddev(@$r_tab);
	my $amplitude	= 4.5 * $stddev * sqrt ($block_time / $total_time);
	
#	printf "=== $n_tab ===\n";
#	printf "Nb. valeurs:  %d\n",   $n;
#	printf "Moyenne:      %.6g\n", $avg;
#	printf "Écart-type:   %.6g\n", $stddev;
#	printf "Amplitude IC: %.6g\n", $amplitude;
#	printf "Intervalle de confiance: [ %.6g, %.6g ]\n", 
#		$avg - $amplitude,
#		$avg + $amplitude;
#	print "\n";

	print "$avg $amplitude ";
}
print "\n";



sub usage {
	print STDERR "usage: $0 temps_block temps_total < fichier_de_moyennes\n";
	exit 1;
}

sub avg {
	my @tab = @_;
	my $sum = 0;

	$sum += $_ foreach @tab;

	$sum /= scalar(@tab);
	return $sum;
}

sub variance {
	my @tab = @_;
	my $avg = avg(@tab);
	my $variance = 0;

	$variance += ($_ - $avg) ** 2 foreach @tab;

	$variance /= scalar(@tab);
	return $variance;
}

sub stddev {
	return sqrt variance(@_);
}
