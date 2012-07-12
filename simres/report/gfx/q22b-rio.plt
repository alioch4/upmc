set terminal postscript eps enhanced 9
set output "q22b-rio.eps"
set size 0.36,0.4
set lmargin 11
set rmargin 2

set xlabel 'min'
set ylabel 'Taux de perte'

set logscale y

set xrange [ 0 : 300 ]

set arrow from 0,1e-4 to 300,1e-4 nohead ls 2
plot '../../src/out-q22b-rioc2/result' \
    u 1:2:3 w yerrorbars t 'Global' lc rgb '#ff0000', \
  '' u 1:4:5 w yerrorbars t 'Video' lc rgb '#009900', \
  '' u 1:6:7 w yerrorbars t 'Donnees' lc rgb '#0044cc', \
  '' u 1:8:9 w yerrorbars t 'Voix' lc rgb '#cc0099'

!epstopdf q22b-rio.eps && rm q22b-rio.eps 

# vi:ft=gnuplot:ts=2:et:

