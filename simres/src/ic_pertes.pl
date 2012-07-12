#!/usr/bin/perl

# Script de calcul d'intervalles de confiance (pour le taux de pertes)

use strict;
no strict 'refs';
use List::Util;

sub usage;
sub avg;
sub variance;
sub stddev;

usage if scalar(@ARGV) < 2;

my ($block_time, $total_time) = @ARGV;

my (@v_droprate, @v_video, @v_data, @v_voice);

my %v = ( 
    global => \@v_droprate,
    video => \@v_video,
    data => \@v_data,
    voice => \@v_voice,
);

my ($prev_drop, $prev_recv) = (0, 0);
my @oldF;
foreach (<STDIN>)
{
    # Passer à la ligne suivante si la ligne commence par un commentaire
    next if /^#/;

    # Supprimer d'éventuels commentaires en fin de ligne
    s/#.*$//; 

    # Récupérer les infos d'une ligne en un seul coup
    my @F = split;

    # Chaque élément du tableau @F contient un élément (un peu comme awk, en gros)

    # On soustrait à chaque élément les anciennes valeurs pour avoir les stats
    # pendant la période considérée
    $F[$_] -= $oldF[$_] for (0..$#F);

    # Je sais qu'on dit "two or more, use a for", mais tant pis ici.
    push @v_droprate, $F[2] ? $F[1] / $F[2] : 0;
    push @v_video,    $F[4] ? $F[3] / $F[4] : 0;
    push @v_data,     $F[6] ? $F[5] / $F[6] : 0;
    push @v_voice,    $F[8] ? $F[7] / $F[8] : 0;

    @oldF = @F;
}


print '#';
foreach my $n_tab qw(global video data voice)
{
    print "${n_tab}_moy ${n_tab}_epsilon "
}
print "\n";
foreach my $n_tab qw(global video data voice)
{
    my $r_tab       = $v{$n_tab};
    my $n           = scalar(@$r_tab);
    my $avg         = avg(@$r_tab);
    my $stddev      = stddev(@$r_tab);
    my $amplitude   = 4.5 * $stddev * sqrt ($block_time / $total_time);
    
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

# vi:ts=4:et:sw=4:
