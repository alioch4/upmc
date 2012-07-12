set terminal postscript eps enhanced 9
set output "q21.eps"
set size 0.36,0.4
set lmargin 12
set rmargin 2

set style data histogram
set style histogram cluster gap 1
set style fill solid 1.00 border 0
set boxwidth 0.9

set yrange [ 0 : 1.1e-04 ]

set ylabel 'Delai'

plot '../../src/out-q21/result' \
		 u 2:xtic(1) t 'Global' ls 1 lc rgb '#ff0000', \
	'' u 4 t 'Video' ls 1 lc rgb '#009900', \
	'' u 6 t 'Donnees' ls 1 lc rgb '#0044cc', \
	'' u 8 t 'Voix' ls 1 lc rgb '#cc0099'

!epstopdf q21.eps && rm q21.eps

# vi:ft=gnuplot:ts=2:
