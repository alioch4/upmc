#!/usr/bin/env perl

use strict;
use warnings;

use Template;

my $tt = Template->new;

# Nom du template à utiliser
my $file = $ARGV[0] || 'sim.tpl';

# @sim_data est un tableau de hashs.  Chaque élément du tableau
# est un hash qui répertorie des paires de clés/valeurs (tel un
# dictionnaire), et qui serviront à peupler le template.
# Dans le template, on donne les variables avec des balises, par
# exemple [% foobar %].

#my @sim_data = ();
#push @sim_data, { queue => { wrr => 1 }, video => { burstiness => $_ } } for (3..20);

my @sim_data = (
        { lambda => 25_000_000 },
        { lambda => 30_000_000 },
        { lambda => 35_000_000 },
        { lambda => 40_000_000 },
        { lambda => 45_000_000 },
        { lambda => 50_000_000 },
        { lambda => 55_000_000 },
        { lambda => 60_000_000 },
        { lambda => 65_000_000 },
        { lambda => 70_000_000 }
);


# Maintenant, pour chaque simulation, on va écrire un fichier rempli
# avec les variables du template.
my $i;

for ($i = 0; $i <= $#sim_data; $i++)
{
	my $ref_vars = $sim_data[$i];

	# Le fichier généré va être placé dans un script qu'on va appeler
	# sim-0.tcl (si le nom d'origine est sim.tcl), le suivant dans
	# sim-1.tcl, puis sim-2.tcl, etc.

	# Génération du nom de fichier
	my $new_file = $file;
	$new_file =~ s/\./-$i\./;
	$new_file =~ s/tpl$/tcl/;

	# Génération du nom de fichier de trace
	my $log_file = "log/${new_file}";
	$log_file =~ s/tcl$/log/;

	# On ajoute la variable "logfile" pour Template::Toolkit
	$ref_vars->{logfile} = $log_file;

	# On fait péter Template::Toolkit
	print STDERR "Generating $new_file...";
	$tt->process($file, $ref_vars, $new_file) or die $tt->error;
	chmod 0755, $new_file;
	print STDERR "\n";
}
